// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/entities/tvseries.dart';
import 'package:tvseries/domain/usecases/get_airing_today_tvseries.dart';
import 'package:tvseries/domain/usecases/get_popular_tvseries.dart';
import 'package:tvseries/domain/usecases/get_top_rated_tvseries.dart';
import 'package:tvseries/presentation/bloc/tvseries/tvseries_bloc.dart';
import 'package:tvseries/presentation/bloc/tvseries/tvseries_event.dart';
import 'package:tvseries/presentation/bloc/tvseries/tvseries_state.dart';
import 'tvseries_bloc_test.mocks.dart';

@GenerateMocks(
    [GetAiringTodayTvSeries, GetPopularTvSeries, GetTopRatedTvSeries])
void main() {
  late AiringTodayTvSeriesBloc airingTodayBloc;
  late MockGetAiringTodayTvSeries mockGetAiringTodayTvSeries;

  late PopularTvSeriesBloc popularTvSeriesBloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  late TopRatedTvSeriesBloc topRatedTvSeriesBloc;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetAiringTodayTvSeries = MockGetAiringTodayTvSeries();
    airingTodayBloc = AiringTodayTvSeriesBloc(mockGetAiringTodayTvSeries);

    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvSeriesBloc = PopularTvSeriesBloc(mockGetPopularTvSeries);

    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    topRatedTvSeriesBloc = TopRatedTvSeriesBloc(mockGetTopRatedTvSeries);
  });

  test('initial state should be empty', () {
    expect(airingTodayBloc.state, AiringTodayTvSeriesEmpty());
  });

  test('initial state should be empty', () {
    expect(popularTvSeriesBloc.state, PopularTvSeriesEmpty());
  });

  test('initial state should be empty', () {
    expect(topRatedTvSeriesBloc.state, TopRatedTvSeriesEmpty());
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
      voteCount: 1);

  final tTvSeriesList = <TvSeries>[tTvSeriesModel];

  //Airing Today Test
  blocTest<AiringTodayTvSeriesBloc, AiringTodayTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetAiringTodayTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return airingTodayBloc;
    },
    act: (bloc) => bloc.add(AiringTodayTvSeries()),
    expect: () => [
      AiringTodayTvSeriesLoading(),
      AiringTodayTvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetAiringTodayTvSeries.execute());
    },
  );

  blocTest<AiringTodayTvSeriesBloc, AiringTodayTvSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetAiringTodayTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return airingTodayBloc;
    },
    act: (bloc) => bloc.add(AiringTodayTvSeries()),
    expect: () => [
      AiringTodayTvSeriesLoading(),
      const AiringTodayTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetAiringTodayTvSeries.execute());
    },
  );

  //Popular Today Test
  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return popularTvSeriesBloc;
    },
    act: (bloc) => bloc.add(PopularTvSeries()),
    expect: () => [
      PopularTvSeriesLoading(),
      PopularTvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    },
  );

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularTvSeriesBloc;
    },
    act: (bloc) => bloc.add(PopularTvSeries()),
    expect: () => [
      PopularTvSeriesLoading(),
      const PopularTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    },
  );

  //TopRated Today Test
  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return topRatedTvSeriesBloc;
    },
    act: (bloc) => bloc.add(TopRatedTvSeries()),
    expect: () => [
      TopRatedTvSeriesLoading(),
      TopRatedTvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvSeries.execute());
    },
  );

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedTvSeriesBloc;
    },
    act: (bloc) => bloc.add(TopRatedTvSeries()),
    expect: () => [
      TopRatedTvSeriesLoading(),
      const TopRatedTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvSeries.execute());
    },
  );
}
