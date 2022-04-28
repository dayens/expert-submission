import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testGenreModel = GenreModel(
    id: 7,
    name: 'Comedy',
  );

  final testGenre = Genre(
    id: testGenreModel.id,
    name: testGenreModel.name,
  );

  final testGenreMap = {
    'id': 7,
    'name': 'Comedy',
  };
  group('Genre testing', () {
    test('Should be a match constructor of Genre entity', () {
      final result = testGenreModel.toEntity();
      expect(result, testGenre);
    });

    test('Should be a map of Genre', () {
      final result = testGenreModel.toJson();
      expect(result, testGenreMap);
    });

    test('Should be a match GenreMap and GenreModel', () {
      final result = GenreModel.fromJson(testGenreMap);
      expect(result, testGenreModel);
    });
  });
}
