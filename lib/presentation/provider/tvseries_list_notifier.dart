import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tvseries.dart';
import 'package:flutter/material.dart';

import '../../common/state_enum.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  var _airingTodayTvSeries = <TvSeries>[];
  List<TvSeries> get airingTodayTvSeries => _airingTodayTvSeries;

  RequestState _airingState = RequestState.Empty;
  RequestState get nowAiringState => _airingState;

  String _message = '';
  String get message => _message;

  TvSeriesListNotifier({
    required this.getAiringTodayTvSeries
  });

  final GetAiringTodayTvSeries getAiringTodayTvSeries;

  Future<void> fetchAiringTodayTvSeries() async {
    _airingState = RequestState.Loading;
    notifyListeners();

    final result = await getAiringTodayTvSeries.execute();
    result.fold(
          (failure) {
        _airingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (tvSeriesData) {
        _airingState = RequestState.Loaded;
        _airingTodayTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}