import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movies/movies_bloc.dart';
import '../bloc/movies/movies_event.dart';
import '../bloc/movies/movies_state.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TopRatedMoviesBloc>().add(TopRatedMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
            builder: (context, state) {
          if (state is TopRatedMoviesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TopRatedMoviesHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final result = state.result[index];
                return MovieCard(result);
              },
              itemCount: state.result.length,
            );
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
      ),
    );
  }
}
