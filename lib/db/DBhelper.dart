import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBhelper {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbName = 'cadastro.db';

    String dbPath = join(path, dbName);
    print(dbPath);

    // CORREÇÃO AQUI: Adicionei o parâmetro 'onUpgrade: _onUpgrade'
    var db = await openDatabase(
      dbPath,
      version: 2,
      onCreate: onCreate,
      onUpgrade: _onUpgrade, // <--- VOCÊ PRECISAVA ADICIONAR ISSO
    );
    return db;
  }

  Future<void> onCreate(Database db, int version) async {
    String sql = '''CREATE TABLE DadosUsu(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT,
    email TEXT,
    senha TEXT,
    dataNasc TEXT,
    oqSente TEXT,
    cep TEXT,
    rua TEXT,
    bairro TEXT,
    cidade TEXT,
    estado TEXT
    );''';

    await db.execute(sql);
  }

  // Esta função agora será chamada corretamente
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute("ALTER TABLE DadosUsu ADD COLUMN cep TEXT");
      await db.execute("ALTER TABLE DadosUsu ADD COLUMN rua TEXT");
      await db.execute("ALTER TABLE DadosUsu ADD COLUMN bairro TEXT");
      await db.execute("ALTER TABLE DadosUsu ADD COLUMN cidade TEXT");
      await db.execute("ALTER TABLE DadosUsu ADD COLUMN estado TEXT");
    }
  }
}