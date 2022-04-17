import 'package:ditonton/domain/usecases/get_recommended_tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries_detail/recommennded/tvseries_recommended_event.dart';
import 'package:ditonton/presentation/bloc/tvseries_detail/recommennded/tvseries_recommended_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvSeriesRecommendedBloc
    extends Bloc<TvSeriesRecommendedEvent, TvSeriesRecommendedState> {
  final GetRecommendedTvSeries _getRecommendedTvSeries;

  TvSeriesRecommendedBloc(this._getRecommendedTvSeries)
      : super(TvSeriesRecommendedEmpty()) {
    on<GetRecomendedId>((event, emit) async {
      final id = event.id;

      emit(TvSeriesRecommendedLoading());

      final result = await _getRecommendedTvSeries.execute(id);

      result.fold((failure) {
        emit(TvSeriesRecommendedError(failure.message));
      }, (data) {
        emit(TvSeriesRecommendedHasData(data));
      });
    });
  }
}
