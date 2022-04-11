import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:equatable/equatable.dart';

abstract class AiringTodayState extends Equatable {
  const AiringTodayState();

  @override
  List<Object> get props => [];
}

class AiringTodayEmpty extends AiringTodayState {}

class AiringTodayLoading extends AiringTodayState {}

class AiringTodayError extends AiringTodayState {
  final String message;

  AiringTodayError(this.message);

  @override
  List<Object> get props => [message];
}

class AiringTodayHasData extends AiringTodayState {
  final List<TvSeries> result;

  AiringTodayHasData(this.result);

  @override
  List<Object> get props => [result];
}
