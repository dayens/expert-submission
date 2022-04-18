import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/presentation/widgets/sub_heading.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/watchlist/watchlist_page.dart';
import 'package:search/presentation/pages/search_tvseries_page.dart';
import 'package:tvseries/presentation/pages/popular_tvseries_page.dart';
import 'package:tvseries/presentation/pages/top_rated_tvseries_page.dart';
import 'package:tvseries/presentation/pages/tvseries_detail_page.dart';
import '../../domain/entities/tvseries.dart';
import '../bloc/tvseries/tvseries_bloc.dart';
import '../bloc/tvseries/tvseries_event.dart';
import '../bloc/tvseries/tvseries_state.dart';

class TvSeriesPage extends StatefulWidget {
  const TvSeriesPage({Key? key}) : super(key: key);
  static const ROUTE_NAME = '/tv-series-page';

  @override
  _TvSeriesPageState createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<AiringTodayTvSeriesBloc>().add(AiringTodayTvSeries());
      context.read<PopularTvSeriesBloc>().add(PopularTvSeries());
      context.read<TopRatedTvSeriesBloc>().add(TopRatedTvSeries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidgets(
        onTapMovie: () {
          Navigator.pushReplacementNamed(context, HomeMoviePage.ROUTE_NAME);
        },
        onTapTv: () {
          Navigator.pop(context);
        },
        onTapWatchlist: () {
          Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
        },
      ),
      appBar: AppBar(
        title: const Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTvSeriesPage.ROUTE_NAME);
            },
            icon: const Icon(Icons.search),
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
                'Airing Today',
                style: kHeading6,
              ),
              BlocBuilder<AiringTodayTvSeriesBloc, AiringTodayTvSeriesState>(
                  builder: (context, state) {
                if (state is AiringTodayTvSeriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is AiringTodayTvSeriesHasData) {
                  final result = state.result;
                  return TvSeriesList(result);
                } else if (state is AiringTodayTvSeriesError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Text('Failed');
                }
              }),
              SubHeading(
                  title: 'Popular',
                  onTap: () {
                    Navigator.pushNamed(
                        context, PopularTvSeriesPage.routeName);
                  }),
              BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
                  builder: (context, state) {
                if (state is PopularTvSeriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularTvSeriesHasData) {
                  final result = state.result;
                  return TvSeriesList(result);
                } else if (state is PopularTvSeriesError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Text('Failed');
                }
              }),
              SubHeading(
                  title: 'Top Rated',
                  onTap: () {
                    Navigator.pushNamed(
                        context, TopRatedTvSeriesPage.routeName);
                  }),
              BlocBuilder<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
                  builder: (context, state) {
                if (state is TopRatedTvSeriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedTvSeriesHasData) {
                  final result = state.result;
                  return TvSeriesList(result);
                } else if (state is TopRatedTvSeriesError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeries;

  TvSeriesList(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${tv.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
