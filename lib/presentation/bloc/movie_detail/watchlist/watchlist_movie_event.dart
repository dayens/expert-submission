import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class WatchlistStatus extends WatchlistMovieEvent {
  final int id;

  WatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class WatchlistMovieAdd extends WatchlistMovieEvent {
  final MovieDetail movie;

  WatchlistMovieAdd(this.movie);

  @override
  List<Object> get props => [movie];
}

class WatchlistMovieRemove extends WatchlistMovieEvent {
  final MovieDetail movie;

  WatchlistMovieRemove(this.movie);

  @override
  List<Object> get props => [movie];
}
