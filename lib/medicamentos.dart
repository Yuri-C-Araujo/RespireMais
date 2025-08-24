import 'dart:ui';
import 'package:flutter/material.dart';
import 'model.dart';
import 'dao.dart';

class MedicamentosPage extends StatefulWidget {
  const MedicamentosPage({super.key});

  @override
  State<MedicamentosPage> createState() => _MedicamentosPageState();
}

class _MedicamentosPageState extends State<MedicamentosPage> {
  final MedicamentoDao dao = MedicamentoDao();
  List<Medicamento> lista = [];

  @override
  void initState() {
    super.initState();
    carregarMedicamentos();
  }

  carregarMedicamentos() async {
    final dados = await dao.listar();
    setState(() {
      lista = dados;
    });
  }

  Future<void> adicionar() async {
    final novoMedicamento = await showDialog<Medicamento>(
      context: context,
      builder: (context) {
        final nomeCtrl = TextEditingController();
        final horarioCtrl = TextEditingController();
        final urlCtrl = TextEditingController();

        return AlertDialog(
          title: const Text('Adicionar Medicamento'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nomeCtrl, decoration: const InputDecoration(labelText: 'Nome')),
              TextField(controller: horarioCtrl, decoration: const InputDecoration(labelText: 'Horário')),
              TextField(controller: urlCtrl, decoration: const InputDecoration(labelText: 'URL da imagem')),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, null), child: const Text('Cancelar')),
            ElevatedButton(
              onPressed: () {
                final med = Medicamento(
                  nome: nomeCtrl.text,
                  horario: horarioCtrl.text,
                  urlImagem: urlCtrl.text,
                );
                Navigator.pop(context, med);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );

    if (novoMedicamento != null) {
      int id = await dao.salvar(novoMedicamento); // Salva no banco e pega o ID
      setState(() {
        lista.add(Medicamento(
          id: id,
          nome: novoMedicamento.nome,
          horario: novoMedicamento.horario,
          urlImagem: novoMedicamento.urlImagem,
        ));
      });
      await dao.imprimirBanco();
    }
  }

  // Deleta medicamento
  deletarMedicamento(int id) async {
    await dao.deletar(id);
    carregarMedicamentos(); // Atualiza a lista após deletar
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15),
          child: ElevatedButton(
            onPressed: adicionar,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              fixedSize: const Size(300, 60),
            ),
            child: const Text(
              'ADICIONAR MEDICAÇÃO',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
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
            Padding(
              padding: const EdgeInsets.all(15),
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'MEDICAMENTOS',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: lista.map((med) {
                      return MedicamentoCard(
                        medicamento: med,
                        onDelete: () => deletarMedicamento(med.id!),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MedicamentoCard extends StatelessWidget {
  final Medicamento medicamento;
  final VoidCallback onDelete;

  const MedicamentoCard({required this.medicamento, required this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [const BoxShadow(color: Colors.black, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              medicamento.urlImagem,
              height: 80,
              width: 100,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => const Icon(Icons.image_not_supported),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            medicamento.nome,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
          ),
          const SizedBox(height: 5),
          Text(
            medicamento.horario,
            style: const TextStyle(fontSize: 15, color: Colors.lightBlueAccent),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
