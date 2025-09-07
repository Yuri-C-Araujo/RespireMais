import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbName = 'medicamentos.db';
    String dbPath = join(path, dbName);
    print(dbPath);
    Database db = await openDatabase(dbPath, version: 1, onCreate: onCreate);
    return db;
  }

  Future<void> onCreate(Database db, int version) async {
    String sql = '''
      CREATE TABLE MEDICAMENTOS (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        horario TEXT NOT NULL,
        urlImagem TEXT NOT NULL
      );
    ''';

    await db.execute(sql);
  }
}
