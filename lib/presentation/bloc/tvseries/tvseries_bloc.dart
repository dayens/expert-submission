import 'package:ditonton/domain/usecases/get_airing_today_tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_event.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiringTodayBloc extends Bloc<AiringTodayEvent, AiringTodayState> {
  final GetAiringTodayTvSeries _getAiringTodayTvSeries;

  AiringTodayBloc(this._getAiringTodayTvSeries) : super(AiringTodayEmpty()) {
    on<AiringToday>((event, emit) async {
      emit(AiringTodayLoading());
      final result = await _getAiringTodayTvSeries.execute();

      result.fold((failure) => emit(AiringTodayError(failure.message)),
          (result) => emit(AiringTodayHasData(result)));
    });
  }
}
