import 'package:ditonton/presentation/bloc/search/search_bloc.dart';
import 'package:ditonton/presentation/bloc/search/search_event.dart';
import 'package:ditonton/presentation/bloc/search/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/constants.dart';
import '../widgets/tvseries_card.dart';

class SearchTvSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-tvseries';
  final TextEditingController _searchControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search title',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (String query) {
              if (query.isNotEmpty) {
                context.read<SearchBlocTvSeries>().add(OnQueryChanged(query));
              }
            },
            controller: _searchControl,
          ),
          SizedBox(height: 16),
          Text(
            'Search Result',
            style: kHeading6,
          ),
          // Consumer<TvSeriesSearchNotifier>(
          //   builder: (context, data, child) {
          //     if (data.state == RequestState.Loading) {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     } else if (data.state == RequestState.Loaded) {
          //       final result = data.searchResult;
          //       return Expanded(
          //         child: ListView.builder(
          //           padding: const EdgeInsets.all(8),
          //           itemBuilder: (context, index) {
          //             final tv = data.searchResult[index];
          //             return TvCard(tv);
          //           },
          //           itemCount: result.length,
          //         ),
          //       );
          //     } else {
          //       return Expanded(
          //         child: Container(),
          //       );
          //     }
          //   },
          // ),
          BlocBuilder<SearchBlocTvSeries, SearchState>(
              builder: (context, state) {
            if (state is SearchLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SearchHasDataTvSeries) {
              final result = state.result;
              return Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    final tv = result[index];
                    return TvCard(tv);
                  },
                  itemCount: result.length,
                ),
              );
            } else if (state is SearchError) {
              return Expanded(
                  child: Center(
                child: Text(state.message),
              ));
            } else {
              return Expanded(
                child: Container(),
              );
            }
          })
        ],
      ),
    );
  }
}
