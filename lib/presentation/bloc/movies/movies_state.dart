import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

//AiringTodayTvSeries
abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

class NowPlayingMoviesEmpty extends NowPlayingMoviesState {}

class NowPlayingMoviesLoading extends NowPlayingMoviesState {}

class NowPlayingMoviesError extends NowPlayingMoviesState {
  final String message;

  NowPlayingMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingMoviesHasData extends NowPlayingMoviesState {
  final List<Movie> result;

  NowPlayingMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}

// //PopularTvSeries
// abstract class PopularTvSeriesState extends Equatable {
//   const PopularTvSeriesState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class PopularTvSeriesEmpty extends PopularTvSeriesState {}
//
// class PopularTvSeriesLoading extends PopularTvSeriesState {}
//
// class PopularTvSeriesError extends PopularTvSeriesState {
//   final String message;
//
//   PopularTvSeriesError(this.message);
//
//   @override
//   List<Object> get props => [message];
// }
//
// class PopularTvSeriesHasData extends PopularTvSeriesState {
//   final List<TvSeries> result;
//
//   PopularTvSeriesHasData(this.result);
//
//   @override
//   List<Object> get props => [result];
// }
//
// //TopRatedTvSeries
// abstract class TopRatedTvSeriesState extends Equatable {
//   const TopRatedTvSeriesState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class TopRatedTvSeriesEmpty extends TopRatedTvSeriesState {}
//
// class TopRatedTvSeriesLoading extends TopRatedTvSeriesState {}
//
// class TopRatedTvSeriesError extends TopRatedTvSeriesState {
//   final String message;
//
//   TopRatedTvSeriesError(this.message);
//
//   @override
//   List<Object> get props => [message];
// }
//
// class TopRatedTvSeriesHasData extends TopRatedTvSeriesState {
//   final List<TvSeries> result;
//
//   TopRatedTvSeriesHasData(this.result);
//
//   @override
//   List<Object> get props => [result];
// }
