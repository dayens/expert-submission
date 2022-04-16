import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tvseries_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tvseries_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tvseries.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:ditonton/domain/usecases/get_recommended_tvseries.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';
import 'package:ditonton/domain/usecases/get_tvseries_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_detail/recommennded/movie_recommended_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_detail/watchlist/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movies/movies_bloc.dart';
import 'package:ditonton/presentation/bloc/search/search_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_bloc.dart';
import 'package:ditonton/presentation/provider/tvseries_detail_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tvseries_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'data/datasources/tvseries_local_data_source.dart';
import 'domain/usecases/get_watchlist_status_tvseries.dart';
import 'domain/usecases/get_watchlist_tvseries.dart';
import 'domain/usecases/remove_watchlist_tvseries.dart';
import 'domain/usecases/save_watchlist_tvseries.dart';
import 'domain/usecases/search_tvseries.dart';

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

  //BlocMovie
  locator.registerFactory(
    () => SearchBlocMovie(
      locator(),
    ),
  );
  locator.registerFactory(() => NowPlayingMoviesBloc(locator()));
  locator.registerFactory(() => PopularMoviesBloc(locator()));
  locator.registerFactory(() => TopRatedMoviesBloc(locator()));
  locator.registerFactory(() => MovieDetilBloc(locator()));
  locator.registerFactory(() => MovieRecommendedBloc(locator()));
  locator.registerFactory(
      () => WatchlistMovieBloc(locator(), locator(), locator(), locator()));


  //profider Tv Series
  locator.registerFactory(
    () => TvSeriesDetailNotifier(
      getTvSeriesDetail: locator(),
      getRecommendedTvSeries: locator(),
      removeWatchlistTv: locator(),
      getWatchListStatusTvSeries: locator(),
      saveWatchlistTv: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvSeriesNotifier(getWatchlistTvSeries: locator()),
  );

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
