import 'package:core/presentation/widgets/tvseries_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/presentation/bloc/tvseries/tvseries_bloc.dart';
import 'package:tvseries/presentation/bloc/tvseries/tvseries_state.dart';
import 'package:tvseries/presentation/pages/top_rated_tvseries_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/pages_test_helpers.dart';

void main() {
  late FakeTopRatedTvSeriesBloc fakeTopRatedTvSeriesBloc;

  setUpAll(() {
    fakeTopRatedTvSeriesBloc = FakeTopRatedTvSeriesBloc();
    registerFallbackValue(FakeTopRatedTvSeriesEvent());
    registerFallbackValue(FakeTopRatedTvSeriesState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvSeriesBloc>(
      create: (_) => fakeTopRatedTvSeriesBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  tearDown(() => fakeTopRatedTvSeriesBloc.close());

  testWidgets('page should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeTopRatedTvSeriesBloc.state)
        .thenReturn(TopRatedTvSeriesLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvSeriesPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets(
      'should display AppBar, ListView, MovieCard, and TopRatedMoviesPage when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeTopRatedTvSeriesBloc.state)
        .thenReturn(TopRatedTvSeriesHasData(testTvSeriesList));
    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvSeriesPage()));
    await tester.pump();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TvCard), findsOneWidget);
    expect(find.byKey(const Key('top_rated_tv_content')), findsOneWidget);
  });

  testWidgets('should display text with message when error',
      (WidgetTester tester) async {
    const errorMessage = 'error message';

    when(() => fakeTopRatedTvSeriesBloc.state)
        .thenReturn(const TopRatedTvSeriesError(errorMessage));

    final textMessageKeyFinder = find.byKey(const Key('error_message'));
    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvSeriesPage()));
    await tester.pump();

    expect(textMessageKeyFinder, findsOneWidget);
  });
}
