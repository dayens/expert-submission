import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object?> get props => [];
}

class AddWatchlist extends MovieDetailEvent {
  @override
  List<Object> get props => [];
}

class RemoveWatchlist extends MovieDetailEvent {
  @override
  List<Object> get props => [];
}
