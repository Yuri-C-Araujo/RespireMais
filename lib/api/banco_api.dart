import 'package:dio/dio.dart';
// Importa o seu modelo de dados de usuário
import 'package:respire_mais/domain/DadosUsu.dart';

class BancoApi {
  final dio = Dio();

  // ATENÇÃO: Troque pelo URL do SEU repositório
  // Ex: 'https://my-json-server.typicode.com/seu-usuario/respire_mais_api_fake'
  final String baseUrl = 'https://my-json-server.typicode.com/Yuri-C-Araujo/respire_mais_api_fake_banco';

  // Esta função busca a lista de usuários da sua API Falsa
  Future<List<DadosUsu>> findAll() async {
    List<DadosUsu> listaDeUsuarios = [];

    try {
      // Faz a chamada para a rota "/usuarios" do seu db.json
      final response = await dio.get('$baseUrl/usuarios');

      if (response.statusCode == 200) {
        var listResult = response.data;
        print(listResult);

        // Converte cada item do JSON em um objeto DadosUsu
        for (var json in listResult) {
          DadosUsu usuario = DadosUsu.fromJson(json);
          listaDeUsuarios.add(usuario);
        }
      }
    } catch (e) {
      print("Erro ao buscar dados da API Falsa: $e");
    }

    // Adiciona um delay para simular o carregamento, igual ao do professor
    await Future.delayed(Duration(seconds: 2));

    return listaDeUsuarios;
  }

  // Você também pode criar uma função para buscar um usuário por ID
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