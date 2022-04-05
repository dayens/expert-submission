import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/tvseries_detail_model.dart';
import 'package:ditonton/data/models/tvseries_model.dart';
import 'package:ditonton/data/repositories/tvseries_repository_impl.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTvSeriesModel = TvSeriesModel(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    originalName: 'originalName',
    popularity: 1,
    posterPath: 'posterPath',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
    originalLanguage: '',
    originCountry: [],
  );

  final tTvSeries = TvSeries(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    originalName: 'originalName',
    popularity: 1,
    posterPath: 'posterPath',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
    originalLanguage: '',
    originCountry: [],
  );

  final tTvSeriesModelList = <TvSeriesModel>[tTvSeriesModel];
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('Airing Today TvSeries', () {
    test(
        'should return remote data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getAiringTodayTvSeries())
              .thenAnswer((_) async => tTvSeriesModelList);
          // act
          final result = await repository.getAiringTodayTvSeries();
          // assert
          verify(mockRemoteDataSource.getAiringTodayTvSeries());
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvSeriesList);
        });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getAiringTodayTvSeries())
              .thenThrow(ServerException());
          // act
          final result = await repository.getAiringTodayTvSeries();
          // assert
          verify(mockRemoteDataSource.getAiringTodayTvSeries());
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getAiringTodayTvSeries())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getAiringTodayTvSeries();
          // assert
          verify(mockRemoteDataSource.getAiringTodayTvSeries());
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Popular TvSeries', () {
    test('should return TvSeries list when call to data source is success',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvSeries())
              .thenAnswer((_) async => tTvSeriesModelList);
          // act
          final result = await repository.getPopularTvSeries();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvSeriesList);
        });

    test(
        'should return server failure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvSeries())
              .thenThrow(ServerException());
          // act
          final result = await repository.getPopularTvSeries();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return connection failure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvSeries())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getPopularTvSeries();
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Top Rated TvSeries', () {
    test('should return TvSeries list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTvSeries())
              .thenAnswer((_) async => tTvSeriesModelList);
          // act
          final result = await repository.getTopRatedTvSeries();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvSeriesList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTvSeries())
              .thenThrow(ServerException());
          // act
          final result = await repository.getTopRatedTvSeries();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTvSeries())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTopRatedTvSeries();
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Get TvSeries Detail', () {
    final tId = 1;
    final tTvSeriesResponse = TvSeriesDetailResponse(
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

    test(
        'should return Movie data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getDetailTvSeries(tId))
              .thenAnswer((_) async => tTvSeriesResponse);
          // act
          final result = await repository.getDetailTvSeries(tId);
          // assert
          verify(mockRemoteDataSource.getDetailTvSeries(tId));
          expect(result, equals(Right(testTvSeriesDetail)));
        });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getDetailTvSeries(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getDetailTvSeries(tId);
          // assert
          verify(mockRemoteDataSource.getDetailTvSeries(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getDetailTvSeries(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getDetailTvSeries(tId);
          // assert
          verify(mockRemoteDataSource.getDetailTvSeries(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Get TvSeries Recommendations', () {
    final tTvSeriesList = <TvSeriesModel>[];
    final tId = 1;

    test('should return data (movie list) when the call is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getRecommendedTvSeries(tId))
              .thenAnswer((_) async => tTvSeriesList);
          // act
          final result = await repository.getRecommendedTvSeries(tId);
          // assert
          verify(mockRemoteDataSource.getRecommendedTvSeries(tId));
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, equals(tTvSeriesList));
        });

    test(
        'should return server failure when call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getRecommendedTvSeries(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getRecommendedTvSeries(tId);
          // assertbuild runner
          verify(mockRemoteDataSource.getRecommendedTvSeries(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getRecommendedTvSeries(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getRecommendedTvSeries(tId);
          // assert
          verify(mockRemoteDataSource.getRecommendedTvSeries(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Seach TvSeries', () {
    final tQuery = 'halo';

    test('should return movie list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getSearchTv(tQuery))
              .thenAnswer((_) async => tTvSeriesModelList);
          // act
          final result = await repository.getSearchTvSeries(tQuery);
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvSeriesList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getSearchTv(tQuery))
              .thenThrow(ServerException());
          // act
          final result = await repository.getSearchTvSeries(tQuery);
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getSearchTv(tQuery))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getSearchTvSeries(tQuery);
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTv(testTvSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTv(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTv(testTvSeriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTv(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist TvSeries', () {
    test('should return list of TvSeries', () async {
      // arrange
      when(mockLocalDataSource.getWatchlist())
          .thenAnswer((_) async => [testTvSeriesTable]);
      // act
      final result = await repository.getWatchlist();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvSeries]);
    });
  });
}
