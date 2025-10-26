import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:respire_mais/domain/Informacoes.dart';
import 'package:respire_mais/pages/Confirmacao_pdf.dart';

class Historico extends StatefulWidget {

  final List<Informacoes> informacoesCarregadas;
  const Historico({
    super.key,
    required this.informacoesCarregadas,
  });

  @override
  State<Historico> createState() => _HistoricoState();
}


class _HistoricoState extends State<Historico> {
  List<Informacoes> listInformacoes = [];

  @override
  void initState() {
    super.initState();
   listInformacoes = widget.informacoesCarregadas;
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          actions: [
            Container(
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87,
                    blurRadius: 6,
                    offset: Offset(1, 3),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ConfirmacaoPdf(),
                      ),
                  );
                },
                icon: Icon(
                  CupertinoIcons.person,
                  color: Colors.blue,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Center(
              heightFactor: 0.5,
              child: Image.asset(
                'assets/Respire.png',
                height: 280,
              ),
            ),
            Center(
              child: Text(
                'OLÁ, JOÃO',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.blue,
                  fontWeight: FontWeight.w900,
                  height: 2,
                ),
              ),
            ),
            Column(
              children: [

                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: listInformacoes.length,
                    itemBuilder: (context, i) {
                      return buildInformacao(listInformacoes[i]);
                    },
                  ),

                SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const ConfirmacaoPdf();
                        },
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    elevation: 6,
                    maximumSize: Size(450, 80),
                    padding: EdgeInsets.all(18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Gerar PDF / Compartilhar com médico',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


buildInformacao(Informacoes info) {
  return Container(
    width: 450,
    height: 95,
    padding: EdgeInsets.all(18),
    margin: EdgeInsets.all(12),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
            color: Colors.black38,
            blurRadius: 6,
            offset: Offset(2, 5)),
      ],
    ),
    child: Column(
      children: [
        Center(
          child: Text(
            "${info.datas} - Dor ${info.dor} | Fadiga: ${info.fadiga} | Efeito: ${info.efeitoColateral == '' ? "Nenhum" : info.efeitoColateral}",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black87,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    ),
  );
}