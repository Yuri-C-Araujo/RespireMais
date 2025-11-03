import 'package:respire_mais/domain/endereco.dart';
import 'package:dio/dio.dart';

class EnderecoApi {
  final dio = Dio();
  // A MUDANÇA ESTÁ AQUI
  // Trocamos o URL base para o da ViaCEP
  String baseUrl = 'https://viacep.com.br/ws';

  Future<Endereco> findByCep(String cep) async {
    try {
      // E AQUI
      // O formato da URL da ViaCEP é diferente
      // Ex: https://viacep.com.br/ws/01001000/json/
      var result = await dio.get('$baseUrl/$cep/json/');

      var json = result.data;

      // Verifica se a API retornou um erro de CEP não encontrado
      if (json['erro'] == true) {
        throw Exception('CEP não encontrado');
      }

      // O 'Endereco.fromJson' agora sabe como ler a resposta da ViaCEP
      Endereco endereco = Endereco.fromJson(json);
      return endereco;
    } catch (e) {
      print("Erro ao buscar CEP: $e");
      // Repassa a exceção para o 'cadastro.dart' tratar
      throw Exception('Falha ao buscar CEP');
    }
  }
}