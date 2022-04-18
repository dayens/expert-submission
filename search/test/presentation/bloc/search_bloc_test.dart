import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tvseries.dart';
import 'package:search/presentation/bloc/search/search_bloc.dart';
import 'package:search/presentation/bloc/search/search_event.dart';
import 'package:search/presentation/bloc/search/search_state.dart';
import 'package:tvseries/domain/entities/tvseries.dart';
import 'search_bloc_test.mocks.dart';


@GenerateMocks([SearchMovies,SearchTvSeries])
void main() {
  late SearchBlocMovie searchBloc;
  late MockSearchMovies mockSearchMovies;
  late MockSearchTvSeries mockSearchTvSeries;
  late SearchBlocTvSeries searchBlocTv;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchBloc = SearchBlocMovie(mockSearchMovies);
    mockSearchTvSeries = MockSearchTvSeries();
    searchBlocTv = SearchBlocTvSeries(mockSearchTvSeries);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchEmpty());
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'spiderman';


  final tTvSeriesModel = TvSeries(
      backdropPath: '',
      firstAirDate: '',
      genreIds: [],
      id: 1,
      name: '',
      originCountry: [],
      originalLanguage: '',
      originalName: '',
      overview: '',
      popularity: 1,
      posterPath: '',
      voteAverage: 1,
      voteCount: 1
  );
  final tTvSeriesList = <TvSeries>[tTvSeriesModel];
  const tQueryTv = 'halo';


  //Search Movies Test
  blocTest<SearchBlocMovie, SearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );

  blocTest<SearchBlocMovie, SearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );

  //Search TvSeries Test

  blocTest<SearchBlocTvSeries, SearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvSeries.execute(tQueryTv))
          .thenAnswer((_) async => Right(tTvSeriesList));
      return searchBlocTv;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQueryTv)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchHasDataTvSeries(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(tQueryTv));
    },
  );

  blocTest<SearchBlocTvSeries, SearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTvSeries.execute(tQueryTv))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchBlocTv;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQueryTv)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(tQueryTv));
    },
  );


}
