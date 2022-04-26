import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/presentation/bloc/movie_detail/recommennded/movie_recommended_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail/recommennded/movie_recommended_event.dart';
import 'package:movie/presentation/bloc/movie_detail/recommennded/movie_recommended_state.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'movie_recommended_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MovieRecommendedBloc movieRecommendedBloc;

  const testId = 1;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendedBloc = MovieRecommendedBloc(mockGetMovieRecommendations);
  });

  test('the MovieRecommendationsEmpty initial state should be empty ', () {
    expect(movieRecommendedBloc.state, MovieRecommendedEmpty());
  });

  blocTest<MovieRecommendedBloc, MovieRecommendedState>(
    'should emits PopularMovieLoading state and then PopularMovieHasData state when data is successfully fetched..',
    build: () {
      when(mockGetMovieRecommendations.execute(testId))
          .thenAnswer((_) async => Right(testMovieList));
      return movieRecommendedBloc;
    },
    act: (bloc) => bloc.add(const GetRecomendedId(testId)),
    expect: () => <MovieRecommendedState>[
      MovieRecommendedLoading(),
      MovieRecommendedHasData(testMovieList),
    ],
    verify: (bloc) => verify(mockGetMovieRecommendations.execute(testId)),
  );

  blocTest<MovieRecommendedBloc, MovieRecommendedState>(
    'should emits MovieRecommendationsLoading state and then MovieRecommendationsError state when data is failed fetched..',
    build: () {
      when(mockGetMovieRecommendations.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieRecommendedBloc;
    },
    act: (bloc) => bloc.add(const GetRecomendedId(testId)),
    expect: () => <MovieRecommendedState>[
      MovieRecommendedLoading(),
      const MovieRecommendedError('Server Failure'),
    ],
    verify: (bloc) => MovieRecommendedLoading(),
  );

  blocTest<MovieRecommendedBloc, MovieRecommendedState>(
    'should emits MovieRecommendationsLoading state and then MovieRecommendationsEmpty state when data is retrieved empty..',
    build: () {
      when(mockGetMovieRecommendations.execute(testId))
          .thenAnswer((_) async => const Right([]));
      return movieRecommendedBloc;
    },
    act: (bloc) => bloc.add(const GetRecomendedId(testId)),
    expect: () => <MovieRecommendedState>[
      MovieRecommendedLoading(),
      const MovieRecommendedHasData([]),
    ],
  );
}
