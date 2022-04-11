import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/movie.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasData extends SearchState {
  final List<Movie> result;

  SearchHasData(this.result);

  @override
  List<Object> get props => [result];
}

class SearchHasDataTvSeries extends SearchState {
  final List<TvSeries> result;

  SearchHasDataTvSeries(this.result);

  @override
  List<Object> get props => [result];
}
