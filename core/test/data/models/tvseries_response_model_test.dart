import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/data/models/tvseries_model.dart';
import 'package:tvseries/data/models/tvseries_response.dart';
import '../../json_reader.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
    backdropPath: '',
    firstAirDate: '',
    genreIds: [1, 2],
    id: 1,
    overview: '',
    originalName: '',
    popularity: 1,
    posterPath: '',
    name: '',
    voteAverage: 1,
    voteCount: 1,
    originalLanguage: '',
    originCountry: [],
  );
  final tTvSeriesResponseModel =
      TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tTvSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/airing_today_model.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            'backdrop_path': '',
            'first_air_date': '',
            'genre_ids': [1, 2],
            'id': 1,
            'name': '',
            'origin_country': [],
            'original_language': '',
            'original_name': '',
            'overview': '',
            'popularity': 1.0,
            'poster_path': '',
            'vote_average': 1.0,
            'vote_count': 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
