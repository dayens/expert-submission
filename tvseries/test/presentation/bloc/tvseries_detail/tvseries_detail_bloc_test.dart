import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_tvseries_detail.dart';
import 'package:tvseries/presentation/bloc/tvseries_detail/tvseries_detail_bloc.dart';
import 'package:tvseries/presentation/bloc/tvseries_detail/tvseries_detail_event.dart';
import 'package:tvseries/presentation/bloc/tvseries_detail/tvseries_detail_state.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tvseries_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail])
void main() {
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late TvSeriesDetailBloc tvSeriesDetailBloc;

  const testId = 1;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    tvSeriesDetailBloc = TvSeriesDetailBloc(mockGetTvSeriesDetail);
  });
  test('the MovieDetailBloc initial state should be empty', () {
    expect(tvSeriesDetailBloc.state, TvSeriesDetailEmpty());
  });

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should emits MovieDetailLoading state and then MovieDetailHasData state when data is successfully fetched.',
      build: () {
        when(mockGetTvSeriesDetail.execute(testId))
            .thenAnswer((_) async => const Right(testTvSeriesDetail));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const TvSeriesDetailGetId(testId)),
      expect: () => <TvSeriesDetailState>[
            TvSeriesDetailLoading(),
            const TvSeriesDetailHasData(testTvSeriesDetail),
          ],
      verify: (bloc) {
        verify(mockGetTvSeriesDetail.execute(testId));
        return const TvSeriesDetailGetId(testId).props;
      });

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    'should emits MovieDetailLoading state and MovieDetailError when data is failed to fetch.',
    build: () {
      when(mockGetTvSeriesDetail.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesDetailBloc;
    },
    act: (bloc) => bloc.add(const TvSeriesDetailGetId(testId)),
    expect: () => <TvSeriesDetailState>[
      TvSeriesDetailLoading(),
      const TvSeriesDetailError('Server Failure'),
    ],
    verify: (bloc) => TvSeriesDetailLoading(),
  );
}
