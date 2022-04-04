import 'package:dartz/dartz.dart';
import '../../common/failure.dart';
import '../entities/tvseries_detail.dart';
import '../repositories/tvseries_repository.dart';

class SaveWatchlistTv {
  final TvSeriesRepository repository;

  SaveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tv) {
    return repository.saveWatchlist(tv);
  }
}