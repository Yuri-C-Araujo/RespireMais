import 'package:sqflite/sqflite.dart';
import '../DBHelper.dart';
import '../relatorio.dart';

class RelatorioDao {

  Future<void> salvarRelatorio(Relatorio relatorio) async {
    Database db = await DBHelper().initDB();
    db.insert('Relatorio', relatorio.toJson(),
    );
  }
  Future<void> listarEImprimirRelatorios() async {
    Database db = await DBHelper().initDB();
    List<Map<String, dynamic>> resultados = await db.query('Relatorio');

    if (resultados.isEmpty) {
      print('Nenhum relatório encontrado.');
    } else {
      for (var r in resultados) {
        print('Relátorio id: ${r['id']}');
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

}