import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:respire_mais/API/API_service.dart';
import 'package:respire_mais/domain/Informacoes.dart';
import 'package:respire_mais/pages/Confirmacao_pdf.dart';


class Historico extends StatefulWidget {

  const Historico({
    super.key,
  });

  @override
  State<Historico> createState() => _HistoricoState();
}


class _HistoricoState extends State<Historico> {
  late Future<List<Informacoes>> _historicoFuture;
  List<Informacoes> _listaCarregada = [];

  @override
  void initState() {
    super.initState();
    _historicoFuture = ApiService.fetchHistoricoFake();
  }

  @override
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
                onPressed: () {},
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
            SizedBox(height: 20),

            FutureBuilder<List<Informacoes>>(
              future: _historicoFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Erro ao carregar histórico: ${snapshot.error}',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  _listaCarregada = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: _listaCarregada.length,
                    itemBuilder: (context, i) {
                      return _buildInformacao(_listaCarregada[i]);
                    },
                  );
                }
                return Center(child: Text('Nenhum histórico encontrado.'));
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
                      return ConfirmacaoPdf(
                          listaDeInformacoes: _listaCarregada);
                    },
                    transitionsBuilder: (context, animation, secondaryAnimation,
                        child) {
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
      ),
    );
  }


  Widget _buildInformacao(Informacoes info) {
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
              "${info.datas} - Dor ${info.dor} | Fadiga: ${info
                  .fadiga} | Efeito: ${info.efeitoColateral == ''
                  ? "Nenhum"
                  : info.efeitoColateral}",
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
}