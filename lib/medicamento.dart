import 'dart:ui';
import 'package:flutter/material.dart';

class Medicamento extends StatelessWidget {
  const Medicamento({super.key});

  static const List<Map<String, String>> medicamentos = [
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo com logo opaco
          Center(
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'imagem/Logo-Respire.png',
                width: 600,
                height: 600,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Desfoque opcional
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.transparent),
            ),
          ),

          // Conteúdo principal
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'MEDICAMENTOS',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: medicamentos.map((med) {
                      return MedicamentoCard(
                        nome: med['nome']!,
                        imagem: med['imagem']!,
                        horario: med['horario']!,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      // Ação do botão
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'ADICIONAR MEDICAÇÃO',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MedicamentoCard extends StatelessWidget {
  final String nome;
  final String imagem;
  final String horario;

  const MedicamentoCard({
    super.key,
    required this.nome,
    required this.imagem,
    required this.horario,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
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
              height: 60,
              width: 100,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const SizedBox(
                  height: 60,
                  width: 100,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  height: 60,
                  width: 100,
                  child: Center(
                    child: Icon(Icons.error, color: Colors.red),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            nome,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            horario,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
