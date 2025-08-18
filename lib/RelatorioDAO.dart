import 'package:sqflite/sqflite.dart';
import 'DBHelper.dart';
import 'relatorio.dart';

class RelatorioDao {
  // Salvar um relatório
  Future<void> salvarRelatorio(Relatorio relatorio) async {
    Database db = await DBHelper().initDB();
    await db.insert(
      'Relatorio',
      relatorio.toJson(), // usa o método da classe Relatorio
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<void> listarEImprimirRelatorios() async {
    Database db = await DBHelper().initDB();
    List<Map<String, dynamic>> resultados = await db.query('RELATORIO');

    if (resultados.isEmpty) {
      print('Nenhum relatório encontrado.');
    } else {
      for (var r in resultados) {
        print('--- Relatório ---');
        print('Descrição: ${r['descricao']}');
        print('Nível de dor: ${r['niveldor']}');
        print('Fadiga: ${r['fadiga']}');
        print('Náusea: ${r['nausea']}');
        print('Falta de ar: ${r['faltaDeAr']}');
        print('Tosse: ${r['tosse']}');
        print('Data: ${r['data']}');
      }
    }
  }

  // Listar todos os relatórios
  Future<List<Relatorio>> listarRelatorios() async {
    Database db = await DBHelper().initDB();
    List<Map<String, dynamic>> listResult = await db.query('Relatorio');

    return listResult.map((json) => Relatorio.fromJson(json)).toList();
  }
}