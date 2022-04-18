// import 'package:dartz/dartz.dart';
// import 'package:ditonton/domain/entities/tvseries.dart';
// import 'package:ditonton/domain/usecases/search_tvseries.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
//
// import '../../helpers/test_helper.mocks.dart';
//
// void main() {
//   late SearchTvSeries usecase;
//   late MockTvSeriesRepository mockTvSeriesRepository;
//
//   setUp(() {
//     mockTvSeriesRepository = MockTvSeriesRepository();
//     usecase = SearchTvSeries(mockTvSeriesRepository);
//   });
//
//   final tTvSeries = <TvSeries>[];
//   final tQuery = 'halo';
//
//   test('should get list of TvSeries from the repository', () async {
//     // arrange
//     when(mockTvSeriesRepository.getSearchTvSeries(tQuery))
//         .thenAnswer((_) async => Right(tTvSeries));
//     // act
//     final result = await usecase.execute(tQuery);
//     // assert
//     expect(result, Right(tTvSeries));
//   });
// }
