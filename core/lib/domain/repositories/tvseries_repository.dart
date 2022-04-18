import 'package:core/domain/entities/tvseries.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/tvseries_detail.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getAiringTodayTvSeries();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();
  Future<Either<Failure, TvSeriesDetail>> getDetailTvSeries(int id);
  Future<Either<Failure, List<TvSeries>>> getRecommendedTvSeries(int id);
  Future<Either<Failure, String>> saveWatchlist(TvSeriesDetail tv);
  Future<Either<Failure, String>> removeWatchlist(TvSeriesDetail tv);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TvSeries>>> getWatchlist();
  Future<Either<Failure, List<TvSeries>>> getSearchTvSeries(String query);
}
