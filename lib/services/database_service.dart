import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:news_reader/models/article_model.dart';

class DatabaseService {
  static const String tableName = 'favorites';
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'news_app.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        title TEXT PRIMARY KEY,
        description TEXT,
        urlToImage TEXT,
        url TEXT
      )
    ''');
  }

  Future<List<Article>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return Article(
        title: maps[i]['title'],
        description: maps[i]['description'],
        urlToImage: maps[i]['urlToImage'],
        url: maps[i]['url'],
      );
    });
  }

  Future<void> insertFavorite(Article article) async {
    final db = await database;
    await db.insert(
      tableName,
      article.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavorite(String title) async {
    final db = await database;
    await db.delete(
      tableName,
      where: 'title = ?',
      whereArgs: [title],
    );
  }
}
