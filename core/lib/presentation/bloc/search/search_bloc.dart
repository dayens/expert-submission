
import 'package:core/domain/usecases/search_tvseries.dart';
import 'package:core/presentation/bloc/search/debounce.dart';
import 'package:core/presentation/bloc/search/search_event.dart';
import 'package:core/presentation/bloc/search/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/search_movies.dart';

class SearchBlocMovie extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;

  SearchBlocMovie(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchMovies.execute(query);

      result.fold(
        (failure) {
          emit(SearchError(failure.message));
        },
        (data) {
          emit(SearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

class SearchBlocTvSeries extends Bloc<SearchEvent, SearchState> {
  final SearchTvSeries _searchTvSeries;

  SearchBlocTvSeries(this._searchTvSeries) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchTvSeries.execute(query);

      result.fold(
        (failure) {
          emit(SearchError(failure.message));
        },
        (data) {
          emit(SearchHasDataTvSeries(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
