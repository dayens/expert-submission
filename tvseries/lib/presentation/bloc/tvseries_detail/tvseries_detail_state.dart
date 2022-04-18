import 'package:equatable/equatable.dart';

import '../../../domain/entities/tvseries_detail.dart';

abstract class TvSeriesDetailState extends Equatable {
  const TvSeriesDetailState();

  @override
  List<Object> get props => [];
}

class TvSeriesDetailEmpty extends TvSeriesDetailState {}

class TvSeriesDetailLoading extends TvSeriesDetailState {}

class TvSeriesDetailError extends TvSeriesDetailState {
  final String message;

  TvSeriesDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesDetailHasData extends TvSeriesDetailState {
  final TvSeriesDetail tvSeries;

  TvSeriesDetailHasData(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}
