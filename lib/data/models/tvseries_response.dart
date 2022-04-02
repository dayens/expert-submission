import 'package:ditonton/data/models/tvseries_model.dart';

class TvSeriesResponse {
  TvSeriesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<TvSeriesModel> results;
  int totalPages;
  int totalResults;

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) => TvSeriesResponse(
    page: json["page"],
    results: List<TvSeriesModel>.from(json["results"].map((x) => TvSeriesModel.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}