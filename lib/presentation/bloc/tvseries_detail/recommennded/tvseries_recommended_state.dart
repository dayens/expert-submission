import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:equatable/equatable.dart';

abstract class TvSeriesRecommendedState extends Equatable {
  const TvSeriesRecommendedState();

  @override
  List<Object> get props => [];
}

class TvSeriesRecommendedEmpty extends TvSeriesRecommendedState {}

class TvSeriesRecommendedLoading extends TvSeriesRecommendedState {}

class TvSeriesRecommendedError extends TvSeriesRecommendedState {
  final String message;

  TvSeriesRecommendedError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesRecommendedHasData extends TvSeriesRecommendedState {
  final List<TvSeries> tvSeries;

  TvSeriesRecommendedHasData(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}
