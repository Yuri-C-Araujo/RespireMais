import 'dart:ui';
import 'package:flutter/material.dart';

class Medicamento extends StatelessWidget {
  const Medicamento();

  static const List<Map<String, String>> medicamentos = [ // lista com os dados dos medicamentos
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
    return Scaffold( // estrutura basica em uma tela
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15), // espaçamento ao redor do botão
        child: ElevatedButton( // botão com fundo elevado
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20), // espaço interno
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            fixedSize: Size(300, 70), // largura e altura
          ),
          child: const Text(
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
        children: [ // lista de widgets que serão empilhados dento do stack
          Center(
            child: Opacity(
              opacity: 0.4,
              child: Image.asset(
                'imagem/Logo-Respire.png',
                width: 600,
                height: 600,
                fit: BoxFit.cover, // imagem preencher todo o espaço
              ),
            ),
          ),

          Positioned.fill( // preencha a area do espaço inserido
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // desfoque por cima da imagem
              child: Container(color: Colors.transparent),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15), // espaçamento interno
              child: Column( // widgets na vertical
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'MEDICAMENTOS',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row( // organiza lado a lado
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // espaço disponivel igualmente
                    children: medicamentos.map((med) { // criação da lista
                      return ListaMedicamentos(
                        nome: med['nome']!,
                        imagem: med['imagem']!,
                        horario: med['horario']!, // indica que o valor não é nulo
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
  final String nome; // o final é para que não haja alteração no construtor após atribuir os valores
  final String imagem;
  final String horario;

  const ListaMedicamentos({ //construtor com valores constantes
    required this.nome, // obrigatorio atribuir os valores
    required this.imagem,
    required this.horario,
  });

  @override //container
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(8), // espaço interno
      margin: const EdgeInsets.all (4), // espaço externo
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
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
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imagem,
              height: 80,
              width: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  height: 80,
                  width: 100,
                  child: Center(
                    child: Icon(Icons.error, color: Colors.red), // se a imagem não carregar corretamente, irá exibir um icone
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20), // espaçamento dos nomes do medicamento

          Text(
            nome,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            horario,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.lightBlueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
