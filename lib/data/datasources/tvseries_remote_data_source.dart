import 'dart:convert';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tvseries_model.dart';
import 'package:ditonton/data/models/tvseries_response.dart';
import 'package:http/http.dart' as http;

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getAiringTodayTvSeries();
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  static const BASE_URL = 'https://api.themoviedb.org/3';
  static const API_KEY = 'api_key=789c4b97d94e98f4ac6e7d06a63f33de';

  final http.Client client;

  TvSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvSeriesModel>> getAiringTodayTvSeries() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }
}
