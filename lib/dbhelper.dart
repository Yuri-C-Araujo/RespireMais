import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbName = 'medicamentos.db';

    String dbPath = join(path, dbName);
    print('Caminho do banco: $dbPath'); // estilo professor

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

    await db.execute("INSERT INTO MEDICAMENTOS (nome, horario, urlImagem) VALUES ('Paracetamol', '08:00', 'https://i.imgur.com/BoN9kdC.png');");
    await db.execute("INSERT INTO MEDICAMENTOS (nome, horario, urlImagem) VALUES ('Ibuprofeno', '12:00', 'https://i.imgur.com/BoN9kdC.png');");
  }
}
