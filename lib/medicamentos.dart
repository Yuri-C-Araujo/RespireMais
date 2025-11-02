// Arquivo: lib/medicamentos.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import 'model.dart';
// import 'dao.dart'; // Não usamos mais o DAO
import 'dart:io';
import 'package:image_picker/image_picker.dart';

// <<< CORREÇÃO 1: IMPORTAR O ARQUIVO DA API >>>
import 'medicamento_api.dart'; // (Verifique se o nome do arquivo bate)

class MedicamentosPage extends StatefulWidget {
  const MedicamentosPage({super.key});

  @override
  State<MedicamentosPage> createState() => _MedicamentosPageState();
}

class _MedicamentosPageState extends State<MedicamentosPage> {
  // Instanciamos a classe 'MedicamentoApi'
  final MedicamentoApi apiService = MedicamentoApi();

  List<Medicamento> lista = [];
  bool _isLoading = true;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    carregarMedicamentos();
  }

  carregarMedicamentos() async {
    setState(() {
      _isLoading = true;
    });

    final dados = await apiService.getMedicamentos();

    setState(() {
      lista = dados;
      _isLoading = false;
    });
  }

  Future<void> adicionar() async {
    final novoMedicamento = await showDialog<Medicamento>(
      context: context,
      builder: (context) {
        final nomeCtrl = TextEditingController();
        final horarioCtrl = TextEditingController();
        String? imagePath;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateDialog) {

            // --- Função helper para o Horário (showTimePicker) ---
            Future<void> _selecionarHorario(BuildContext context) async {
              final TimeOfDay? timeOfDay = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (timeOfDay != null) {
                final String horaFormatada = timeOfDay.hour.toString().padLeft(2, '0');
                final String minutoFormatado = timeOfDay.minute.toString().padLeft(2, '0');
                setStateDialog(() {
                  horarioCtrl.text = "$horaFormatada:$minutoFormatado";
                });
              }
            }
            // --- Fim da Função helper de Horário ---

            // --- Função helper para a Imagem (image_picker) ---
            void _pegarImagem(ImageSource source) async {
              final XFile? pickedFile = await _picker.pickImage(source: source);
              if (pickedFile != null) {
                setStateDialog(() {
                  imagePath = pickedFile.path;
                });
              }
            }
            // --- Fim da Função helper de Imagem ---

            return AlertDialog(
              title: Text('Adicionar Medicamento'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(controller: nomeCtrl, decoration: InputDecoration(labelText: 'Nome')),
                    TextField(
                      controller: horarioCtrl,
                      decoration: InputDecoration(
                        labelText: 'Horário',
                        hintText: 'Clique para selecionar',
                        suffixIcon: Icon(Icons.access_time_outlined),
                      ),
                      readOnly: true,
                      onTap: () {
                        _selecionarHorario(context);
                      },
                    ),
                    SizedBox(height: 20),
                    Text('Adicionar Imagem', style: TextStyle(color: Colors.grey[700])),
                    SizedBox(height: 10),
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: imagePath == null
                          ? Center(child: Icon(Icons.image_search, size: 50, color: Colors.grey))
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(imagePath!),
                          fit: BoxFit.cover,
                          width: 120,
                          height: 120,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton.icon(
                          icon: Icon(Icons.camera_alt),
                          label: Text('Câmera'),
                          onPressed: () => _pegarImagem(ImageSource.camera),
                        ),
                        TextButton.icon(
                          icon: Icon(Icons.photo_library),
                          label: Text('Galeria'),
                          onPressed: () => _pegarImagem(ImageSource.gallery),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actionsPadding: EdgeInsets.fromLTRB(24, 0, 24, 20),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context, null),
                  child: Text('Cancelar'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    side: BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final med = Medicamento(
                      nome: nomeCtrl.text,
                      horario: horarioCtrl.text,
                      urlImagem: imagePath ?? '',
                    );
                    Navigator.pop(context, med);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.save_alt_outlined, size: 18),
                      SizedBox(width: 8),
                      Text('Salvar'),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    if (novoMedicamento != null) {
      setState(() => _isLoading = true);
      final Medicamento? medSalvo = await apiService.createMedicamento(novoMedicamento);
      if (medSalvo != null) {
        setState(() {
          lista.add(medSalvo);
        });
      }
      setState(() => _isLoading = false);
    }
  }

  deletarMedicamento(int id) async {
    setState(() {
      lista.removeWhere((med) => med.id == id);
    });
    bool sucesso = await apiService.deleteMedicamento(id);
    if (!sucesso) {
      print("Falha ao deletar. Recarregando a lista.");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Falha ao deletar medicamento.'), backgroundColor: Colors.red)
        );
      }
      carregarMedicamentos();
    }
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
                    child: _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : lista.isEmpty
                        ? Center(
                      child: Text(
                        'Nenhum medicamento cadastrado.',
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    )
                        : ListView(
                      children: [
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          alignment: WrapAlignment.center,
                          children: lista.map<Widget>((med) {
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

class MedicamentoApi {
class MedicamentoCard extends StatelessWidget {
  final Medicamento medicamento;
  final VoidCallback onDelete;

  const MedicamentoCard({required this.medicamento, required this.onDelete, super.key});

  Widget _buildImageWidget() {
    final String path = medicamento.urlImagem;

    if (path.isEmpty) {
      return Container(
        height: 80,
        width: 80,
        alignment: Alignment.center,
        color: Colors.grey[200],
        child: Icon(Icons.medical_services_outlined, size: 40, color: Colors.grey[600]),
      );
    }

    bool isNetworkUrl = path.startsWith('http://') || path.startsWith('https://');

    if (isNetworkUrl) {
      return Image.network(
        path,
        height: 80,
        width: 80,
        fit: BoxFit.cover,
        errorBuilder: (c, e, s) => Icon(Icons.broken_image_outlined, size: 40),
      );
    } else {
      return Image.file(
        File(path),
        height: 80,
        width: 80,
        fit: BoxFit.cover,
        errorBuilder: (c, e, s) {
          return Container(
              height: 80,
              width: 80,
              alignment: Alignment.center,
              color: Colors.grey[200],
              child: Icon(Icons.image_not_supported_outlined, size: 40, color: Colors.grey[600])
          );
        },
      );
    }
  }

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
              child: _buildImageWidget(),
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