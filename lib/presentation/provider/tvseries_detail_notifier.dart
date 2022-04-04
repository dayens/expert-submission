import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/domain/usecases/get_recommended_tvseries.dart';
import 'package:ditonton/domain/usecases/get_tvseries_detail.dart';
import 'package:flutter/material.dart';
import '../../common/state_enum.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetRecommendedTvSeries getRecommendedTvSeries;

  TvSeriesDetailNotifier({
    required this.getTvSeriesDetail,
    required this.getRecommendedTvSeries,
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
        recommendedResult.fold(
            (failure) {
              _tvRecommendedState = RequestState.Error;
              _message = failure.message;
            },
            (tvRecom) {
              _tvRecommendedState = RequestState.Loaded;
              _tvRecommended = tvRecom;
            }
        );
            _tvState = RequestState.Loaded;
            notifyListeners();
          },
    );
  }

}