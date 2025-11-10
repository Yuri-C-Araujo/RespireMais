import 'package:dio/dio.dart';

class CheetahoApiService {
  final String _endpoint = 'https://app.cheetaho.com/api/v1/media';
  final String _apiKey = 'c3a656b0b1f62e92eef87492bd6029f2f2da6401';
  final Dio _dio = Dio();

  Future<String?> otimizarImagem(String urlDaImagem) async {
    try {
      final response = await _dio.post(
        _endpoint,
        data: {
          "key": _apiKey,
          "url": urlDaImagem,
          "lossy": 1,
          "quality": 80,
          "wait": true,
          "resize": {
            "width": 1000,
            "height": 1000,
            "strategy": "auto",
          }
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      final data = response.data['data'];
      if (data != null && data['destURL'] != null) {
        print("Imagem otimizada com sucesso: ${data['destURL']}");
        return data['destURL'];
      }

      print("Erro da API: ${data?['error']?['message'] ?? 'Resposta inesperada.'}");
      return null;

    } on DioException catch (e) {
      print("Erro HTTP ${e.response?.statusCode}: ${e.response?.data}");
      return null;
    } catch (e) {
      print("Erro inesperado: $e");
      return null;
    }
  }
}