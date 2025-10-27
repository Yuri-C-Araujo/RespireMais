import 'package:dio/dio.dart';
import 'package:respire_mais/domain/perfil.dart';

class PerfilApiService {
  final dio = Dio();

  // URL base correta (confira o nome exato do seu repositório no GitHub)
  final String baseUrl = 'https://my-json-server.typicode.com/Eduardolevi02/Api';

  Future<PerfilModel?> getPerfil() async {
    try {
      // Endpoint correto (ajuste conforme o nome da chave no JSON)
      final response = await dio.get('$baseUrl/usuarios');

      if (response.statusCode == 200) {
        print("Dados recebidos:");
        print(response.data);

        // A resposta é uma lista, então pegamos o primeiro usuário (ou você pode buscar por ID)
        var json = response.data[0];
        PerfilModel perfil = PerfilModel.fromJson(json);
        return perfil;
      }
    } catch (e) {
      print("Erro ao buscar perfil: $e");
    }
    return null;
  }
}
