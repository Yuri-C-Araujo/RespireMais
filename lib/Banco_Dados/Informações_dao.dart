import 'package:respire_mais/Banco_Dados/db_helper.dart';
import 'package:respire_mais/domain/Informacoes.dart';
import 'package:sqflite/sqlite_api.dart';

class Informacoes_dao {

 Future<List<Informacoes>> listInformacoes() async {
  List<Informacoes> listInformacoes = [];
  Database db = await DBHelper().initDB();

  String sql = 'SELECT * FROM INFORMACOES;';
  var listResult = await db.rawQuery(sql);

  for (var json in listResult){

   Informacoes informacoes = Informacoes.fromJson(json);
   listInformacoes.add(informacoes);
   }
  return listInformacoes;
  }
}