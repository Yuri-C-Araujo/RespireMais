import'dart:ui';
import 'package:flutter/material.dart';
import 'package:respire_mais/domain/Informacoes.dart';
import 'package:respire_mais/API/API_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfirmacaoPdf extends StatefulWidget {
  final List<Informacoes> listaDeInformacoes;
  const ConfirmacaoPdf({
    super.key,
    required this.listaDeInformacoes,
  });

  @override
  State<ConfirmacaoPdf> createState() => _ConfirmacaoPdfState();
}

class _ConfirmacaoPdfState extends State<ConfirmacaoPdf> {

  bool _estaGerado = false;
  void _chamarApiGerarPdf() async{
    if(widget.listaDeInformacoes.isEmpty){
      print("Lista de informações vazia.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nenhum dado para gerar PDF.')),
      );
      Navigator.pop(context);
      return;
    }
    setState(() {
      _estaGerado = true;
    });
    try{
      String urlPdf = await ApiService.gerarPdfApi(widget.listaDeInformacoes);
      final Uri url = Uri.parse(urlPdf);
      if(await canLaunchUrl(url)){
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }else{
        throw 'Não foi possivel abrir o link $url';
      }
      if(mounted){
        Navigator.pop(context);
      }

    }catch (e) {
      print('Erro ao gerar PDF: $e');
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao gerar PDF: $e')),
        );
      }
    } finally {
      if(mounted) {
        setState(() {
          _estaGerado = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.black.withOpacity(0.5),
          body: Stack(
            children: [
              BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(color: Colors.black.withOpacity(0.1)),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        spreadRadius: 8,
                        offset: Offset(0, 4)
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Você realmente deseja gerar o PDF?",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed:(){
                                _estaGerado? null: _chamarApiGerarPdf;
                              },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: Size(120, 50),
                            ),
                            child: _estaGerado? CircularProgressIndicator(color: Colors.white):
                            Text(
                              "SIM",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: _estaGerado? null: (){
                               Navigator.pop(context);
                              },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: Size(120, 50),
                            ),
                            child: Text(
                              "NÃO",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
  }
}
