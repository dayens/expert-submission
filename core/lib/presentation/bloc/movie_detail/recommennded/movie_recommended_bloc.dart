
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/presentation/bloc/movie_detail/recommennded/movie_recommended_event.dart';
import 'package:core/presentation/bloc/movie_detail/recommennded/movie_recommended_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieRecommendedBloc
    extends Bloc<MovieRecommendedEvent, MovieRecommendedState> {
  final GetMovieRecommendations _getMovieRecommendations;

  MovieRecommendedBloc(this._getMovieRecommendations)
      : super(MovieRecommendedEmpty()) {
    on<GetRecomendedId>((event, emit) async {
      final id = event.id;

      emit(MovieRecommendedLoading());

      final result = await _getMovieRecommendations.execute(id);

      result.fold((failure) {
        emit(MovieRecommendedError(failure.message));
      }, (data) {
        emit(MovieRecommendedHasData(data));
      });
    });
  }
}
