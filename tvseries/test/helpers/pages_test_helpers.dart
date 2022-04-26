// fake on the air Tvseries bloc
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/presentation/bloc/tvseries/tvseries_bloc.dart';
import 'package:tvseries/presentation/bloc/tvseries/tvseries_event.dart';
import 'package:tvseries/presentation/bloc/tvseries/tvseries_state.dart';
import 'package:tvseries/presentation/bloc/tvseries_detail/recommennded/tvseries_recommended_bloc.dart';
import 'package:tvseries/presentation/bloc/tvseries_detail/recommennded/tvseries_recommended_event.dart';
import 'package:tvseries/presentation/bloc/tvseries_detail/recommennded/tvseries_recommended_state.dart';
import 'package:tvseries/presentation/bloc/tvseries_detail/tvseries_detail_bloc.dart';
import 'package:tvseries/presentation/bloc/tvseries_detail/tvseries_detail_event.dart';
import 'package:tvseries/presentation/bloc/tvseries_detail/tvseries_detail_state.dart';
import 'package:tvseries/presentation/bloc/watchlist_tvseries/watchlist_tvseries_bloc.dart';
import 'package:tvseries/presentation/bloc/watchlist_tvseries/watchlist_tvseries_event.dart';
import 'package:tvseries/presentation/bloc/watchlist_tvseries/watchlist_tvseries_state.dart';

class FakeAiringTodayTvSeriesEvent extends Fake
    implements AiringTodayTvSeriesEvent {}

class FakeAiringTodayTvSeriesState extends Fake
    implements AiringTodayTvSeriesEvent {}

class FakeAiringTodayTvSeriesBloc
    extends MockBloc<AiringTodayTvSeriesEvent, AiringTodayTvSeriesState>
    implements AiringTodayTvSeriesBloc {}

// fake popular Tvseries bloc
class FakePopularTvSeriesEvent extends Fake implements PopularTvSeriesEvent {}

class FakePopularTvSeriesState extends Fake implements PopularTvSeriesState {}

class FakePopularTvSeriesBloc
    extends MockBloc<PopularTvSeriesEvent, PopularTvSeriesState>
    implements PopularTvSeriesBloc {}

// fake top rated Tvseries bloc
class FakeTopRatedTvSeriesEvent extends Fake implements TopRatedTvSeriesEvent {}

class FakeTopRatedTvSeriesState extends Fake implements TopRatedTvSeriesState {}

class FakeTopRatedTvSeriesBloc
    extends MockBloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState>
    implements TopRatedTvSeriesBloc {}

// fake detail Tvseries bloc
class FakeTvSeriesDetailEvent extends Fake implements TvSeriesDetailEvent {}

class FakeTvSeriesDetailState extends Fake implements TvSeriesDetailState {}

class FakeTvSeriesDetailBloc
    extends MockBloc<TvSeriesDetailEvent, TvSeriesDetailState>
    implements TvSeriesDetailBloc {}

// fake Tvseries recommendations bloc
class FakeTvSeriesRecommendationsEvent extends Fake
    implements TvSeriesRecommendedEvent {}

class FakeTvSeriesRecommendationsState extends Fake
    implements TvSeriesRecommendedState {}

class FakeTvSeriesRecommendedBloc
    extends MockBloc<TvSeriesRecommendedEvent, TvSeriesRecommendedState>
    implements TvSeriesRecommendedBloc {}

// fake watchlist Tvseries bloc
class FakeWatchlistTvSeriesEvent extends Fake
    implements WatchlistTvSeriesEvent {}

class FakeWatchlistTvSeriesState extends Fake
    implements WatchlistTvSeriesState {}

class FakeWatchlistTvSeriesBloc
    extends MockBloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState>
    implements WatchlistTvSeriesBloc {}
