import 'package:respire_mais/domain/endereco.dart';
import 'package:dio/dio.dart';

class EnderecoApi {
  final dio = Dio();
  String baseUrl = 'https://viacep.com.br/ws';

  Future<Endereco> findByCep(String cep) async {
    try {
      var result = await dio.get('$baseUrl/$cep/json/');

      var json = result.data;

      if (json['erro'] == true) {
        throw Exception('CEP não encontrado');
      }

      Endereco endereco = Endereco.fromJson(json);
      return endereco;

    } catch (e) {
      print("Erro ao buscar CEP: $e");
      throw Exception('Falha ao buscar CEP');
    }
  }
}