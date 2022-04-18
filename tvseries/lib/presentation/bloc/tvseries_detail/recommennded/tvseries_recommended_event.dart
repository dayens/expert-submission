import 'package:equatable/equatable.dart';

abstract class TvSeriesRecommendedEvent extends Equatable {
  const TvSeriesRecommendedEvent();

  @override
  List<Object?> get props => [];
}

class GetRecomendedId extends TvSeriesRecommendedEvent {
  final int id;

  const GetRecomendedId(this.id);

  @override
  List<Object> get props => [id];
}
