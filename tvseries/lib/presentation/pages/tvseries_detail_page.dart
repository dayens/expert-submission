// ignore_for_file: use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/data/models/genre_model.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../domain/entities/tvseries_detail.dart';
import '../bloc/tvseries_detail/recommennded/tvseries_recommended_bloc.dart';
import '../bloc/tvseries_detail/recommennded/tvseries_recommended_event.dart';
import '../bloc/tvseries_detail/recommennded/tvseries_recommended_state.dart';
import '../bloc/tvseries_detail/tvseries_detail_bloc.dart';
import '../bloc/tvseries_detail/tvseries_detail_event.dart';
import '../bloc/tvseries_detail/tvseries_detail_state.dart';
import '../bloc/watchlist_tvseries/watchlist_tvseries_bloc.dart';
import '../bloc/watchlist_tvseries/watchlist_tvseries_event.dart';
import '../bloc/watchlist_tvseries/watchlist_tvseries_state.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const routeName = '/detail-tvseries';

  final int id;
  const TvSeriesDetailPage({required this.id});

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvSeriesDetailBloc>().add(TvSeriesDetailGetId(widget.id));
      context.read<TvSeriesRecommendedBloc>().add(GetRecomendedId(widget.id));
      context.read<WatchlistTvSeriesBloc>().add(WatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAddedWatchlist =
        context.select<WatchlistTvSeriesBloc, bool>((bloc) {
      if (bloc.state is WatchlistTvSeriesHasStatus) {
        return (bloc.state as WatchlistTvSeriesHasStatus).status;
      }
      return false;
    });

    return Scaffold(
      body: BlocBuilder<TvSeriesDetailBloc, TvSeriesDetailState>(
          builder: (context, state) {
        if (state is TvSeriesDetailLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TvSeriesDetailHasData) {
          return DetailContent(state.tvSeries, isAddedWatchlist);
        } else if (state is TvSeriesDetailError) {
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
  final TvSeriesDetail tvSeries;
  late bool isAddedWatchlist;

  DetailContent(this.tvSeries, this.isAddedWatchlist);

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
          imageUrl:
              'https://image.tmdb.org/t/p/w500${widget.tvSeries.posterPath}',
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
                              widget.tvSeries.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (!widget.isAddedWatchlist) {
                                  context.read<WatchlistTvSeriesBloc>().add(
                                      WatchlistTvSeriesAdd(widget.tvSeries));
                                } else {
                                  context.read<WatchlistTvSeriesBloc>().add(
                                      WatchlistTvSeriesRemove(widget.tvSeries));
                                }

                                final message = context.select<
                                    WatchlistTvSeriesBloc,
                                    String>((value) => (value.state
                                        is WatchlistTvSeriesHasStatus)
                                    ? (value.state as WatchlistTvSeriesHasStatus)
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
                              _showGenres(widget.tvSeries.genres),
                            ),
                            Text(
                              _showDuration(widget.tvSeries.id),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tvSeries.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tvSeries.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(widget.tvSeries.overview),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvSeriesRecommendedBloc,
                                    TvSeriesRecommendedState>(
                                builder: (context, state) {
                              if (state is TvSeriesRecommendedLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is TvSeriesRecommendedHasData) {
                                return SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final tv = state.tvSeries[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              TvSeriesDetailPage.routeName,
                                              arguments: tv.id,
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w500${tv.posterPath}',
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
                                    itemCount: state.tvSeries.length,
                                  ),
                                );
                              } else if (state is TvSeriesRecommendedError) {
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

  String _showGenres(List<GenreModel> genres) {
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
