import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:respire_mais/domain/Informacoes.dart';

class ApiService{
  static const String _apiKei = '3bb6NDExNDc6MzgzNTI6cjh6RGRaMFdqVzUyU2E3ZQ=';
  static const String _templateId = '38077b23ef7d51f8';
  static const String _fakeApiUrl = 'https://my-json-server.typicode.com/Israelnl17/API_fake/informacoes';
  static const String _apiTemplateUrl = 'https://app.apitemplate.io/manage-api/';
  static final Dio _dio = Dio();
  static Future<List<Informacoes>> fethHistoricoFake() async{
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
    List<Map<String, dynamic>> dadosJason = dados.map((info) => info.toJson()).toList();
    String urlFinal = '$_apiTemplateUrl?template_id=$_templateId';
    try{
      final response = await _dio.post(
        urlFinal,
        data: dadosJason,
        options: Options(
          headers: {
            'Authorization': 'Bearer $_apiKei',
          },
        ),
      );
      final Map<String, dynamic> jasonData = response.data;
      String linkPdf = jasonData['download_url'];
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