import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/tvseries_detail.dart';
import '../repositories/tvseries_repository.dart';

class SaveWatchlistTv {
  final TvSeriesRepository repository;

  SaveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tv) {
    return repository.saveWatchlist(tv);
  }
}
