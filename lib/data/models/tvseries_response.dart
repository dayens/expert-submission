import 'package:ditonton/data/models/tvseries_model.dart';
import 'package:equatable/equatable.dart';

class TvSeriesResponse extends Equatable{
  TvSeriesResponse({
    required this.page,
    required this.tvSeriesList,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<TvSeriesModel> tvSeriesList;
  int totalPages;
  int totalResults;

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) => TvSeriesResponse(
    page: json["page"],
    tvSeriesList: List<TvSeriesModel>.from(json["results"].map((x) => TvSeriesModel.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(tvSeriesList.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };

  @override
  List<Object?> get props => [tvSeriesList];
}

// class TvSeriesResponse extends Equatable {
//   final List<TvSeriesModel> tvSeriesList;
//
//   TvSeriesResponse({required this.tvSeriesList});
//
//   factory TvSeriesResponse.fromJson(Map<String, dynamic> json) => TvSeriesResponse(
//     tvSeriesList: List<TvSeriesModel>.from((json["results"] as List)
//         .map((x) => TvSeriesModel.fromJson(x))
//         .where((element) => element.backdropPath != null)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "results": List<dynamic>.from(tvSeriesList.map((x) => x.toJson())),
//   };
//
//   @override
//   List<Object> get props => [tvSeriesList];
// }