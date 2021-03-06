import 'package:core/common/utils.dart';

import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/watchlist_movies/watchlist_movie_bloc.dart';
import '../../bloc/watchlist_movies/watchlist_movie_event.dart';
import '../../bloc/watchlist_movies/watchlist_movie_state.dart';

class WatchlistMoviesPage extends StatefulWidget {
  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistMovieBloc>().add(WatchlistMovieList());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    context.read<WatchlistMovieBloc>().add(WatchlistMovieList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('watchlist_movies_content'),
      appBar: AppBar(
        title: const Text('Watchlist Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
            builder: (context, state) {
          if (state is WatchlistMovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistMovieHasList) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.movie[index];
                return MovieCard(movie);
              },
              itemCount: state.movie.length,
            );
          } else if (state is WatchlistMovieError) {
            return Center(
              child: Text(
                state.message,
                key: const Key('error_message'),
              ),
            );
          } else {
            return const Center(
              child: Text(''),
            );
          }
        }),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
