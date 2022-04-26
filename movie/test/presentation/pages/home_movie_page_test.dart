import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/movies/movies_bloc.dart';
import 'package:movie/presentation/bloc/movies/movies_state.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/pages_test_helpers.dart';

void main() {
  late FakeNowPlayingMoviesBloc fakeNowPlayingMoviesBloc;
  late FakePopularMoviesBloc fakePopularMovieBloc;
  late FakeTopRatedMoviesBloc fakeTopRatedMovieBloc;

  setUp(() {
    fakeNowPlayingMoviesBloc = FakeNowPlayingMoviesBloc();
    registerFallbackValue(FakeNowPlayingMoviesEvent());
    registerFallbackValue(FakeNowPlayingMoviesState());

    fakePopularMovieBloc = FakePopularMoviesBloc();
    registerFallbackValue(FakePopularMoviesEvent());
    registerFallbackValue(FakePopularMoviesState());

    fakeTopRatedMovieBloc = FakeTopRatedMoviesBloc();
    registerFallbackValue(FakeTopRatedMoviesEvent());
    registerFallbackValue(FakeTopRatedMoviesState());

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    fakeNowPlayingMoviesBloc.close();
    fakePopularMovieBloc.close();
    fakeTopRatedMovieBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMoviesBloc>(
          create: (context) => fakeNowPlayingMoviesBloc,
        ),
        BlocProvider<PopularMoviesBloc>(
          create: (context) => fakePopularMovieBloc,
        ),
        BlocProvider<TopRatedMoviesBloc>(
          create: (context) => fakeTopRatedMovieBloc,
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('page should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeNowPlayingMoviesBloc.state)
        .thenReturn(NowPlayingMoviesLoading());
    when(() => fakePopularMovieBloc.state).thenReturn(PopularMoviesLoading());
    when(() => fakeTopRatedMovieBloc.state).thenReturn(TopRatedMoviesLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(HomeMoviePage()));

    expect(circularProgressIndicatorFinder, findsNWidgets(3));
  });

  testWidgets(
      'page should display listview of NowPlayingMovies when HasData state is happen',
      (WidgetTester tester) async {
    when(() => fakeNowPlayingMoviesBloc.state)
        .thenReturn(NowPlayingMoviesHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(PopularMoviesHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(TopRatedMoviesHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_createTestableWidget(HomeMoviePage()));

    expect(listViewFinder, findsWidgets);
  });

  testWidgets('page should display error with text when Error state is happen',
      (WidgetTester tester) async {
    when(() => fakeNowPlayingMoviesBloc.state)
        .thenReturn(const NowPlayingMoviesError('error'));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(const PopularMoviesError('error'));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(const TopRatedMoviesError('error'));

    final errorKeyFinder = find.byKey(const Key('error'));

    await tester.pumpWidget(_createTestableWidget(HomeMoviePage()));
    expect(errorKeyFinder, findsNWidgets(3));
  });

  testWidgets('page should not display when Empty state is happen',
      (WidgetTester tester) async {
    when(() => fakeNowPlayingMoviesBloc.state)
        .thenReturn(NowPlayingMoviesEmpty());
    when(() => fakePopularMovieBloc.state).thenReturn(PopularMoviesEmpty());
    when(() => fakeTopRatedMovieBloc.state).thenReturn(TopRatedMoviesEmpty());

    final containerFinder = find.byType(Container);

    await tester.pumpWidget(_createTestableWidget(HomeMoviePage()));
    expect(containerFinder, findsWidgets);
  });
}
