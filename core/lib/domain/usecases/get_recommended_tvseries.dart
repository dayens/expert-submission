import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/repositories/tvseries_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';



class GetRecommendedTvSeries {
  final TvSeriesRepository repository;

  GetRecommendedTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(int id) {
    return repository.getRecommendedTvSeries(id);
  }
}
