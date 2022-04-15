import 'package:ditonton/presentation/bloc/tvseries/tvseries_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_event.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/tvseries_card.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/toprated-tvseries';

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
        title: Text('Top Rated TvSeries'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
            builder: (context, state) {
          if (state is TopRatedTvSeriesLoading) {
            return Center(
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
            return Center(
              child: Text('Failed'),
            );
          }
        }),
      ),
    );
  }
}
