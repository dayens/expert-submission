import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_watchlist_status_tvseries.dart';
import 'package:tvseries/domain/usecases/get_watchlist_tvseries.dart';
import 'package:tvseries/domain/usecases/remove_watchlist_tvseries.dart';
import 'package:tvseries/domain/usecases/save_watchlist_tvseries.dart';
import 'package:tvseries/presentation/bloc/watchlist_tvseries/watchlist_tvseries_bloc.dart';
import 'package:tvseries/presentation/bloc/watchlist_tvseries/watchlist_tvseries_event.dart';
import 'package:tvseries/presentation/bloc/watchlist_tvseries/watchlist_tvseries_state.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tvseries_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatusTvSeries,
  GetWatchlistTvSeries,
  RemoveWatchlistTv,
  SaveWatchlistTv
])
void main() {
  late MockGetWatchListStatusTvSeries mockGetWatchListStatusTvSeries;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late WatchlistTvSeriesBloc watchlistTvSeriesBloc;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    mockGetWatchListStatusTvSeries = MockGetWatchListStatusTvSeries();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    watchlistTvSeriesBloc = WatchlistTvSeriesBloc(
      mockGetWatchListStatusTvSeries,
      mockSaveWatchlistTv,
      mockRemoveWatchlistTv,
      mockGetWatchlistTvSeries,
    );
  });

  test('the WatchlistMoviesEmpty initial state should be empty ', () {
    expect(watchlistTvSeriesBloc.state, WatchlistTvSeriesEmpty());
  });

  group('get watchlist movies test cases', () {
    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should emits WatchlistMovieLoading state and then WatchlistMovieHasData state when data is successfully fetched..',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Right([testWatchlistTvSeries]));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(WatchlistTvSeriesList()),
      expect: () => [
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesHasList([testWatchlistTvSeries]),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvSeries.execute());
        return WatchlistTvSeriesList().props;
      },
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should emits WatchlistMoviesLoading state and then WatchlistMoviesError state when data is failed fetched..',
      build: () {
        when(mockGetWatchlistTvSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(WatchlistTvSeriesList()),
      expect: () => <WatchlistTvSeriesState>[
        WatchlistTvSeriesLoading(),
        const WatchlistTvSeriesError('Server Failure'),
      ],
      verify: (bloc) => WatchlistTvSeriesLoading(),
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should emits WatchlistMoviesLoading state and then WatchlistMoviesEmpty state when data is retrieved empty..',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => const Right([]));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(WatchlistTvSeriesList()),
      expect: () => <WatchlistTvSeriesState>[
        WatchlistTvSeriesLoading(),
        const WatchlistTvSeriesHasList([]),
      ],
    );
  });

  group('get watchlist status movies test cases', () {
    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should be return true when the watchlist is also true',
      build: () {
        when(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => true);
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(WatchlistStatus(testTvSeriesDetail.id)),
      expect: () =>
          [WatchlistTvSeriesLoading(), const WatchlistTvSeriesHasStatus(true)],
      verify: (bloc) {
        verify(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id));
        return WatchlistStatus(testTvSeriesDetail.id).props;
      },
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        'should be return false when the watchlist is also false',
        build: () {
          when(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id))
              .thenAnswer((_) async => false);
          return watchlistTvSeriesBloc;
        },
        act: (bloc) => bloc.add(WatchlistStatus(testTvSeriesDetail.id)),
        expect: () => <WatchlistTvSeriesState>[
              WatchlistTvSeriesLoading(),
              const WatchlistTvSeriesHasStatus(false),
            ],
        verify: (bloc) {
          verify(mockGetWatchListStatusTvSeries.execute(testMovieDetail.id));
          return WatchlistStatus(testMovieDetail.id).props;
        });
  });

  group('add watchlist test cases', () {
    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should update watchlist status when adding movie to watchlist is successfully',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(const WatchlistTvSeriesAdd(testTvSeriesDetail)),
      expect: () => [
        const WatchlistTvSeriesMessage('Added to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTv.execute(testTvSeriesDetail));
        return const WatchlistTvSeriesAdd(testTvSeriesDetail).props;
      },
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should throw failure message status when adding movie to watchlist is failed',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvSeriesDetail)).thenAnswer(
            (_) async =>
                const Left(DatabaseFailure('can\'t add data to watchlist')));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(const WatchlistTvSeriesAdd(testTvSeriesDetail)),
      expect: () => [
        const WatchlistTvSeriesError('can\'t add data to watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTv.execute(testTvSeriesDetail));
        return const WatchlistTvSeriesAdd(testTvSeriesDetail).props;
      },
    );
  });

  group('remove watchlist test cases', () {
    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should update watchlist status when removing movie from watchlist is successfully',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) =>
          bloc.add(const WatchlistTvSeriesRemove(testTvSeriesDetail)),
      expect: () => [
        const WatchlistTvSeriesMessage('Removed from Watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTv.execute(testTvSeriesDetail));
        return const WatchlistTvSeriesRemove(testTvSeriesDetail).props;
      },
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should throw failure message status when removie movie from watchlist is failed',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvSeriesDetail)).thenAnswer(
            (_) async =>
                const Left(DatabaseFailure('can\'t add data to watchlist')));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) =>
          bloc.add(const WatchlistTvSeriesRemove(testTvSeriesDetail)),
      expect: () => [
        const WatchlistTvSeriesError('can\'t add data to watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTv.execute(testTvSeriesDetail));
        return const WatchlistTvSeriesRemove(testTvSeriesDetail).props;
      },
    );
  });
}
