import 'package:core/domain/entities/tvseries_detail.dart';
import 'package:core/domain/repositories/tvseries_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';


class GetTvSeriesDetail {
  final TvSeriesRepository repository;

  GetTvSeriesDetail(this.repository);

  Future<Either<Failure, TvSeriesDetail>> execute(int id) {
    return repository.getDetailTvSeries(id);
  }
}
