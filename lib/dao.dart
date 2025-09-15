  import 'package:sqflite/sqflite.dart';
  import 'dbhelper.dart';
  import 'model.dart';

  class MedicamentoDao {
      Future<int> salvar(Medicamento med) async {
        Database db = await DBHelper().initDB();
        return await db.insert('MEDICAMENTOS', med.toJson());
      }

    Future<List<Medicamento>> listar() async {
      List<Medicamento> lista = []; //cria lista
      Database db = await DBHelper().initDB();

      String sql = 'SELECT * FROM MEDICAMENTOS;'; //escreve a consulta SQL
      var resultado = await db.rawQuery(sql); // Executa a consulta e pega os resultados

      for (var json in resultado) {
        Medicamento med = Medicamento.fromJson(json); // Converte cada linha em objeto
        lista.add(med);
      }
      return lista;
    }

    Future<int> deletar(int id) async {
        Database db = await DBHelper().initDB();
      return await db.delete('MEDICAMENTOS', where: 'id = ?', whereArgs: [id]);
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
  }
