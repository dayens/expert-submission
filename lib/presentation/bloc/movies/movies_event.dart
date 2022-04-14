import 'package:equatable/equatable.dart';

//AiringTodayTvSeries
abstract class NowPlayingMoviesEvent extends Equatable {
  const NowPlayingMoviesEvent();

  @override
  List<Object> get props => [];
}

class NowPlayingMovies extends NowPlayingMoviesEvent {
  @override
  List<Object> get props => [];
}

// //PoularTvSeries
// abstract class PopularTvSeriesEvent extends Equatable {
//   const PopularTvSeriesEvent();
//
//   @override
//   List<Object> get props => [];
// }
//
// class PopularTvSeries extends PopularTvSeriesEvent {
//   @override
//   List<Object> get props => [];
// }
//
// //TopRatedTvSeries
// abstract class TopRatedTvSeriesEvent extends Equatable {
//   const TopRatedTvSeriesEvent();
//
//   @override
//   List<Object> get props => [];
// }
//
// class TopRatedTvSeries extends TopRatedTvSeriesEvent {
//   @override
//   List<Object> get props => [];
// }
