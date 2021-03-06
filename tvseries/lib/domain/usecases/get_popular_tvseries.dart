import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/tvseries.dart';
import '../repositories/tvseries_repository.dart';

class GetPopularTvSeries {
  final TvSeriesRepository repository;

  GetPopularTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getPopularTvSeries();
  }
}
