// ignore_for_file: use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../domain/entities/movie_detail.dart';
import '../bloc/movie_detail/movie_detail_bloc.dart';
import '../bloc/movie_detail/movie_detail_event.dart';
import '../bloc/movie_detail/movie_detail_state.dart';
import '../bloc/movie_detail/recommennded/movie_recommended_bloc.dart';
import '../bloc/movie_detail/recommennded/movie_recommended_event.dart';
import '../bloc/movie_detail/recommennded/movie_recommended_state.dart';
import '../bloc/watchlist_movies/watchlist_movie_bloc.dart';
import '../bloc/watchlist_movies/watchlist_movie_event.dart';
import '../bloc/watchlist_movies/watchlist_movie_state.dart';

class MovieDetailPage extends StatefulWidget {
  static const routeName = '/detail-movie';

  final int id;
  const MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieDetailBloc>().add(MovieDetailGetId(widget.id));
      context.read<MovieRecommendedBloc>().add(GetRecomendedId(widget.id));
      context.read<WatchlistMovieBloc>().add(WatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAddedWatchlist = context.select<WatchlistMovieBloc, bool>((bloc) {
      if (bloc.state is WatchlistMovieHasStatus) {
        return (bloc.state as WatchlistMovieHasStatus).status;
      }
      return false;
    });

    return Scaffold(
      key: const Key('movie_detail_content'),
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
        if (state is MovieDetailLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieDetailHasData) {
          return DetailContent(state.movie, isAddedWatchlist);
        } else if (state is MovieDetailError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text('Failed'),
          );
        }
      }),
    );
  }
}

// ignore: must_be_immutable
class DetailContent extends StatefulWidget {
  final MovieDetail movie;
  bool isAddedWatchlist;

  DetailContent(this.movie, this.isAddedWatchlist, {Key? key})
      : super(key: key);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    const watchlistAddSuccessMessage = 'Added to Watchlist';
    const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.movie.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              // onPressed: () {},
                              onPressed: () {
                                if (!widget.isAddedWatchlist) {
                                  context
                                      .read<WatchlistMovieBloc>()
                                      .add(WatchlistMovieAdd(widget.movie));
                                } else {
                                  context
                                      .read<WatchlistMovieBloc>()
                                      .add(WatchlistMovieRemove(widget.movie));
                                }

                                final message = context.select<
                                    WatchlistMovieBloc,
                                    String>((value) => (value.state
                                        is WatchlistMovieHasStatus)
                                    ? (value.state as WatchlistMovieHasStatus)
                                                .status ==
                                            false
                                        ? watchlistAddSuccessMessage
                                        : watchlistRemoveSuccessMessage
                                    : !widget.isAddedWatchlist
                                        ? watchlistAddSuccessMessage
                                        : watchlistRemoveSuccessMessage);

                                if (message == watchlistAddSuccessMessage ||
                                    message == watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }

                                setState(() {
                                  widget.isAddedWatchlist =
                                      !widget.isAddedWatchlist;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.movie.genres),
                            ),
                            Text(
                              _showDuration(widget.movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<MovieRecommendedBloc,
                                    MovieRecommendedState>(
                                builder: (context, state) {
                              if (state is MovieRecommendedLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is MovieRecommendedHasData) {
                                return SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final movie = state.movie[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              MovieDetailPage.routeName,
                                              arguments: movie.id,
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: state.movie.length,
                                  ),
                                );
                              } else if (state is MovieRecommendedError) {
                                return Center(
                                  child: Text(state.message),
                                );
                              } else {
                                return const Center(
                                  child: Text('Failed'),
                                );
                              }
                            })
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
