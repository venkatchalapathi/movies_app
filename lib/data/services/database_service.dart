import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:movies_app/data/models/movie_model.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('movies.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        overview TEXT NOT NULL,
        poster_path TEXT NOT NULL,
        backdrop_path TEXT NOT NULL,
        release_date TEXT NOT NULL,
        vote_average REAL NOT NULL,
        popularity REAL NOT NULL
      )
    ''');
  }

  Future<int> insertFavorite(MovieModel movie) async {
    final db = await database;
    return await db.insert(
      'favorites',
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteFavorite(int movieId) async {
    final db = await database;
    return await db.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [movieId],
    );
  }

  Future<List<MovieModel>> getFavorites() async {
    final db = await database;
    final maps = await db.query('favorites', orderBy: 'id DESC');
    return maps.map((map) => MovieModel.fromMap(map)).toList();
  }

  Future<bool> isFavorite(int movieId) async {
    final db = await database;
    final maps = await db.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [movieId],
    );
    return maps.isNotEmpty;
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}

