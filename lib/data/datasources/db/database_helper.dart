import 'dart:async';

import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tvseries_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperMovie {
  static DatabaseHelperMovie? _databaseHelper;
  DatabaseHelperMovie._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelperMovie() => _databaseHelper ?? DatabaseHelperMovie._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblWatchlist = 'watchlistMovie';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_tblWatchlist, movie.toJson());
  }

  Future<int> removeWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovie() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }

  //TvSeries
  // Future<int> insertWatchlistTv(TvSeriesTable tvSeriesTable) async {
  //   final db = await database;
  //   return await db!.insert(_tblWatchlist, tvSeriesTable.toJson());
  // }
  //
  // Future<int> removeWatchlistTv(TvSeriesTable tvSeriesTable) async {
  //   final db = await database;
  //   return await db!.delete(
  //     _tblWatchlist,
  //     where: 'id = ?',
  //     whereArgs: [tvSeriesTable.id],
  //   );
  // }
  //
  // Future<Map<String, dynamic>?> getTvById(int id) async {
  //   final db = await database;
  //   final results = await db!.query(
  //     _tblWatchlist,
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  //
  //   if (results.isNotEmpty) {
  //     return results.first;
  //   } else {
  //     return null;
  //   }
  // }
}


class DatabaseHelperTvSeries {
  static DatabaseHelperTvSeries? _databaseHelper;
  DatabaseHelperTvSeries._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelperTvSeries() => _databaseHelper ?? DatabaseHelperTvSeries._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblWatchlist = 'watchlistTvSeries';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditontonTv.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlist (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvSeries() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }

  Future<int> insertWatchlistTv(TvSeriesTable tvSeriesTable) async {
    final db = await database;
    return await db!.insert(_tblWatchlist, tvSeriesTable.toJson());
  }

  Future<int> removeWatchlistTv(TvSeriesTable tvSeriesTable) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [tvSeriesTable.id],
    );
  }

  Future<Map<String, dynamic>?> getTvById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }
}