import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/presentation/bloc/tvseries/tvseries_bloc.dart';
import 'package:tvseries/presentation/bloc/tvseries/tvseries_state.dart';
import 'package:tvseries/presentation/pages/tvseries_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/pages_test_helpers.dart';

void main() {
  late FakeAiringTodayTvSeriesBloc fakeAiringTodayTvSeriesBloc;
  late FakePopularTvSeriesBloc fakePopularTvSeriesBloc;
  late FakeTopRatedTvSeriesBloc fakeTopRatedTvSeriesBloc;

  setUp(() {
    fakeAiringTodayTvSeriesBloc = FakeAiringTodayTvSeriesBloc();
    registerFallbackValue(FakeAiringTodayTvSeriesEvent());
    registerFallbackValue(FakeAiringTodayTvSeriesState());

    fakePopularTvSeriesBloc = FakePopularTvSeriesBloc();
    registerFallbackValue(FakePopularTvSeriesEvent());
    registerFallbackValue(FakePopularTvSeriesState());

    fakeTopRatedTvSeriesBloc = FakeTopRatedTvSeriesBloc();
    registerFallbackValue(FakeTopRatedTvSeriesEvent());
    registerFallbackValue(FakeTopRatedTvSeriesState());

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    fakeAiringTodayTvSeriesBloc.close();
    fakePopularTvSeriesBloc.close();
    fakeTopRatedTvSeriesBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AiringTodayTvSeriesBloc>(
          create: (context) => fakeAiringTodayTvSeriesBloc,
        ),
        BlocProvider<PopularTvSeriesBloc>(
          create: (context) => fakePopularTvSeriesBloc,
        ),
        BlocProvider<TopRatedTvSeriesBloc>(
          create: (context) => fakeTopRatedTvSeriesBloc,
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
    when(() => fakeAiringTodayTvSeriesBloc.state)
        .thenReturn(AiringTodayTvSeriesLoading());
    when(() => fakePopularTvSeriesBloc.state)
        .thenReturn(PopularTvSeriesLoading());
    when(() => fakeTopRatedTvSeriesBloc.state)
        .thenReturn(TopRatedTvSeriesLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const TvSeriesPage()));

    expect(circularProgressIndicatorFinder, findsNWidgets(3));
  });

  testWidgets(
      'page should display listview of NowPlayingMovies when HasData state is happen',
      (WidgetTester tester) async {
    when(() => fakeAiringTodayTvSeriesBloc.state)
        .thenReturn(AiringTodayTvSeriesHasData(testTvSeriesList));
    when(() => fakePopularTvSeriesBloc.state)
        .thenReturn(PopularTvSeriesHasData(testTvSeriesList));
    when(() => fakeTopRatedTvSeriesBloc.state)
        .thenReturn(TopRatedTvSeriesHasData(testTvSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_createTestableWidget(const TvSeriesPage()));

    expect(listViewFinder, findsWidgets);
  });

  testWidgets('page should display error with text when Error state is happen',
      (WidgetTester tester) async {
    when(() => fakeAiringTodayTvSeriesBloc.state)
        .thenReturn(const AiringTodayTvSeriesError('error'));
    when(() => fakePopularTvSeriesBloc.state)
        .thenReturn(const PopularTvSeriesError('error'));
    when(() => fakeTopRatedTvSeriesBloc.state)
        .thenReturn(const TopRatedTvSeriesError('error'));

    final errorKeyFinder = find.byKey(const Key('error'));

    await tester.pumpWidget(_createTestableWidget(const TvSeriesPage()));
    expect(errorKeyFinder, findsNWidgets(3));
  });

  testWidgets('page should not display when Empty state is happen',
      (WidgetTester tester) async {
    when(() => fakeAiringTodayTvSeriesBloc.state)
        .thenReturn(AiringTodayTvSeriesEmpty());
    when(() => fakePopularTvSeriesBloc.state)
        .thenReturn(PopularTvSeriesEmpty());
    when(() => fakeTopRatedTvSeriesBloc.state)
        .thenReturn(TopRatedTvSeriesEmpty());

    final containerFinder = find.byType(Container);

    await tester.pumpWidget(_createTestableWidget(const TvSeriesPage()));
    expect(containerFinder, findsWidgets);
  });
}
