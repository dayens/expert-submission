import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/tvseries_detail.dart';
import '../repositories/tvseries_repository.dart';

class RemoveWatchlistTv {
  final TvSeriesRepository repository;

  RemoveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
