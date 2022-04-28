import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:movie/data/datasources/db/database_helper_movie.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:tvseries/data/datasources/db/database_helper_tvseries.dart';
import 'package:tvseries/data/datasources/tvseries_local_data_source.dart';
import 'package:tvseries/data/datasources/tvseries_remote_data_source.dart';
import 'package:tvseries/domain/repositories/tvseries_repository.dart';

@GenerateMocks([
  MovieRepository,
  TvSeriesRepository,
  MovieRemoteDataSource,
  TvSeriesRemoteDataSource,
  MovieLocalDataSource,
  TvSeriesLocalDataSource,
  DatabaseHelperMovie,
  DatabaseHelperTvSeries
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
  MockSpec<IOClient>(as: #MockIOClient)
])
void main() {}
