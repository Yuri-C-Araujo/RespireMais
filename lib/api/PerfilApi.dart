import 'package:dio/dio.dart';
import 'package:respire_mais/domain/perfil.dart';

class PerfilApiService {
  final dio = Dio();

  final String baseUrl = 'https://my-json-server.typicode.com/Eduardolevi02/Api';

  Future<PerfilModel?> getPerfil() async {
    try {
      final response = await dio.get('$baseUrl/usuarios');

      if (response.statusCode == 200) {
        print("Dados recebidos:");
        print(response.data);

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
