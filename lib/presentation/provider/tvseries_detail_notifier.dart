import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/domain/usecases/get_recommended_tvseries.dart';
import 'package:ditonton/domain/usecases/get_tvseries_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tvseries.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tvseries.dart';
import 'package:flutter/material.dart';
import '../../common/state_enum.dart';
import '../../domain/usecases/save_watchlist_tvseries.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetRecommendedTvSeries getRecommendedTvSeries;
  final RemoveWatchlistTv removeWatchlistTv;
  final SaveWatchlistTv saveWatchlistTv;
  final GetWatchListStatusTvSeries getWatchListStatusTvSeries;
  final GetWatchlistTvSeries getWatchlistTvSeries;

  TvSeriesDetailNotifier({
    required this.getTvSeriesDetail,
    required this.getRecommendedTvSeries,
    required this.getWatchlistTvSeries,
    required this.getWatchListStatusTvSeries,
    required this.saveWatchlistTv,
    required this.removeWatchlistTv,
  });

  late TvSeriesDetail _tvSeriesDetail;
  TvSeriesDetail get tvSeriesDetail => _tvSeriesDetail;

  RequestState _tvState = RequestState.Empty;
  RequestState get tvState => _tvState;

  List<TvSeries> _tvRecommended = [];
  List<TvSeries> get tvRecommended => _tvRecommended;

  RequestState _tvRecommendedState = RequestState.Empty;
  RequestState get tvRecommendedState => _tvRecommendedState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlistTv = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlistTv;

  Future<void> fetchTvSeriesDetail(int id) async {
    _tvState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvSeriesDetail.execute(id);
    final recommendedResult = await getRecommendedTvSeries.execute(id);
    detailResult.fold(
      (failure) {
        _tvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tv) {
        _tvRecommendedState = RequestState.Loading;
        _tvSeriesDetail = tv;
        notifyListeners();
        recommendedResult.fold((failure) {
          _tvRecommendedState = RequestState.Error;
          _message = failure.message;
        }, (tvRecom) {
          _tvRecommendedState = RequestState.Loaded;
          _tvRecommended = tvRecom;
        });
        _tvState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvSeriesDetail tv) async {
    final result = await saveWatchlistTv.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeFromWatchlist(TvSeriesDetail tv) async {
    final result = await removeWatchlistTv.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatusTvSeries.execute(id);
    _isAddedtoWatchlistTv = result;
    notifyListeners();
  }
}
