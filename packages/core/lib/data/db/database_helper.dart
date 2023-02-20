import 'dart:async';

import 'package:core/utils/encrypt.dart';
import 'package:movie/data/model/movie_table.dart';
import 'package:series/data/models/series_table.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:watchlist/data/models/watchlist_table.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblWatchlist = 'watchlist';
  static const String _tblCache = 'cache';

  // movies
  static const String CATEGORY_MOVIES_NOW_PLAYING = 'now playing movies';
  static const String CATEGORY_MOVIES_POPULAR = 'popular movies';
  static const String CATEGORY_MOVIES_TOP_RATED = 'top rated movies';

  // series
  static const String CATEGORY_SERIES_NOW_PLAYING = 'now playing series';
  static const String CATEGORY_SERIES_POPULAR = 'popular series';
  static const String CATEGORY_SERIES_TOP_RATED = 'top rated series';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
      password: encrypt('vikocekson123456'),
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        category TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE  $_tblCache (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        category TEXT
      );
    ''');
  }

  Future<int> insertWatchlist(WatchlistTable watchList) async {
    final db = await database;
    return await db!.insert(_tblWatchlist, watchList.toJson());
  }

  Future<int> removeWatchlist(WatchlistTable watchList) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [watchList.id],
    );
  }

  Future<void> insertCacheTransaction(
      List<MovieTable> movies, String category) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final movie in movies) {
        final movieJson = movie.toJson();
        movieJson['category'] = category;
        txn.insert(_tblCache, movieJson,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

  Future<void> insertCacheTransactionSeries(
      List<SeriesTable> seriesList, String category) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final series in seriesList) {
        final seriesJson = series.toJson();
        seriesJson['category'] = category;
        txn.insert(_tblCache, seriesJson,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

  Future<Map<String, dynamic>?> getWatchListById(int id) async {
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

  Future<List<Map<String, dynamic>>> getWatchlist() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }

  Future<List<Map<String, dynamic>>> getCache(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!
        .query(_tblCache, where: 'category = ?', whereArgs: [category]);

    return results;
  }

  Future<int> clearCache(String category) async {
    final db = await database;
    return await db!
        .delete(_tblCache, where: 'category = ?', whereArgs: [category]);
  }
}
