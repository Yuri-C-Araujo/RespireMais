import 'dart:ui';
import 'package:flutter/material.dart';

class Medicamento extends StatelessWidget   {
    const Medicamento();

  static List<Map<String, String>> medicamentos = [ // lista com os dados dos medicamentos
    {
      'nome': 'XALKORI',
      'imagem':
      'https://pmlive.com/wp-content/uploads/2024/02/Pfizer-Xalkori-lung-cancer.jpg',
      'horario': '08 EM 08 HORAS',
    },
    {
      'nome': 'TAGRISSO',
      'imagem':
      'https://pfarma.com.br/images/noticias/tagrisso-medicamento-cancer.jpg',
      'horario': '06 EM 06 HORAS',
    },

  ];

  @override
  Widget build(BuildContext context) { // retorna um widget que representa a estrutura visual da tela
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(15), // espaçamento ao redor do botão
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), // espaço interno
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

      body: Stack( // para empilhar elementos uns sobre os outros
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

          Positioned.fill( //
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // desfoque por cima da imagem
              child: Container(color: Colors.transparent),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(15), // espaçamento interno
              child: Column(
                children: [
                   SizedBox(height: 30),
                   Text(
                    'MEDICAMENTOS',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),

                  SizedBox(height: 20),

                  Row( // organiza lado a lado
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: medicamentos.map((med) { // criação da lista
                      return ListaMedicamentos(
                        nome: med['nome']!,
                        imagem: med['imagem']!,
                        horario: med['horario']!,
                      );
                    }).toList(), // transforma o conteúdo do map em uma lista
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

class ListaMedicamentos extends StatelessWidget { // criação do card
  final String nome;
  final String imagem;
  final String horario;

   ListaMedicamentos({ //construtor com valores constantes
    required this.nome,
    required this.imagem,
    required this.horario,
  });

  @override //container
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(8), // espaço interno
      margin: EdgeInsets.all (4), // espaço externo
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 4,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            child: Image.network(
              imagem,
              height: 80,
              width: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return SizedBox(
                  height: 80,
                  width: 100,
                  child: Center(
                    child: Icon(Icons.error, color: Colors.red),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 20),

          Text(
            nome,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 5),
          Text(
            horario,
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
