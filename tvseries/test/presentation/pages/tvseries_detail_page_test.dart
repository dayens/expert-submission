import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/presentation/bloc/tvseries_detail/recommennded/tvseries_recommended_bloc.dart';
import 'package:tvseries/presentation/bloc/tvseries_detail/recommennded/tvseries_recommended_state.dart';
import 'package:tvseries/presentation/bloc/tvseries_detail/tvseries_detail_bloc.dart';
import 'package:tvseries/presentation/bloc/tvseries_detail/tvseries_detail_state.dart';
import 'package:tvseries/presentation/bloc/watchlist_tvseries/watchlist_tvseries_bloc.dart';
import 'package:tvseries/presentation/bloc/watchlist_tvseries/watchlist_tvseries_state.dart';
import 'package:tvseries/presentation/pages/tvseries_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/pages_test_helpers.dart';

void main() {
  late FakeTvSeriesDetailBloc fakeTvseriesDetailBloc;
  late FakeWatchlistTvSeriesBloc fakeWatchlistTvseriesBloc;
  late FakeTvSeriesRecommendedBloc fakeTvseriesRecommendationsBloc;

  setUpAll(() {
    fakeTvseriesDetailBloc = FakeTvSeriesDetailBloc();
    registerFallbackValue(FakeTvSeriesDetailEvent());
    registerFallbackValue(FakeTvSeriesDetailState());

    fakeWatchlistTvseriesBloc = FakeWatchlistTvSeriesBloc();
    registerFallbackValue(FakeWatchlistTvSeriesEvent());
    registerFallbackValue(FakeWatchlistTvSeriesState());

    fakeTvseriesRecommendationsBloc = FakeTvSeriesRecommendedBloc();
    registerFallbackValue(FakeTvSeriesRecommendationsEvent());
    registerFallbackValue(FakeTvSeriesRecommendationsState());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvSeriesDetailBloc>(
          create: (_) => fakeTvseriesDetailBloc,
        ),
        BlocProvider<WatchlistTvSeriesBloc>(
          create: (_) => fakeWatchlistTvseriesBloc,
        ),
        BlocProvider<TvSeriesRecommendedBloc>(
          create: (_) => fakeTvseriesRecommendationsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeTvseriesDetailBloc.close();
    fakeWatchlistTvseriesBloc.close();
    fakeTvseriesRecommendationsBloc.close();
  });

  const testId = 1;

  testWidgets('page should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeTvseriesDetailBloc.state)
        .thenReturn(TvSeriesDetailLoading());
    when(() => fakeWatchlistTvseriesBloc.state)
        .thenReturn(WatchlistTvSeriesLoading());
    when(() => fakeTvseriesRecommendationsBloc.state)
        .thenReturn(TvSeriesRecommendedLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets('should widget display which all required',
      (WidgetTester tester) async {
    when(() => fakeTvseriesDetailBloc.state)
        .thenReturn(const TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => fakeWatchlistTvseriesBloc.state)
        .thenReturn(WatchlistTvSeriesHasList(testTvSeriesList));
    when(() => fakeTvseriesRecommendationsBloc.state)
        .thenReturn(TvSeriesRecommendedHasData(testTvSeriesList));
    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: testId)));
    await tester.pump();

    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Recommendations'), findsOneWidget);
    expect(find.byKey(const Key('tvseries_detail_content')), findsOneWidget);
  });

  testWidgets(
      'should display add icon when Tvseries is not added to watchlist in watchlist button',
      (WidgetTester tester) async {
    when(() => fakeTvseriesDetailBloc.state)
        .thenReturn(const TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => fakeWatchlistTvseriesBloc.state)
        .thenReturn(const WatchlistTvSeriesHasStatus(false));
    when(() => fakeTvseriesRecommendationsBloc.state)
        .thenReturn(TvSeriesRecommendedHasData(testTvSeriesList));
    final addIconFinder = find.byIcon(Icons.add);
    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: testId)));
    await tester.pump();
    expect(addIconFinder, findsOneWidget);
  });

  testWidgets(
      'should display check icon when Tvseries is added to watchlist in watchlist button',
      (WidgetTester tester) async {
    when(() => fakeTvseriesDetailBloc.state)
        .thenReturn(const TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => fakeWatchlistTvseriesBloc.state)
        .thenReturn(const WatchlistTvSeriesHasStatus(true));
    when(() => fakeTvseriesRecommendationsBloc.state)
        .thenReturn(TvSeriesRecommendedHasData(testTvSeriesList));
    final checkIconFinder = find.byIcon(Icons.check);
    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: testId)));
    await tester.pump();
    expect(checkIconFinder, findsOneWidget);
  });
}
