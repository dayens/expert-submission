import 'package:core/presentation/widgets/tvseries_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tvseries/tvseries_bloc.dart';
import '../bloc/tvseries/tvseries_event.dart';
import '../bloc/tvseries/tvseries_state.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const routeName = '/toprated-tvseries';

  @override
  _TopRatedTvSeriesPageState createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TopRatedTvSeriesBloc>().add(TopRatedTvSeries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TvSeries'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
            builder: (context, state) {
          if (state is TopRatedTvSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TopRatedTvSeriesHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final result = state.result[index];
                return TvCard(result);
              },
              itemCount: state.result.length,
            );
          } else if (state is TopRatedTvSeriesError) {
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
