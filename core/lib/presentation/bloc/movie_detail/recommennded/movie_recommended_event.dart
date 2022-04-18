import 'package:equatable/equatable.dart';

abstract class MovieRecommendedEvent extends Equatable {
  const MovieRecommendedEvent();

  @override
  List<Object?> get props => [];
}

class GetRecomendedId extends MovieRecommendedEvent {
  final int id;

  GetRecomendedId(this.id);

  @override
  List<Object> get props => [id];
}
