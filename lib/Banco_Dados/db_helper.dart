import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class DBHelper {
  Future<Database> initDB() async {
  String pach = await getDatabasesPath();
  String dbName = 'historico_db';
  String dbPath = join(pach, dbName);
  var db = await openDatabase(dbPath, version: 1, onCreate: onCreate);
  return db;
}

Future<void> onCreate(Database db, int version) async {

  String sql = ''' CREATE TABLE Informacoes ( 
  id INTEGER PRIMARY KEY AUTOINCREMENT, 
  datas TEXT,
  dor TEXT,
  fadiga TEXT,
  efetColateral TEXT 
  );''';
  await db.execute(sql);

  sql = "INSERT INTO Informacoes (datas, dor, fadiga, efetColateral) VALUES ('12/05', '6/10', 'Moderada', 'Tosse')";
  await db.execute(sql);
  sql = "INSERT INTO Informacoes (datas, dor, fadiga, efetColateral) VALUES ('11/05', '4/10', 'Leve', '')";
  await db.execute(sql);
  sql = "INSERT INTO Informacoes (datas, dor, fadiga, efetColateral) VALUES ('10/05', '9/10', 'Intensa', 'Náusea')";
  await db.execute(sql);
  sql = "INSERT INTO Informacoes (datas, dor, fadiga, efetColateral) VALUES ('9/05', '1/10', 'Moderada', '')";
  await db.execute(sql);
  }
}