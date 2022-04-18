
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tvseries_local_data_source.dart';
import 'package:core/data/datasources/tvseries_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tvseries_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tvseries_repository.dart';
import 'package:core/domain/usecases/get_airing_today_tvseries.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_popular_tvseries.dart';
import 'package:core/domain/usecases/get_recommended_tvseries.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/domain/usecases/get_top_rated_tvseries.dart';
import 'package:core/domain/usecases/get_tvseries_detail.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/get_watchlist_status_tvseries.dart';
import 'package:core/domain/usecases/get_watchlist_tvseries.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/remove_watchlist_tvseries.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist_tvseries.dart';
import 'package:core/domain/usecases/search_movies.dart';
import 'package:core/domain/usecases/search_tvseries.dart';
import 'package:core/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:core/presentation/bloc/movie_detail/recommennded/movie_recommended_bloc.dart';
import 'package:core/presentation/bloc/movie_detail/watchlist/watchlist_movie_bloc.dart';
import 'package:core/presentation/bloc/movies/movies_bloc.dart';
import 'package:core/presentation/bloc/search/search_bloc.dart';
import 'package:core/presentation/bloc/tvseries/tvseries_bloc.dart';
import 'package:core/presentation/bloc/tvseries_detail/recommennded/tvseries_recommended_bloc.dart';
import 'package:core/presentation/bloc/tvseries_detail/tvseries_detail_bloc.dart';
import 'package:core/presentation/bloc/tvseries_detail/watchlist/watchlist_tvseries_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';



final locator = GetIt.instance;

void init() {
  // Bloc TvSeries
  locator.registerFactory(
    () => SearchBlocTvSeries(
      locator(),
    ),
  );
  locator.registerFactory(
    () => AiringTodayTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(() => TvSeriesDetailBloc(locator()));
  locator.registerFactory(() => TvSeriesRecommendedBloc(locator()));
  locator.registerFactory(
      () => WatchlistTvSeriesBloc(locator(), locator(), locator(), locator()));

  //BlocMovie
  locator.registerFactory(
    () => SearchBlocMovie(
      locator(),
    ),
  );
  locator.registerFactory(() => NowPlayingMoviesBloc(locator()));
  locator.registerFactory(() => PopularMoviesBloc(locator()));
  locator.registerFactory(() => TopRatedMoviesBloc(locator()));
  locator.registerFactory(() => MovieDetailBloc(locator()));
  locator.registerFactory(() => MovieRecommendedBloc(locator()));
  locator.registerFactory(
      () => WatchlistMovieBloc(locator(), locator(), locator(), locator()));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  //TvSeries
  locator.registerLazySingleton(() => GetAiringTodayTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetRecommendedTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTvSeries(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvSeriesRepository>(() =>
      TvSeriesRepositoryImpl(
          remoteDataSource: locator(), localDataSource: locator()));

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator
      .registerLazySingleton<DatabaseHelperMovie>(() => DatabaseHelperMovie());
  locator.registerLazySingleton<DatabaseHelperTvSeries>(
      () => DatabaseHelperTvSeries());

  // external
  locator.registerLazySingleton(() => http.Client());
}
