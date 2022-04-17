import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object?> get props => [];
}

class WatchlistMovieEmpty extends WatchlistMovieState {}

class WatchlistMovieLoading extends WatchlistMovieState {}

class WatchlistMovieError extends WatchlistMovieState {
  final String message;

  WatchlistMovieError(this.message);

  @override
  List<Object?> get props => [message];
}

class WatchlistMovieHasStatus extends WatchlistMovieState {
  final bool status;

  WatchlistMovieHasStatus(this.status);

  @override
  List<Object?> get props => [status];
}

class WatchlistMovieMessage extends WatchlistMovieState {
  final String message;

  WatchlistMovieMessage(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMovieHasList extends WatchlistMovieState {
  final List<Movie> movie;

  WatchlistMovieHasList(this.movie);

  @override
  List<Object?> get props => [movie];
}
