import 'package:core/common/utils.dart';
import 'package:core/presentation/widgets/tvseries_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/watchlist_tvseries/watchlist_tvseries_bloc.dart';
import '../../bloc/watchlist_tvseries/watchlist_tvseries_event.dart';
import '../../bloc/watchlist_tvseries/watchlist_tvseries_state.dart';

class WatchlistTvSeriesPage extends StatefulWidget {
  const WatchlistTvSeriesPage({Key? key}) : super(key: key);

  @override
  _WatchlistTvSeriesPageState createState() => _WatchlistTvSeriesPageState();
}

class _WatchlistTvSeriesPageState extends State<WatchlistTvSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistTvSeriesBloc>().add(WatchlistTvSeriesList());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    context.read<WatchlistTvSeriesBloc>().add(WatchlistTvSeriesList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Movies'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
            builder: (context, state) {
          if (state is WatchlistTvSeriesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistTvSeriesHasList) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = state.tvSeries[index];
                return TvCard(tv);
              },
              itemCount: state.tvSeries.length,
            );
          } else if (state is WatchlistTvSeriesError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Center(
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
