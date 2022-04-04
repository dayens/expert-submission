import 'package:ditonton/data/models/tvseries_table.dart';

import '../../common/exception.dart';
import 'db/database_helper.dart';

abstract class TvSeriesLocalDataSource {
  Future<String> insertWatchlistTv(TvSeriesTable tv);
  Future<String> removeWatchlistTv(TvSeriesTable tv);
  Future<TvSeriesTable?> getTvById(int id);
  Future<List<TvSeriesTable>> getWatchlist();
}

class TvSeriesLocalDataSourceImpl implements TvSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlistTv(TvSeriesTable tv) async {
    try {
      await databaseHelper.insertWatchlistTv(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTv(TvSeriesTable tv) async {
    try {
      await databaseHelper.removeWatchlistTv(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvSeriesTable?> getTvById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return TvSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvSeriesTable>> getWatchlist() async {
    final result = await databaseHelper.getWatchlist();
    return result.map((data) => TvSeriesTable.fromMap(data)).toList();
  }
}
