import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_event.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../lib/presentation/bloc/tvseries/tvseries_bloc.dart';
import 'tvseries_bloc_test.mocks.dart';

@GenerateMocks([GetAiringTodayTvSeries])
void main() {
  late AiringTodayBloc airingTodayBloc;
  late MockGetAiringTodayTvSeries mockGetAiringTodayTvSeries;

  setUp(() {
    mockGetAiringTodayTvSeries = MockGetAiringTodayTvSeries();
    airingTodayBloc = AiringTodayBloc(mockGetAiringTodayTvSeries);
  });

  test('initial state should be empty', () {
    expect(airingTodayBloc.state, AiringTodayEmpty());
  });

  final tTvSeriesModel = TvSeries(
      backdropPath: 'backdropPath',
      firstAirDate: 'firstAirDate',
      genreIds: [],
      id: 1,
      name: 'name',
      originCountry: [],
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      voteAverage: 1,
      voteCount: 1
  );

  final tTvSeriesList = <TvSeries>[tTvSeriesModel];

  blocTest<AiringTodayBloc, AiringTodayState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetAiringTodayTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return airingTodayBloc;
    },
    act: (bloc) => bloc.add(AiringToday()),
    expect: () => [
      AiringTodayLoading(),
      AiringTodayHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetAiringTodayTvSeries.execute());
    },
  );

  blocTest<AiringTodayBloc, AiringTodayState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetAiringTodayTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return airingTodayBloc;
    },
    act: (bloc) => bloc.add(AiringToday()),
    expect: () => [
      AiringTodayLoading(),
      AiringTodayError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetAiringTodayTvSeries.execute());
    },
  );
}