import 'package:dio/dio.dart';
import 'package:respire_mais/domain/Informacoes.dart';

class ApiService{
  static const String _apiKei = 'c7ccNDExNDc6MzgzNTI6VTJMMUpZQm5wbU1kNTNUNA=';
  static const String _templateId = '38077b23ef7d51f8';
  static const String _fakeApiUrl = 'https://my-json-server.typicode.com/Israelnl17/API_fake/informacoes';
  static const String _apiTemplateUrl = 'https://api.apitemplate.io/v1/create';
  static final Dio _dio = Dio();
  static Future<List<Informacoes>> fetchHistoricoFake() async{
    try{
      final response = await _dio.get(_fakeApiUrl);
      final List<dynamic> jsonData = response.data;
      return jsonData.map((json) => Informacoes.fromJson(json)).toList();
    } on DioException catch (e){
      print('Erro no Dio [GET]${e.message}');
      throw Exception('Falha ao carregar dados do histórico (Fake API)');
    }catch (e){
      throw Exception('Erro desconhecido: $e');
    }
  }
  static Future<String> gerarPdfApi(List<Informacoes> dados) async{
    List<Map<String, dynamic>> dadosJson = dados.map((info) => info.toJson()).toList();
    Map<String, dynamic> dadosApi = {
      "items": dadosJson
    };
    String urlFinal = '$_apiTemplateUrl?template_id=$_templateId';
    try{
      final response = await _dio.post(
        urlFinal,
        data:dadosApi,
        options: Options(
          headers: {
            'Authorization': 'Bearer $_apiKei',
          },
        ),
      );
      final Map<String, dynamic> jsonData = response.data;
      String linkPdf = jsonData['download_url'];
      print('PDF gerado com sucesso: $linkPdf');
      return linkPdf;
    } on DioException catch (e) {
      print('Erro no  Dio [POST]: ${e.response?.data}');
      throw Exception('Falha ao gerar PDF (API): ${e.message}');
    } catch (e){
      throw Exception('Erro desconhecido ao gerar PDF: $e');
    }
  }
}