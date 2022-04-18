import 'package:equatable/equatable.dart';

import '../../../domain/entities/tvseries_detail.dart';

abstract class WatchlistTvSeriesEvent extends Equatable {
  const WatchlistTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class WatchlistStatus extends WatchlistTvSeriesEvent {
  final int id;

  WatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class WatchlistTvSeriesAdd extends WatchlistTvSeriesEvent {
  final TvSeriesDetail tvSeries;

  WatchlistTvSeriesAdd(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class WatchlistTvSeriesRemove extends WatchlistTvSeriesEvent {
  final TvSeriesDetail tvSeries;

  WatchlistTvSeriesRemove(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class WatchlistTvSeriesList extends WatchlistTvSeriesEvent {
  @override
  List<Object> get props => [];
}
