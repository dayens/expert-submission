// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDatabaseHelperTvSeries mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelperTvSeries();
  });

  final testMovieTableId = testMovieTable.id;

  final testTvSeriesTableId = testTvSeriesTable.id;
  final futureTvSeriesId = (_) async => testMovieTableId;

  group('Tv Series testing database', () {
    test('Should return tv series id when inserting new whistlist a tv series',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistTv(testTvSeriesTable))
          .thenAnswer(futureTvSeriesId);
      // act
      final result =
          await mockDatabaseHelper.insertWatchlistTv(testTvSeriesTable);
      // assert
      expect(result, testTvSeriesTableId);
    });

    test('Should return tv series id when removing whistlist a tv series',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTv(testTvSeriesTable))
          .thenAnswer(futureTvSeriesId);
      // act
      final result =
          await mockDatabaseHelper.removeWatchlistTv(testTvSeriesTable);
      // assert
      expect(result, testTvSeriesTableId);
    });

    test('Should return tv series detail table when get tv series id is found',
        () async {
      // arrange
      when(mockDatabaseHelper.getTvById(testTvSeriesTableId))
          .thenAnswer((_) async => testTvSeriesTable.toJson());
      // act
      final result = await mockDatabaseHelper.getTvById(testTvSeriesTableId);
      // assert
      expect(result, testTvSeriesTable.toJson());
    });

    test('Should return null when get tv series id is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvById(testTvSeriesTableId))
          .thenAnswer((_) async => null);
      // act
      final result = await mockDatabaseHelper.getTvById(testTvSeriesTableId);
      // assert
      expect(result, null);
    });

    test('Should return list of tv series map when get watchlist Tv Series',
        () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvSeriesMap]);
      // act
      final result = await mockDatabaseHelper.getWatchlistTvSeries();
      // assert
      expect(result, [testTvSeriesMap]);
    });
  });
}
