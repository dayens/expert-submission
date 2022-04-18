import 'package:core/domain/entities/tvseries.dart';
import 'package:equatable/equatable.dart';

abstract class WatchlistTvSeriesState extends Equatable {
  const WatchlistTvSeriesState();

  @override
  List<Object?> get props => [];
}

class WatchlistTvSeriesEmpty extends WatchlistTvSeriesState {}

class WatchlistTvSeriesLoading extends WatchlistTvSeriesState {}

class WatchlistTvSeriesError extends WatchlistTvSeriesState {
  final String message;

  WatchlistTvSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class WatchlistTvSeriesHasStatus extends WatchlistTvSeriesState {
  final bool status;

  WatchlistTvSeriesHasStatus(this.status);

  @override
  List<Object?> get props => [status];
}

class WatchlistTvSeriesMessage extends WatchlistTvSeriesState {
  final String message;

  WatchlistTvSeriesMessage(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvSeriesHasList extends WatchlistTvSeriesState {
  final List<TvSeries> tvSeries;

  WatchlistTvSeriesHasList(this.tvSeries);

  @override
  List<Object?> get props => [tvSeries];
}
