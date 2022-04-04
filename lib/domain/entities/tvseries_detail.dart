import 'package:equatable/equatable.dart';

import '../../data/models/tvseries_detail_model.dart';

class TvSeriesDetail extends Equatable {

  bool adult;
  String backdropPath;
  // List<CreatedBy> createdBy;
  // List<int> episodeRunTime;
  // String firstAirDate;
  List<Genre> genres;
  // String homepage;
  int id;
  // bool inProduction;
  // List<String> languages;
  // String lastAirDate;
  // TEpisodeToAir lastEpisodeToAir;
  // String name;
  // TEpisodeToAir nextEpisodeToAir;
  // List<Network> networks;
  // int numberOfEpisodes;
  // int numberOfSeasons;
  // List<String> originCountry;
  // String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String posterPath;
  // List<dynamic> productionCompanies;
  // List<ProductionCountry> productionCountries;
  // List<Season> seasons;
  // String status;
  // String tagline;
  // String type;
  double voteAverage;
  int voteCount;

  TvSeriesDetail({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
});



  @override
  // TODO: implement props
  List<Object?> get props => [
    adult,
    backdropPath,
    genres,
    id,
    originalName,
    overview,
    popularity,
    posterPath,
    voteAverage,
    voteCount,
  ];

}