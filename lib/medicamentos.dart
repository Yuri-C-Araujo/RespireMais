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
            title: Text('Adicionar Medicamento'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nomeCtrl, decoration: InputDecoration(labelText: 'Nome')),
                TextField(controller: horarioCtrl, decoration: InputDecoration(labelText: 'Horário')),
                TextField(controller: urlCtrl, decoration: InputDecoration(labelText: 'URL da imagem')),
              ],
            ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, null),
                child: Text('Cancelar')),
            ElevatedButton(
              onPressed: () {
                final med = Medicamento(
                  nome: nomeCtrl.text,
                  horario: horarioCtrl.text,
                  urlImagem: urlCtrl.text,
                );
                Navigator.pop(context, med);
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );

    if (novoMedicamento != null) {
      int id = await dao.salvar(novoMedicamento);
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

  deletarMedicamento(int id) async {
    await dao.deletar(id);
    carregarMedicamentos();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(15),
          child: ElevatedButton(
            onPressed: adicionar,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              fixedSize: Size(300, 60),
            ),
            child: Text(
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
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Text('Medicamentos', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[800]),),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: [
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
            )
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
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                medicamento.urlImagem,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Icon(Icons.image_not_supported, size: 40),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(medicamento.nome, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
                  SizedBox(height: 5),
                  Text(medicamento.horario, style: TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}