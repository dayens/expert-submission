import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import '../../common/failure.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getAiringTodayTvSeries();
}
