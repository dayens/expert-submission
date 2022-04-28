// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDatabaseHelperMovie mockDatabaseHelperMovie;

  setUp(() {
    mockDatabaseHelperMovie = MockDatabaseHelperMovie();
  });

  final testMovieTableId = testMovieTable.id;
  final futureMovieId = (_) async => testMovieTableId;

  group('Movie testing database', () {
    test('Should return movie id when inserting new whistlist a movie',
        () async {
      // arrange
      when(mockDatabaseHelperMovie.insertWatchlist(testMovieTable))
          .thenAnswer(futureMovieId);
      // act
      final result =
          await mockDatabaseHelperMovie.insertWatchlist(testMovieTable);
      // assert
      expect(result, testMovieTableId);
    });

    test('Should return movie id when removing whistlist a movie', () async {
      // arrange
      when(mockDatabaseHelperMovie.removeWatchlist(testMovieTable))
          .thenAnswer(futureMovieId);
      // act
      final result =
          await mockDatabaseHelperMovie.removeWatchlist(testMovieTable);
      // assert
      expect(result, testMovieTableId);
    });

    test('Should return movie detail table when get movie id is found',
        () async {
      // arrange
      when(mockDatabaseHelperMovie.getMovieById(testMovieTableId))
          .thenAnswer((_) async => testMovieTable.toJson());
      // act
      final result =
          await mockDatabaseHelperMovie.getMovieById(testMovieTableId);
      // assert
      expect(result, testMovieTable.toJson());
    });

    test('Should return null when get movie id is not found', () async {
      // arrange
      when(mockDatabaseHelperMovie.getMovieById(testMovieTableId))
          .thenAnswer((_) async => null);
      // act
      final result =
          await mockDatabaseHelperMovie.getMovieById(testMovieTableId);
      // assert
      expect(result, null);
    });

    test('Should return list of movie map when get watchlist movies', () async {
      // arrange
      when(mockDatabaseHelperMovie.getWatchlistMovie())
          .thenAnswer((_) async => [testMovieMap]);
      // act
      final result = await mockDatabaseHelperMovie.getWatchlistMovie();
      // assert
      expect(result, [testMovieMap]);
    });
  });
}
