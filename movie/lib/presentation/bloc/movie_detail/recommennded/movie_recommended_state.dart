import 'package:equatable/equatable.dart';

import '../../../../domain/entities/movie.dart';

abstract class MovieRecommendedState extends Equatable {
  const MovieRecommendedState();

  @override
  List<Object> get props => [];
}

class MovieRecommendedEmpty extends MovieRecommendedState {}

class MovieRecommendedLoading extends MovieRecommendedState {}

class MovieRecommendedError extends MovieRecommendedState {
  final String message;

  MovieRecommendedError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieRecommendedHasData extends MovieRecommendedState {
  final List<Movie> movie;

  MovieRecommendedHasData(this.movie);

  @override
  List<Object> get props => [movie];
}
