import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/tvseries.dart';
import '../repositories/tvseries_repository.dart';

class GetRecommendedTvSeries {
  final TvSeriesRepository repository;

  GetRecommendedTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(int id) {
    return repository.getRecommendedTvSeries(id);
  }
}
