import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/bloc/tvseries/tvseries_event.dart';
import 'package:tvseries/presentation/bloc/tvseries/tvseries_state.dart';

import '../../../domain/usecases/get_airing_today_tvseries.dart';
import '../../../domain/usecases/get_popular_tvseries.dart';
import '../../../domain/usecases/get_top_rated_tvseries.dart';

//AiringTodayTvSeries
class AiringTodayTvSeriesBloc
    extends Bloc<AiringTodayTvSeriesEvent, AiringTodayTvSeriesState> {
  final GetAiringTodayTvSeries _getAiringTodayTvSeries;

  AiringTodayTvSeriesBloc(this._getAiringTodayTvSeries)
      : super(AiringTodayTvSeriesEmpty()) {
    on<AiringTodayTvSeries>((event, emit) async {
      emit(AiringTodayTvSeriesLoading());
      final result = await _getAiringTodayTvSeries.execute();

      result.fold((failure) => emit(AiringTodayTvSeriesError(failure.message)),
          (result) => emit(AiringTodayTvSeriesHasData(result)));
    });
  }
}

//PopularTvSeries
class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTvSeries _getPopularTvSeries;

  PopularTvSeriesBloc(this._getPopularTvSeries)
      : super(PopularTvSeriesEmpty()) {
    on<PopularTvSeries>((event, emit) async {
      emit(PopularTvSeriesLoading());
      final result = await _getPopularTvSeries.execute();

      result.fold((failure) => emit(PopularTvSeriesError(failure.message)),
          (result) => emit(PopularTvSeriesHasData(result)));
    });
  }
}

//TopRatedTvSeries
class TopRatedTvSeriesBloc
    extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  final GetTopRatedTvSeries _getTopRatedTvSeries;

  TopRatedTvSeriesBloc(this._getTopRatedTvSeries)
      : super(TopRatedTvSeriesEmpty()) {
    on<TopRatedTvSeries>((event, emit) async {
      emit(TopRatedTvSeriesLoading());
      final result = await _getTopRatedTvSeries.execute();

      result.fold((failure) => emit(TopRatedTvSeriesError(failure.message)),
          (result) => emit(TopRatedTvSeriesHasData(result)));
    });
  }
}
