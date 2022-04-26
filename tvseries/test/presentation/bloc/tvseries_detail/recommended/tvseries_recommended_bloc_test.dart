import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_recommended_tvseries.dart';
import 'package:tvseries/presentation/bloc/tvseries_detail/recommennded/tvseries_recommended_bloc.dart';
import 'package:tvseries/presentation/bloc/tvseries_detail/recommennded/tvseries_recommended_event.dart';
import 'package:tvseries/presentation/bloc/tvseries_detail/recommennded/tvseries_recommended_state.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tvseries_recommended_bloc_test.mocks.dart';

@GenerateMocks([GetRecommendedTvSeries])
void main() {
  late MockGetRecommendedTvSeries mockGetRecommendedTvSeries;
  late TvSeriesRecommendedBloc tvSeriesRecommendedBloc;

  const testId = 1;

  setUp(() {
    mockGetRecommendedTvSeries = MockGetRecommendedTvSeries();
    tvSeriesRecommendedBloc =
        TvSeriesRecommendedBloc(mockGetRecommendedTvSeries);
  });

  test('the MovieRecommendationsEmpty initial state should be empty ', () {
    expect(tvSeriesRecommendedBloc.state, TvSeriesRecommendedEmpty());
  });

  blocTest<TvSeriesRecommendedBloc, TvSeriesRecommendedState>(
    'should emits PopularMovieLoading state and then PopularTvSeriesHasData state when data is successfully fetched..',
    build: () {
      when(mockGetRecommendedTvSeries.execute(testId))
          .thenAnswer((_) async => Right(testTvSeriesList));
      return tvSeriesRecommendedBloc;
    },
    act: (bloc) => bloc.add(const GetRecomendedId(testId)),
    expect: () => <TvSeriesRecommendedState>[
      TvSeriesRecommendedLoading(),
      TvSeriesRecommendedHasData(testTvSeriesList),
    ],
    verify: (bloc) => verify(mockGetRecommendedTvSeries.execute(testId)),
  );

  blocTest<TvSeriesRecommendedBloc, TvSeriesRecommendedState>(
    'should emits MovieRecommendationsLoading state and then TvSeriesRecommendationsError state when data is failed fetched..',
    build: () {
      when(mockGetRecommendedTvSeries.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesRecommendedBloc;
    },
    act: (bloc) => bloc.add(const GetRecomendedId(testId)),
    expect: () => <TvSeriesRecommendedState>[
      TvSeriesRecommendedLoading(),
      const TvSeriesRecommendedError('Server Failure'),
    ],
    verify: (bloc) => TvSeriesRecommendedLoading(),
  );

  blocTest<TvSeriesRecommendedBloc, TvSeriesRecommendedState>(
    'should emits TvSeriesRecommendationsLoading state and then TvSeriesRecommendationsEmpty state when data is retrieved empty..',
    build: () {
      when(mockGetRecommendedTvSeries.execute(testId))
          .thenAnswer((_) async => const Right([]));
      return tvSeriesRecommendedBloc;
    },
    act: (bloc) => bloc.add(const GetRecomendedId(testId)),
    expect: () => <TvSeriesRecommendedState>[
      TvSeriesRecommendedLoading(),
      const TvSeriesRecommendedHasData([]),
    ],
  );
}
