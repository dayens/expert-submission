import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;

  TvSeriesTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory TvSeriesTable.fromEntity(TvSeriesDetail tvSeriesDetail) => TvSeriesTable(
    id: tvSeriesDetail.id,
    title: tvSeriesDetail.originalName,
    posterPath: tvSeriesDetail.posterPath,
    overview: tvSeriesDetail.overview,
  );

  factory TvSeriesTable.fromMap(Map<String, dynamic> map) => TvSeriesTable(
    id: map['id'],
    title: map['originalName'],
    posterPath: map['posterPath'],
    overview: map['overview'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'originalName': title,
    'posterPath': posterPath,
    'overview': overview,
  };

  TvSeries toEntity() => TvSeries.watchlist(
    id: id,
    overview: overview,
    posterPath: posterPath,
    originalName: title,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, posterPath, overview];
}