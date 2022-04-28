import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/watchlist_movies/watchlist_movie_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movies/watchlist_movie_state.dart';
import 'package:movie/presentation/pages/watchlist/watchlist_movies_page.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/pages_test_helpers.dart';

void main() {
  late FakeWatchlistMoviesBloc fakeWatchlistMoviesBloc;

  setUpAll(() {
    fakeWatchlistMoviesBloc = FakeWatchlistMoviesBloc();
    registerFallbackValue(FakeWatchlistMoviesEvent());
    registerFallbackValue(FakeWatchlistMoviesState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMovieBloc>(
      create: (_) => fakeWatchlistMoviesBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  tearDown(() => fakeWatchlistMoviesBloc.close());

  testWidgets('page should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeWatchlistMoviesBloc.state)
        .thenReturn(WatchlistMovieLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets(
      'should display AppBar, ListView, MovieCard, and WatchlistMoviesPage when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeWatchlistMoviesBloc.state)
        .thenReturn(WatchlistMovieHasList(testMovieList));
    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));
    await tester.pump();

    expect(find.byType(Padding), findsWidgets);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(MovieCard), findsOneWidget);
    expect(find.byKey(const Key('watchlist_movies_content')), findsOneWidget);
  });

  testWidgets('should display text with message when error',
      (WidgetTester tester) async {
    const errorMessage = 'error message';

    when(() => fakeWatchlistMoviesBloc.state)
        .thenReturn(const WatchlistMovieError(errorMessage));

    final textMessageKeyFinder = find.byKey(const Key('error_message'));
    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));
    await tester.pump();

    expect(textMessageKeyFinder, findsOneWidget);
  });
}
