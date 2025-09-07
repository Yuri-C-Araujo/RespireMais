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
  final MedicamentoDao dao = MedicamentoDao(); //obejeto que acessa o banco
  List<Medicamento> lista = []; //mantém os medicamentos que serão exibidos na tela.

  @override
  void initState() { //Chamado uma vez quando o widget é criado.
    super.initState();
    carregarMedicamentos(); //Chama carregarMedicamentos() para pegar dados do banco e mostrar na tela
  }

  carregarMedicamentos() async {
    final dados = await dao.listar(); //busca os medicamentos no banco
    setState(() { //atualiza a interface mostrando a lista na tela.
      lista = dados;
    });
  }

  Future<void> adicionar() async { //Mostra um diálogo para o usuário digitar dados.
    final novoMedicamento = await showDialog<Medicamento>(
      context: context,
      builder: (context) {
        final nomeCtrl = TextEditingController(); //controla os campos de texto.
        final horarioCtrl = TextEditingController(); //controla os campos de texto.
        final urlCtrl = TextEditingController(); //controla os campos de texto.

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
            TextButton(onPressed: () => Navigator.pop(context, null), child: Text('Cancelar')),
            ElevatedButton( //cria o objeto com os dados fornecidos pelo usuario
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

    if (novoMedicamento != null) { //verifica se o usuario salvou
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

  deletarMedicamento(int id) async {   //Deleta medicamento
    await dao.deletar(id);
    carregarMedicamentos(); // Atualiza a lista após deletar
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
              child: ListView(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'MEDICAMENTOS',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
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

  const MedicamentoCard({required this.medicamento, required this.onDelete, super.key}); //evitar recriação desnecessarias

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [ BoxShadow(color: Colors.black, blurRadius: 4, offset: Offset(0, 2))],
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
              errorBuilder: (c, e, s) =>  Icon(Icons.image_not_supported),
            ),
          ),
           SizedBox(height: 20),
          Text(
            medicamento.nome,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
          ),
           SizedBox(height: 5),
          Text(
            medicamento.horario,
            style: TextStyle(fontSize: 15, color: Colors.lightBlueAccent),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
