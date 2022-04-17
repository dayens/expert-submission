import 'package:equatable/equatable.dart';

abstract class TvSeriesDetailEvent extends Equatable {
  const TvSeriesDetailEvent();

  @override
  List<Object?> get props => [];
}

class TvSeriesDetailGetId extends TvSeriesDetailEvent {
  final int id;

  TvSeriesDetailGetId(this.id);

  @override
  List<Object> get props => [id];
}
