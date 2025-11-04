import 'package:dio/dio.dart';
import 'package:respire_mais/domain/DadosUsu.dart';

class BancoApi {
  final dio = Dio();

  final String baseUrl = 'https://my-json-server.typicode.com/Yuri-C-Araujo/respire_mais_api_fake_banco';

  Future<List<DadosUsu>> findAll() async {
    List<DadosUsu> listaDeUsuarios = [];

    try {
      final response = await dio.get('$baseUrl/usuarios');

      if (response.statusCode == 200) {
        var listResult = response.data;
        print(listResult);

        for (var json in listResult) {
          DadosUsu usuario = DadosUsu.fromJson(json);
          listaDeUsuarios.add(usuario);
        }
      }
    } catch (e) {
      print("Erro ao buscar dados da API Falsa: $e");
    }

    await Future.delayed(Duration(seconds: 2));

    return listaDeUsuarios;
  }

  Future<DadosUsu?> findById(int id) async {
    try {
      final response = await dio.get('$baseUrl/usuarios/$id');
      if (response.statusCode == 200) {
        return DadosUsu.fromJson(response.data);
      }
    } catch (e) {
      print("Erro ao buscar usuário por ID: $e");
    }
    return null;
  }
}