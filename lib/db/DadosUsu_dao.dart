import 'package:respire_mais/db/DBhelper.dart' show DBhelper;
import 'package:respire_mais/domain/DadosUsu.dart';
import 'package:sqflite/sqflite.dart' show Database;

class DadosUsuDao {
  Future<bool> autenticacao(String email, String senha) async {
    Database db = await DBhelper().initDB();

    String sql = 'SELECT * FROM DadosUsu '
        'WHERE email = ? '
        'AND senha = ?;';

    var result = await db.rawQuery(sql, [email, senha]);
    print(result);
    return result.isNotEmpty;
  }

  salvar(DadosUsu dadosUsu) async {
    Database db = await DBhelper().initDB();
    await db.insert('DadosUsu', dadosUsu.toJson());
  }

  Future<void> listarCadastroUsuario() async {
    Database db = await DBhelper().initDB();
    List<Map<String, dynamic>> resultados = await db.query('DadosUsu');

    if (resultados.isEmpty) {
      print('Nenhum relatório encontrado.');
    } else {
      for (var r in resultados) {
        print('Usuario id: ${r['id']}');
        print('Nome: ${r['nome']}');
        print('E-mail: ${r['email']}');
        print('Senha: ${r['senha']}');
        print('Data de Nascimento: ${r['dataNasc']}');
        print('O que sente: ${r['oqSente']}');
      }
    }
  }
}