import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';
import '../../common/failure.dart';

class GetAiringTodayTvSeries {
  final TvSeriesRepository repository;

  GetAiringTodayTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getAiringTodayTvSeries();
  }
}