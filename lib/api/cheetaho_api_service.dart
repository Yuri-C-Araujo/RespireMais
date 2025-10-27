import 'package:dio/dio.dart';
// import 'dart:convert'; // Não é mais necessário, o Dio faz a conversão
// import 'package:http/http.dart' as http; // Não é mais necessário

class CheetahoApiService {
  // Endpoint da API, encontrado no ficheiro cheetaho.php [cite: cheetaho.php]
  final String _cheetahoEndpoint = 'https://app.cheetaho.com/api/v1/media';

  // A sua chave de API
  final String _cheetahoApiKey = ' c3a656b0b1f62e92eef87492bd6029f2f2da6401';

  // <<< MUDANÇA: Instanciar o Dio
  final Dio _dio = Dio();

  /// Otimiza uma imagem a partir de uma URL.
  ///
  /// Retorna a nova URL otimizada em caso de sucesso,
  /// ou null em caso de falha.
  Future<String?> otimizarImagem(String urlDaImagem) async {
    // O corpo (body) é o mesmo Map de antes
    var corpo = {
      "key": _cheetahoApiKey,
      "url": urlDaImagem,
      "lossy": 1, // [cite: api.php]
      "quality": 80,
      "wait": true, // [cite: api.pdf (source: 17)]
      "resize": { // [cite: api.pdf (source: 19)]
        "width": 1000,
        "height": 1000,
        "strategy": "auto" // [cite: api.pdf (source: 27)]
      }
    };

    try {
      // <<< MUDANÇA: Usando dio.post
      // O Dio envia o Map 'corpo' como JSON automaticamente
      var response = await _dio.post(
        _cheetahoEndpoint,
        data: corpo,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

      // <<< MUDANÇA: Verificação de status não é necessária
      // Se o código chegar aqui, o status foi 200 (sucesso).
      // O 'response.data' já é o JSON descodificado (não precisa de json.decode)
      var responseData = response.data;

      if (responseData['data'] != null && responseData['data']['error'] == null) {
        print("API CheetahO Sucesso. Dados recebidos:");
        print(responseData['data']);

        String? urlOtimizada = responseData['data']['destURL']; // [cite: (user log)]

        if (urlOtimizada != null) {
          print("Sucesso! URL Otimizada: $urlOtimizada");
          return urlOtimizada;
        } else {
          print("Erro: A API teve sucesso, mas a 'destURL' não foi encontrada na resposta.");
          return null;
        }
      } else {
        String erro =
            responseData['data']?['error']?['message'] ?? 'Erro desconhecido da API';
        print("Erro da API CheetahO: $erro");
        return null;
      }

      // <<< MUDANÇA: Tratamento de erro unificado
      // O Dio lança uma exceção para erros de HTTP (como 400, 401, 500)
    } on DioException catch (e) {
      // Se o erro tiver uma resposta do servidor (como 400 ou 401)
      if (e.response != null) {
        print("Erro de HTTP ao chamar CheetahO: ${e.response?.statusCode}");
        // 'e.response.data' já é o JSON (ou texto) do erro
        print("Corpo: ${e.response?.data}");
      } else {
        // Erro de rede, DNS, timeout, etc.
        print("Exceção na chamada da API CheetahO (Dio): ${e.message}");
      }
      return null;
    } catch (e) {
      // Captura qualquer outro erro inesperado
      print("Exceção inesperada: $e");
      return null;
    }
  }
}
