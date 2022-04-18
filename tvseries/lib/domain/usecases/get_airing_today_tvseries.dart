import '../entities/tvseries.dart';
import '../repositories/tvseries_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetAiringTodayTvSeries {
  final TvSeriesRepository repository;

  GetAiringTodayTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getAiringTodayTvSeries();
  }
}
