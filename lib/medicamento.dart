import 'dart:ui';
import 'package:flutter/material.dart';

class Medicamento extends StatelessWidget {
  const Medicamento();

  static const List<Map<String, String>> medicamentos = [ // é uma lista de mapas.
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
      bottomNavigationBar: Padding( // widget no final da tela
        padding: const EdgeInsets.all(15), // espaçamento ao redor do botão
        child: ElevatedButton( // botão com fundo elevado (
          onPressed: () {}, // botão sem nada
          style: ElevatedButton.styleFrom( // estilo do botao
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15), // espaço interno
            shape: RoundedRectangleBorder( // definição do formato do botão
              borderRadius: BorderRadius.circular(8), // cantos arredondados
            ),
          ),
          child: const Text(
            'ADICIONAR MEDICAÇÃO',
            style: TextStyle( // definir aparencia de texto
              fontWeight: FontWeight.bold, // negrito
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),

      body: Stack( // conteúdo principal, um widget que permite colocar filhos em cima de outros
        children: [ // lista de widgets que serão empilhados dento do stack
          Center(
            child: Opacity(
              opacity: 0.4,
              child: Image.asset( // imagem que está salva no projeto
                'imagem/Logo-Respire.png',
                width: 500,
                height: 500, // tamanho da imagem
                fit: BoxFit.cover, // imagem preencher todo o espaço
              ),
            ),
          ),

          Positioned.fill( // ocupar todo o espaço
            child: BackdropFilter( // filtro de desfoque
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // define a intensidade do desfoque
              child: Container(color: Colors.transparent), // container transparente
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const SizedBox(height: 15), // espaçamento do topo
                  const Text(   // estilo do texto
                    'MEDICAMENTOS',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(height: 20), // espaçamento

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

class ListaMedicamentos extends StatelessWidget { // exibe informações recebidas
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
      width: 150, // largura
      padding: const EdgeInsets.all(8), // espaço interno
      margin: const EdgeInsets.all(4), // espaço externo
      decoration: BoxDecoration( // personalização
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 4,
            offset: Offset(2, 2), // intensidade em ambos os lados
          )
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8), // imagem com os cantos arrendodados
            child: Image.network( // exibe uma imagem da internet
              imagem, // exibe a imagem
              height: 80,
              width: 100,
              fit: BoxFit.cover, // faz a imagem preencher o espaço todo.
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
            style: const TextStyle( //formatação visual
              fontWeight: FontWeight.bold, // negrito
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            horario,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.lightBlueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
