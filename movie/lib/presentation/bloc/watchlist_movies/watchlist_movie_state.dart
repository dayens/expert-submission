import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object?> get props => [];
}

class WatchlistMovieEmpty extends WatchlistMovieState {}

class WatchlistMovieLoading extends WatchlistMovieState {}

class WatchlistMovieError extends WatchlistMovieState {
  final String message;

  const WatchlistMovieError(this.message);

  @override
  List<Object?> get props => [message];
}

class WatchlistMovieHasStatus extends WatchlistMovieState {
  final bool status;

  const WatchlistMovieHasStatus(this.status);

  @override
  List<Object?> get props => [status];
}

class WatchlistMovieMessage extends WatchlistMovieState {
  final String message;

  const WatchlistMovieMessage(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMovieHasList extends WatchlistMovieState {
  final List<Movie> movie;

  const WatchlistMovieHasList(this.movie);

  @override
  List<Object?> get props => [movie];
}
