import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/presentation/bloc/watchlist_movies/watchlist_movie_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movies/watchlist_movie_event.dart';
import 'package:movie/presentation/bloc/watchlist_movies/watchlist_movie_state.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks(
    [GetWatchListStatus, GetWatchlistMovies, RemoveWatchlist, SaveWatchlist])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockSaveWatchlist mockSaveWatchlist;
  late WatchlistMovieBloc watchlistMoviesBloc;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockSaveWatchlist = MockSaveWatchlist();
    watchlistMoviesBloc = WatchlistMovieBloc(
      mockGetWatchListStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
      mockGetWatchlistMovies,
    );
  });

  test('the WatchlistMoviesEmpty initial state should be empty ', () {
    expect(watchlistMoviesBloc.state, WatchlistMovieEmpty());
  });

  group('get watchlist movies test cases', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should emits WatchlistMovieLoading state and then WatchlistMovieHasData state when data is successfully fetched..',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right([testWatchlistMovie]));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(WatchlistMovieList()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieHasList([testWatchlistMovie]),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
        return WatchlistMovieList().props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should emits WatchlistMoviesLoading state and then WatchlistMoviesError state when data is failed fetched..',
      build: () {
        when(mockGetWatchlistMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(WatchlistMovieList()),
      expect: () => <WatchlistMovieState>[
        WatchlistMovieLoading(),
        const WatchlistMovieError('Server Failure'),
      ],
      verify: (bloc) => WatchlistMovieLoading(),
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should emits WatchlistMoviesLoading state and then WatchlistMoviesEmpty state when data is retrieved empty..',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => const Right([]));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(WatchlistMovieList()),
      expect: () => <WatchlistMovieState>[
        WatchlistMovieLoading(),
        const WatchlistMovieHasList([]),
      ],
    );
  });

  group('get watchlist status movies test cases', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should be return true when the watchlist is also true',
      build: () {
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(WatchlistStatus(testMovieDetail.id)),
      expect: () =>
          [WatchlistMovieLoading(), const WatchlistMovieHasStatus(true)],
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
        return WatchlistStatus(testMovieDetail.id).props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should be return false when the watchlist is also false',
        build: () {
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return watchlistMoviesBloc;
        },
        act: (bloc) => bloc.add(WatchlistStatus(testMovieDetail.id)),
        expect: () => <WatchlistMovieState>[
              WatchlistMovieLoading(),
              const WatchlistMovieHasStatus(false),
            ],
        verify: (bloc) {
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
          return WatchlistStatus(testMovieDetail.id).props;
        });
  });

  group('add watchlist test cases', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should update watchlist status when adding movie to watchlist is successfully',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(const WatchlistMovieAdd(testMovieDetail)),
      expect: () => [
        const WatchlistMovieMessage('Added to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        return const WatchlistMovieAdd(testMovieDetail).props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should throw failure message status when adding movie to watchlist is failed',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer((_) async =>
            const Left(DatabaseFailure('can\'t add data to watchlist')));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(const WatchlistMovieAdd(testMovieDetail)),
      expect: () => [
        const WatchlistMovieError('can\'t add data to watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        return const WatchlistMovieAdd(testMovieDetail).props;
      },
    );
  });

  group('remove watchlist test cases', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should update watchlist status when removing movie from watchlist is successfully',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(const WatchlistMovieRemove(testMovieDetail)),
      expect: () => [
        const WatchlistMovieMessage('Removed from Watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        return const WatchlistMovieRemove(testMovieDetail).props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should throw failure message status when removie movie from watchlist is failed',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async =>
                const Left(DatabaseFailure('can\'t add data to watchlist')));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(const WatchlistMovieRemove(testMovieDetail)),
      expect: () => [
        const WatchlistMovieError('can\'t add data to watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        return const WatchlistMovieRemove(testMovieDetail).props;
      },
    );
  });
}
