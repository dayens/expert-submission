import 'package:core/presentation/widgets/tvseries_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/presentation/bloc/tvseries/tvseries_bloc.dart';
import 'package:tvseries/presentation/bloc/tvseries/tvseries_state.dart';
import 'package:tvseries/presentation/pages/popular_tvseries_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/pages_test_helpers.dart';

void main() {
  late FakePopularTvSeriesBloc fakePopularTvSeriesBloc;

  setUpAll(() {
    fakePopularTvSeriesBloc = FakePopularTvSeriesBloc();
    registerFallbackValue(FakePopularTvSeriesEvent());
    registerFallbackValue(FakePopularTvSeriesState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvSeriesBloc>(
      create: (_) => fakePopularTvSeriesBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  tearDown(() {
    fakePopularTvSeriesBloc.close();
  });

  testWidgets('page should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakePopularTvSeriesBloc.state)
        .thenReturn(PopularTvSeriesLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvSeriesPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets(
      'should display AppBar, ListView, MovieCard, and PopularMoviesPage when data is loaded',
      (WidgetTester tester) async {
    when(() => fakePopularTvSeriesBloc.state)
        .thenReturn(PopularTvSeriesHasData(testTvSeriesList));
    await tester.pumpWidget(_makeTestableWidget(const PopularTvSeriesPage()));
    await tester.pump();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TvCard), findsOneWidget);
    expect(find.byKey(const Key('popular_tv_content')), findsOneWidget);
  });

  testWidgets('should display text with message when error',
      (WidgetTester tester) async {
    const errorMessage = 'error message';

    when(() => fakePopularTvSeriesBloc.state)
        .thenReturn(const PopularTvSeriesError(errorMessage));

    final textMessageKeyFinder = find.byKey(const Key('error_message'));
    await tester.pumpWidget(_makeTestableWidget(const PopularTvSeriesPage()));
    await tester.pump();

    expect(textMessageKeyFinder, findsOneWidget);
  });
}
