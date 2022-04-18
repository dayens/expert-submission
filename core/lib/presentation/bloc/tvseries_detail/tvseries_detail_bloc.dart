
import 'package:core/domain/usecases/get_tvseries_detail.dart';
import 'package:core/presentation/bloc/tvseries_detail/tvseries_detail_event.dart';
import 'package:core/presentation/bloc/tvseries_detail/tvseries_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail _getTvSeriesDetail;

  TvSeriesDetailBloc(this._getTvSeriesDetail) : super(TvSeriesDetailEmpty()) {
    on<TvSeriesDetailGetId>((event, emit) async {
      final id = event.id;

      emit(TvSeriesDetailLoading());

      final result = await _getTvSeriesDetail.execute(id);

      result.fold(
        (failure) {
          emit(TvSeriesDetailError(failure.message));
        },
        (data) {
          emit(TvSeriesDetailHasData(data));
        },
      );
    });
  }
}
