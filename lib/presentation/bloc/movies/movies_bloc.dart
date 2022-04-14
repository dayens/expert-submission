import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movies/movies_event.dart';
import 'package:ditonton/presentation/bloc/movies/movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//AiringTodayTvSeries
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

// //PopularTvSeries
// class PopularTvSeriesBloc
//     extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
//   final GetPopularTvSeries _getPopularTvSeries;
//
//   PopularTvSeriesBloc(this._getPopularTvSeries)
//       : super(PopularTvSeriesEmpty()) {
//     on<PopularTvSeries>((event, emit) async {
//       emit(PopularTvSeriesLoading());
//       final result = await _getPopularTvSeries.execute();
//
//       result.fold((failure) => emit(PopularTvSeriesError(failure.message)),
//           (result) => emit(PopularTvSeriesHasData(result)));
//     });
//   }
// }
//
// //TopRatedTvSeries
// class TopRatedTvSeriesBloc
//     extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
//   final GetTopRatedTvSeries _getTopRatedTvSeries;
//
//   TopRatedTvSeriesBloc(this._getTopRatedTvSeries)
//       : super(TopRatedTvSeriesEmpty()) {
//     on<TopRatedTvSeries>((event, emit) async {
//       emit(TopRatedTvSeriesLoading());
//       final result = await _getTopRatedTvSeries.execute();
//
//       result.fold((failure) => emit(TopRatedTvSeriesError(failure.message)),
//           (result) => emit(TopRatedTvSeriesHasData(result)));
//     });
//   }
// }
