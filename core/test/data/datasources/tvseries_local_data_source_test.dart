import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/data/datasources/tvseries_local_data_source.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesLocalDataSource dataSource;
  late MockDatabaseHelperTvSeries mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelperTvSeries();
    dataSource =
        TvSeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistTv(testTvSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlistTv(testTvSeriesTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistTv(testTvSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlistTv(testTvSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTv(testTvSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlistTv(testTvSeriesTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTv(testTvSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlistTv(testTvSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });
}
