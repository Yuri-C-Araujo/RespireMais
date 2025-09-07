import 'package:sqflite/sqflite.dart';
import 'dbhelper.dart';
import 'model.dart';

class MedicamentoDao { //gerenciar todas as operações do banco relacionadas ao medicamento
  Future<int> salvar(Medicamento med) async {
    Database db = await DBHelper().initDB();
    return await db.insert('MEDICAMENTOS', med.toJson());
  }

  Future<List<Medicamento>> listar() async { //retorna a lista
    List<Medicamento> lista = [];
    Database db = await DBHelper().initDB();

    String sql = 'SELECT * FROM MEDICAMENTOS;';
    var resultado = await db.rawQuery(sql);

    for (var json in resultado) {
      Medicamento med = Medicamento.fromJson(json); //Converte cada linha do banco
      // (json) em objeto Medicamento usando Medicamento.fromJson(json).
      lista.add(med);
    }

    return lista;
  }

  Future<void> imprimirBanco() async {
    Database db = await DBHelper().initDB();
    String sql = 'SELECT * FROM MEDICAMENTOS;';
    var resultados = await db.rawQuery(sql);

    if (resultados.isEmpty) {
      print('Nenhum medicamento encontrado.');
    } else {
      for (var r in resultados) {
        print('ID: ${r['id']}');
        print('Nome: ${r['nome']}');
        print('Horário: ${r['horario']}');
        print('URL: ${r['urlImagem']}');
        print('-------------------------');
      }
    }
  }

  Future<int> deletar(int id) async {
    Database db = await DBHelper().initDB();
    return await db.delete('MEDICAMENTOS', where: 'id = ?', whereArgs: [id]);
  }
}
