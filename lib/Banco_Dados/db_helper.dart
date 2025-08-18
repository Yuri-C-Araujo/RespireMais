import 'dart:async';
import 'dart:ffi';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DBHelper {
  Future<Database> initDB() async {
    String pach = await getDatabasesPath();
    String dbName = 'sent_db';
    String dbPach = join(pach, dbName);
    print(dbPach);
    var db = await openDatabase(dbPach, version: 1, onCreate: onCreate);
    return db;
  }

  Future<Void> onCreate(Database db, int version) async{

    String sql = ''' CREATE TABLE Propriedade (
    id integer PRIMARY KEY AUTOINCREMENT,
    Data TEXT
    Dor INT,
    Fadiga TEXT,
    EfetColateral TEXT
    ''';

    await db.execute(sql);

    sql =
        "INSERTE INTO Propriedade (Dor, Fadiga, EfetColateral) VALUES ()";


  }

}