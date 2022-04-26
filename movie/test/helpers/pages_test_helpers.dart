import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_event.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_state.dart';
import 'package:movie/presentation/bloc/movie_detail/recommennded/movie_recommended_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail/recommennded/movie_recommended_event.dart';
import 'package:movie/presentation/bloc/movie_detail/recommennded/movie_recommended_state.dart';
import 'package:movie/presentation/bloc/movies/movies_bloc.dart';
import 'package:movie/presentation/bloc/movies/movies_event.dart';
import 'package:movie/presentation/bloc/movies/movies_state.dart';
import 'package:movie/presentation/bloc/watchlist_movies/watchlist_movie_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movies/watchlist_movie_event.dart';
import 'package:movie/presentation/bloc/watchlist_movies/watchlist_movie_state.dart';

// fake now playing movies bloc
class FakeNowPlayingMoviesEvent extends Fake implements NowPlayingMoviesEvent {}

class FakeNowPlayingMoviesState extends Fake implements NowPlayingMoviesState {}

class FakeNowPlayingMoviesBloc
    extends MockBloc<NowPlayingMoviesEvent, NowPlayingMoviesState>
    implements NowPlayingMoviesBloc {}

// fake popular movies bloc
class FakePopularMoviesEvent extends Fake implements PopularMoviesEvent {}

class FakePopularMoviesState extends Fake implements PopularMoviesState {}

class FakePopularMoviesBloc
    extends MockBloc<PopularMoviesEvent, PopularMoviesState>
    implements PopularMoviesBloc {}

// fake top rated movies bloc
class FakeTopRatedMoviesEvent extends Fake implements TopRatedMoviesEvent {}

class FakeTopRatedMoviesState extends Fake implements TopRatedMoviesState {}

class FakeTopRatedMoviesBloc
    extends MockBloc<TopRatedMoviesEvent, TopRatedMoviesState>
    implements TopRatedMoviesBloc {}

// fake detail movie bloc
class FakeMovieDetailEvent extends Fake implements MovieDetailEvent {}

class FakeMovieDetailState extends Fake implements MovieDetailState {}

class FakeMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

// fake movie recommendations bloc
class FakeMovieRecommendationsEvent extends Fake
    implements MovieRecommendedEvent {}

class FakeMovieRecommendationsState extends Fake
    implements MovieRecommendedState {}

class FakeMovieRecommendationsBloc
    extends MockBloc<MovieRecommendedEvent, MovieRecommendedState>
    implements MovieRecommendedBloc {}

// fake watchlist movies bloc
class FakeWatchlistMoviesEvent extends Fake implements WatchlistMovieEvent {}

class FakeWatchlistMoviesState extends Fake implements WatchlistMovieState {}

class FakeWatchlistMoviesBloc
    extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}
