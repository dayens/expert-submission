import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/bloc/watchlist_tvseries/watchlist_tvseries_event.dart';
import 'package:tvseries/presentation/bloc/watchlist_tvseries/watchlist_tvseries_state.dart';

import '../../../domain/usecases/get_watchlist_status_tvseries.dart';
import '../../../domain/usecases/get_watchlist_tvseries.dart';
import '../../../domain/usecases/remove_watchlist_tvseries.dart';
import '../../../domain/usecases/save_watchlist_tvseries.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchListStatusTvSeries _getWatchListStatusTvSeries;
  final SaveWatchlistTv _saveWatchlistTv;
  final RemoveWatchlistTv _removeWatchlistTv;
  final GetWatchlistTvSeries _getWatchlistTvSeries;

  WatchlistTvSeriesBloc(this._getWatchListStatusTvSeries, this._saveWatchlistTv,
      this._removeWatchlistTv, this._getWatchlistTvSeries)
      : super(WatchlistTvSeriesEmpty()) {
    on<WatchlistStatus>((event, emit) async {
      final id = event.id;

      emit(WatchlistTvSeriesLoading());

      final result = await _getWatchListStatusTvSeries.execute(id);

      emit(WatchlistTvSeriesHasStatus(result));
    });

    on<WatchlistTvSeriesAdd>((event, emit) async {
      final tv = event.tvSeries;

      final result = await _saveWatchlistTv.execute(tv);

      result.fold((failure) {
        emit(WatchlistTvSeriesError(failure.message));
      }, (message) {
        emit(WatchlistTvSeriesMessage(message));
      });
    });

    on<WatchlistTvSeriesRemove>((event, emit) async {
      final tv = event.tvSeries;

      final result = await _removeWatchlistTv.execute(tv);

      result.fold((failure) {
        emit(WatchlistTvSeriesError(failure.message));
      }, (message) {
        emit(WatchlistTvSeriesMessage(message));
      });
    });

    on<WatchlistTvSeriesList>((event, emit) async {
      emit(WatchlistTvSeriesLoading());

      final result = await _getWatchlistTvSeries.execute();

      result.fold((failure) {
        emit(WatchlistTvSeriesError(failure.message));
      }, (data) {
        emit(WatchlistTvSeriesHasList(data));
      });
    });
  }
}
