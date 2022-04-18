import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/widgets/sub_heading.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:movie/presentation/pages/watchlist/watchlist_page.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:tvseries/presentation/pages/tvseries_page.dart';
import '../../domain/entities/movie.dart';
import 'package:core/presentation/widgets/drawer.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movies/movies_bloc.dart';
import '../bloc/movies/movies_event.dart';
import '../bloc/movies/movies_state.dart';
import 'movie_detail_page.dart';

class HomeMoviePage extends StatefulWidget {
  static const ROUTE_NAME = '/home-movie-page';

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMoviesBloc>().add(NowPlayingMovies());
      context.read<PopularMoviesBloc>().add(PopularMovies());
      context.read<TopRatedMoviesBloc>().add(TopRatedMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidgets(
        onTapMovie: () {
          Navigator.pop(context);
        },
        onTapTv: () {
          Navigator.pushReplacementNamed(context, TvSeriesPage.ROUTE_NAME);
        },
        onTapWatchlist: () {
          Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
        },
      ),
      appBar: AppBar(
        title: const Text('Movies'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
                  builder: (context, state) {
                if (state is NowPlayingMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingMoviesHasData) {
                  final result = state.result;
                  return MovieList(result);
                } else if (state is NowPlayingMoviesError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Center(
                    child: Text('Failed'),
                  );
                }
              }),
              SubHeading(
                  title: 'Popular',
                  onTap: () {
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME);
                  }),
              BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                  builder: (context, state) {
                if (state is PopularMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularMoviesHasData) {
                  final result = state.result;
                  return MovieList(result);
                } else if (state is PopularMoviesError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Center(
                    child: Text('Failed'),
                  );
                }
              }),
              SubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
                  builder: (context, state) {
                if (state is TopRatedMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedMoviesHasData) {
                  final result = state.result;
                  return MovieList(result);
                } else if (state is TopRatedMoviesError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Center(
                    child: Text('Failed'),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
