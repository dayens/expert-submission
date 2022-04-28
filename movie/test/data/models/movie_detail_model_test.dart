import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie_detail_model.dart';

void main() {
  const testMovieDetailResponse = MovieDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      budget: 1,
      genres: [],
      homepage: 'homepage',
      id: 1,
      imdbId: 'imdbId',
      originalLanguage: 'originalLanguage',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      revenue: 1,
      runtime: 1,
      status: 'status',
      tagline: 'tagline',
      title: 'title',
      video: false,
      voteAverage: 1.0,
      voteCount: 1);

  final testMovieDetail = testMovieDetailResponse.toEntity();
  final testMovieDetailJson = testMovieDetailResponse.toJson();

  group('Movie Detail testing', () {
    test('Should return a subclass of movie detail entity', () {
      final result = testMovieDetailResponse.toEntity();
      expect(result, testMovieDetail);
    });

    test('Should become a json of movie', () {
      final result = testMovieDetailResponse.toJson();
      expect(result, testMovieDetailJson);
    });

    test('Should become a instance movie detail response', () {
      final result = MovieDetailResponse.fromJson(testMovieDetailJson);
      expect(result, testMovieDetailResponse);
    });
  });
}
