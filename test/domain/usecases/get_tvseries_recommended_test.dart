import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_recommended_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetRecommendedTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetRecommendedTvSeries(mockTvSeriesRepository);
  });

  final tId = 1;
  final tTvSeries = <TvSeries>[];

  test('should get list of TvSeries recommendations from the repository',
          () async {
        // arrange
        when(mockTvSeriesRepository.getRecommendedTvSeries(tId))
            .thenAnswer((_) async => Right(tTvSeries));
        // act
        final result = await usecase.execute(tId);
        // assert
        expect(result, Right(tTvSeries));
      });
}