import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movies/movies_event.dart';
import 'package:ditonton/presentation/bloc/movies/movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//NowPlayingMovies
class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesBloc(this._getNowPlayingMovies)
      : super(NowPlayingMoviesEmpty()) {
    on<NowPlayingMovies>((event, emit) async {
      emit(NowPlayingMoviesLoading());
      final result = await _getNowPlayingMovies.execute();

      result.fold((failure) => emit(NowPlayingMoviesError(failure.message)),
          (result) => emit(NowPlayingMoviesHasData(result)));
    });
  }
}

//PopularMovies
class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies) : super(PopularMoviesEmpty()) {
    on<PopularMovies>((event, emit) async {
      emit(PopularMoviesLoading());
      final result = await _getPopularMovies.execute();

      result.fold((failure) => emit(PopularMoviesError(failure.message)),
          (result) => emit(PopularMoviesHasData(result)));
    });
  }
}

//TopRatedMovies
class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMoviesBloc(this._getTopRatedMovies) : super(TopRatedMoviesEmpty()) {
    on<TopRatedMovies>((event, emit) async {
      emit(TopRatedMoviesLoading());
      final result = await _getTopRatedMovies.execute();

      result.fold((failure) => emit(TopRatedMoviesError(failure.message)),
          (result) => emit(TopRatedMoviesHasData(result)));
    });
  }
}
