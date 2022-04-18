
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/presentation/bloc/movie_detail/watchlist/watchlist_movie_event.dart';
import 'package:core/presentation/bloc/movie_detail/watchlist/watchlist_movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistMovieBloc(this._getWatchListStatus, this._saveWatchlist,
      this._removeWatchlist, this._getWatchlistMovies)
      : super(WatchlistMovieEmpty()) {
    on<WatchlistStatus>((event, emit) async {
      final id = event.id;

      emit(WatchlistMovieLoading());

      final result = await _getWatchListStatus.execute(id);

      emit(WatchlistMovieHasStatus(result));
    });

    on<WatchlistMovieAdd>((event, emit) async {
      final movie = event.movie;

      final result = await _saveWatchlist.execute(movie);

      result.fold((failure) {
        emit(WatchlistMovieError(failure.message));
      }, (message) {
        emit(WatchlistMovieMessage(message));
      });
    });

    on<WatchlistMovieRemove>((event, emit) async {
      final movie = event.movie;

      final result = await _removeWatchlist.execute(movie);

      result.fold((failure) {
        emit(WatchlistMovieError(failure.message));
      }, (message) {
        emit(WatchlistMovieMessage(message));
      });
    });

    on<WatchlistMovieList>((event, emit) async {
      emit(WatchlistMovieLoading());

      final result = await _getWatchlistMovies.execute();

      result.fold((failure) {
        emit(WatchlistMovieError(failure.message));
      }, (data) {
        emit(WatchlistMovieHasList(data));
      });
    });
  }
}
