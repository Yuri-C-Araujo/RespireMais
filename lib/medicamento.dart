import 'dart:ui';
import 'package:flutter/material.dart';

class Medicamento extends StatefulWidget {
  const Medicamento({super.key});

  @override
  State<Medicamento> createState() => MedicamentoState();
}

class MedicamentoState extends State<Medicamento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(15),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            fixedSize: Size(300, 60),
          ),
          child: Text(
            'ADICIONAR MEDICAÇÃO',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Opacity(
              opacity: 0.4,
              child: Image.asset(
                'imagem/Logo-Respire.png',
                width: 600,
                height: 600,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.transparent),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: ListView(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'MEDICAMENTOS',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ListaMedicamentos(
                        nome: 'XALKORI',
                        imagem:
                        'https://pmlive.com/wp-content/uploads/2024/02/Pfizer-Xalkori-lung-cancer.jpg',
                        horario: '08 EM 08 HORAS',
                      ),
                      ListaMedicamentos(
                        nome: 'TAGRISSO',
                        imagem:
                        'https://pfarma.com.br/images/noticias/tagrisso-medicamento-cancer.jpg',
                        horario: '06 EM 06 HORAS',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListaMedicamentos extends StatefulWidget {
  final String nome;
  final String imagem;
  final String horario;

  ListaMedicamentos({
    required this.nome,
    required this.imagem,
    required this.horario,
    super.key,
  });

  @override
  State<ListaMedicamentos> createState() => ListaMedicamentosState();
}

class ListaMedicamentosState extends State<ListaMedicamentos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              widget.imagem,
              height: 80,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20),
          Text(
            widget.nome,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 5),
          Text(
            widget.horario,
            style: TextStyle(
              fontSize: 15,
              color: Colors.lightBlueAccent,
            ),
          ),
        ],
      ),
    );
  }
}