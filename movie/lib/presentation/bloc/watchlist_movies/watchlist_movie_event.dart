import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie_detail.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class WatchlistStatus extends WatchlistMovieEvent {
  final int id;

  const WatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class WatchlistMovieAdd extends WatchlistMovieEvent {
  final MovieDetail movie;

  const WatchlistMovieAdd(this.movie);

  @override
  List<Object> get props => [movie];
}

class WatchlistMovieRemove extends WatchlistMovieEvent {
  final MovieDetail movie;

  const WatchlistMovieRemove(this.movie);

  @override
  List<Object> get props => [movie];
}

class WatchlistMovieList extends WatchlistMovieEvent {
  @override
  List<Object> get props => [];
}
