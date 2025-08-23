import 'package:sqflite/sqflite.dart';
import 'dbhelper.dart';
import 'model.dart';

class MedicamentoDao {
  Future<int> salvar(Medicamento med) async {
    final Database db = await DBHelper().initDB();
    return db.insert('MEDICAMENTO', med.toJson());
  }

  Future<List<Medicamento>> listar() async {
    final Database db = await DBHelper().initDB();
    final List<Map<String, dynamic>> resultado = await db.query('MEDICAMENTO');
    return resultado.map((json) => Medicamento.fromJson(json)).toList();
  }
  Future<void> imprimirBanco() async {
    final Database db = await DBHelper().initDB();
    List<Map<String, dynamic>> resultados = await db.query('MEDICAMENTO');

    if (resultados.isEmpty) {
      print('Nenhum relatório encontrado.');
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
    final Database db = await DBHelper().initDB();
    return db.delete('MEDICAMENTO', where: 'id = ?', whereArgs: [id]);
  }
}
