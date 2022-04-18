// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import '../../helpers/test_helper.mocks.dart';
//
// void main() {
//   late GetAiringTodayTvSeries usecase;
//   late MockTvSeriesRepository mockTvSeriesRepository;
//
//   setUp(() {
//     mockTvSeriesRepository = MockTvSeriesRepository();
//     usecase = GetAiringTodayTvSeries(mockTvSeriesRepository);
//   });
//
//   final tTvSeries = <TvSeries>[];
//
//   test('should get list of TvSeries from the repository', () async {
//     // arrange
//     when(mockTvSeriesRepository.getAiringTodayTvSeries())
//         .thenAnswer((_) async => Right(tTvSeries));
//     // act
//     final result = await usecase.execute();
//     // assert
//     expect(result, Right(tTvSeries));
//   });
// }
