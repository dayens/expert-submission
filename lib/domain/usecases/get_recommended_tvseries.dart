import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

import '../../common/failure.dart';

class GetRecommendedTvSeries {
  final TvSeriesRepository repository;

  GetRecommendedTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(int id) {
    return repository.getRecommendedTvSeries(id);
  }
}