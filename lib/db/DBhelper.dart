import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBhelper {
  Future<Database> initDB() async{
    String path = await getDatabasesPath();
    String dbName = 'cadastro.db';

    String dbPath = join(path, dbName);
    print(dbPath);
    var db = await openDatabase(dbPath, version: 1, onCreate: onCreate);
    return db;
  }
  Future<void> onCreate(Database db, int version) async {
    String sql = '''CREATE TABLE DadosUsu(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT,
    email TEXT,
    senha TEXT,
    dataNasc TEXT,
    oqSente TEXT
    );''';

    await db.execute(sql);
  }
}