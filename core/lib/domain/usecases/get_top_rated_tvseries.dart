import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/tvseries.dart';
import '../repositories/tvseries_repository.dart';

class GetTopRatedTvSeries {
  final TvSeriesRepository repository;

  GetTopRatedTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTopRatedTvSeries();
  }
}
