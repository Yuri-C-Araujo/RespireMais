import 'package:flutter/material.dart';

class Medicamento extends StatelessWidget {
  const Medicamento({super.key});


  final List<Map<String, String>> medicamentos = const [
    {
      'nome': 'XALKORI',
      'imagem': 'https://pmlive.com/wp-content/uploads/2024/02/Pfizer-Xalkori-lung-cancer.jpg',
      'horario': '08 EM 08 HORAS',
    },
    {
      'nome': 'TAGRISSO',
      'imagem': 'https://pfarma.com.br/images/noticias/tagrisso-medicamento-cancer.jpg',
      'horario': '06 EM 06 HORAS',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Image.asset('imagem/Logo-Respire.png'),
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
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Ação do botão
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                  child: Center(child: Icon(Icons.error, color: Colors.red)),
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
