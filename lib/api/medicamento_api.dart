import 'package:dio/dio.dart';
import 'package:respire_mais/model.dart';

class MedicamentoApi {
  final dio = Dio();

  final String baseUrl = 'https://my-json-server.typicode.com/wevertongsc/api_fake2';

  Future<List<Medicamento>> getMedicamentos() async {
    try {
      final response = await dio.get('$baseUrl/medicamentos');

      if (response.statusCode == 200) {
        print("Dados (medicamentos) recebidos:");
        print(response.data);

        final List<dynamic> jsonList = response.data;

        List<Medicamento> medicamentos = jsonList
            .map((json) => Medicamento.fromJson(json))
            .toList();

        return medicamentos;
      }
    } catch (e) {
      // 6. CORREÇÃO: Mensagem de erro corrigida
      print("Erro ao buscar medicamentos: $e");
    }

    // 7. CORREÇÃO: Retorna uma lista vazia em caso de erro
    return [];
  }
}