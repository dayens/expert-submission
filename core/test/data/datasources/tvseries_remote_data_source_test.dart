// import 'dart:convert';
// import 'dart:io';
// import 'package:ditonton/common/exception.dart';
// import 'package:ditonton/data/datasources/tvseries_remote_data_source.dart';
// import 'package:ditonton/data/models/tvseries_detail_model.dart';
// import 'package:ditonton/data/models/tvseries_response.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;
// import 'package:mockito/mockito.dart';
// import '../../helpers/test_helper.mocks.dart';
// import '../../json_reader.dart';
//
// void main() {
//   const API_KEY = 'api_key=789c4b97d94e98f4ac6e7d06a63f33de';
//   const BASE_URL = 'https://api.themoviedb.org/3';
//
//   late TvSeriesRemoteDataSourceImpl dataSource;
//   late MockHttpClient mockHttpClient;
//
//
//
//   setUp(() {
//     mockHttpClient = MockHttpClient();
//     dataSource = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
//
//
//   });
//
//   group('get Airing Today TvSeries', () {
//
//
//     final tTvSeriesList = TvSeriesResponse.fromJson(
//         json.decode(readJson('dummy_data/airing_today.json')))
//         .tvSeriesList;
//
//     test('should return list of TvSeries Model when the response code is 200',
//             () async {
//           // arrange
//           when(mockHttpClient
//               .get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
//               .thenAnswer((_) async =>
//               http.Response(readJson('dummy_data/airing_today.json'), 200));
//           // act
//           final result = await dataSource.getAiringTodayTvSeries();
//           // assert
//           expect(result, equals(tTvSeriesList));
//         });
//
//     test(
//         'should throw a ServerException when the response code is 404 or other',
//             () async {
//           // arrange
//           when(mockHttpClient
//               .get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
//               .thenAnswer((_) async => http.Response('Not Found', 404));
//           // act
//           final call = dataSource.getAiringTodayTvSeries();
//           // assert
//           expect(() => call, throwsA(isA<ServerException>()));
//         });
//   });
//
//   group('get Popular TvSeries', () {
//     final tTvSeriesList =
//         TvSeriesResponse.fromJson(json.decode(readJson('dummy_data/populartv.json')))
//             .tvSeriesList;
//
//     test('should return list of TvSeries when response is success (200)',
//             () async {
//           // arrange
//           when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
//               .thenAnswer((_) async =>
//               http.Response(readJson('dummy_data/populartv.json'), 200));
//           // act
//           final result = await dataSource.getPopularTvSeries();
//           // assert
//           expect(result, tTvSeriesList);
//         });
//
//     test(
//         'should throw a ServerException when the response code is 404 or other',
//             () async {
//           // arrange
//           when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
//               .thenAnswer((_) async => http.Response('Not Found', 404));
//           // act
//           final call = dataSource.getPopularTvSeries();
//           // assert
//           expect(() => call, throwsA(isA<ServerException>()));
//         });
//   });
//
//   group('get Top Rated TvSeries', () {
//     final tTvSeriesList = TvSeriesResponse.fromJson(
//         json.decode(readJson('dummy_data/top_rated_tv.json')))
//         .tvSeriesList;
//
//     test('should return list of TvSeries when response is success (200)',
//             () async {
//           // arrange
//           when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
//               .thenAnswer((_) async =>
//               http.Response(readJson('dummy_data/top_rated_tv.json'), 200, headers: {
//                 HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
//               }));
//           // act
//           final result = await dataSource.getTopRatedTvSeries();
//           // assert
//           expect(result, tTvSeriesList);
//         });
//
//     test('should throw ServerException when response code is other than 200',
//             () async {
//           // arrange
//           when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
//               .thenAnswer((_) async => http.Response('Not Found', 404));
//           // act
//           final call = dataSource.getTopRatedTvSeries();
//           // assert
//           expect(() => call, throwsA(isA<ServerException>()));
//         });
//   });
//
//   group('get TvSeries detail', () {
//     final tId = 52814;
//     final tTvSeriesDetail = TvSeriesDetailResponse.fromJson(
//         json.decode(readJson('dummy_data/tvseries_detail.json')));
//
//     test('should return movie detail when the response code is 200', () async {
//       // arrange
//       when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
//           .thenAnswer((_) async =>
//           http.Response(readJson('dummy_data/tvseries_detail.json'), 200));
//       // act
//       final result = await dataSource.getDetailTvSeries(tId);
//       // assert
//       expect(result, equals(tTvSeriesDetail));
//     });
//
//     test('should throw Server Exception when the response code is 404 or other',
//             () async {
//           // arrange
//           when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
//               .thenAnswer((_) async => http.Response('Not Found', 404));
//           // act
//           final call = dataSource.getDetailTvSeries(tId);
//           // assert
//           expect(() => call, throwsA(isA<ServerException>()));
//         });
//   });
//
//   group('get TvSeries recommendations', () {
//     final tTvSeriesList = TvSeriesResponse.fromJson(
//         json.decode(readJson('dummy_data/tvseries_recommendations.json')))
//         .tvSeriesList;
//     final tId = 52814;
//
//     test('should return list of TvSeries Model when the response code is 200',
//             () async {
//           // arrange
//           when(mockHttpClient
//               .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
//               .thenAnswer((_) async => http.Response(
//               readJson('dummy_data/tvseries_recommendations.json'), 200, headers: {
//             HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
//           }));
//           // act
//           final result = await dataSource.getRecommendedTvSeries(tId);
//           // assert
//           expect(result, equals(tTvSeriesList));
//         });
//
//     test('should throw Server Exception when the response code is 404 or other',
//             () async {
//           // arrange
//           when(mockHttpClient
//               .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
//               .thenAnswer((_) async => http.Response('Not Found', 404));
//           // act
//           final call = dataSource.getRecommendedTvSeries(tId);
//           // assert
//           expect(() => call, throwsA(isA<ServerException>()));
//         });
//   });
//
//   group('search TvSeries', () {
//     final tSearchResult = TvSeriesResponse.fromJson(
//         json.decode(readJson('dummy_data/search_halo_tvseries.json')))
//         .tvSeriesList;
//     final tQuery = 'halo';
//
//     test('should return list of TvSeries when response code is 200', () async {
//       // arrange
//       when(mockHttpClient
//           .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
//           .thenAnswer((_) async => http.Response(
//           readJson('dummy_data/search_halo_tvseries.json'), 200));
//       // act
//       final result = await dataSource.getSearchTv(tQuery);
//       // assert
//       expect(result, tSearchResult);
//     });
//
//     test('should throw ServerException when response code is other than 200',
//             () async {
//           // arrange
//           when(mockHttpClient
//               .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
//               .thenAnswer((_) async => http.Response('Not Found', 404));
//           // act
//           final call = dataSource.getSearchTv(tQuery);
//           // assert
//           expect(() => call, throwsA(isA<ServerException>()));
//         });
//   });
// }
