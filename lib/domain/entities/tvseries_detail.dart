import 'package:equatable/equatable.dart';
import '../../data/models/genre_model.dart';

class TvSeriesDetail extends Equatable {
  final bool adult;
  final String backdropPath;
  final List<GenreModel> genres;
  final int id;
  final String name;
  final String overview;
  final double popularity;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;

  TvSeriesDetail({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.name,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genres,
        id,
        name,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
