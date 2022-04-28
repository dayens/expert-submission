import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/data/models/tvseries_detail_model.dart';

void main() {
  const testTvSeriesDetailResponse = TvSeriesDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      genres: [],
      id: 1,
      name: 'name',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      voteAverage: 1,
      voteCount: 1);

  final testTvSeriesDetail = testTvSeriesDetailResponse.toEntity();
  final testTvSeriesDetailJson = testTvSeriesDetailResponse.toJson();

  group('Tv Series Detail Testing', () {
    test('Should return a subclass of Tv Series Detail entity', () {
      final result = testTvSeriesDetailResponse.toEntity();
      expect(result, testTvSeriesDetail);
    });

    test('Should become a json of Tv Series', () {
      final result = testTvSeriesDetailResponse.toJson();
      expect(result, testTvSeriesDetailJson);
    });
  });
}
