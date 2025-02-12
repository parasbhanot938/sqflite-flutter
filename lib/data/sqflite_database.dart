import 'package:flutter_assignment/model/post_data_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteDatabase {
  static Database? _database;
  static const String tableName = "posts";
  static final SqfliteDatabase instance = SqfliteDatabase._internal();
  SqfliteDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'posts.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
          id INTEGER PRIMARY KEY, 
          userId INTEGER,        
            title TEXT,
            body TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertPost(PostDataModel post) async {
    final db = await database;
    return await db.insert(tableName, post.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

   Future<List<PostDataModel>> getAllPosts() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) => PostDataModel.fromJson(maps[i]));
  }

}
