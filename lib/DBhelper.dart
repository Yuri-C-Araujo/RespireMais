import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbName = 'relatorio.db'; // banco exclusivo para relatórios
    String dbPath = join(path, dbName);
    print("DB Path: $dbPath");

    var db = await openDatabase(dbPath, version: 1, onCreate: onCreate);
    return db;
  }

  Future<void> onCreate(Database db, int version) async {
    String sqlRelatorio = '''
      CREATE TABLE Relatorio (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        descricao TEXT,
        niveldor REAL,
        fadiga TEXT,
        nausea INTEGER,
        faltaDeAr INTEGER,
        tosse INTEGER,
        data TEXT
      );
    ''';
    await db.execute(sqlRelatorio);
  }
}
