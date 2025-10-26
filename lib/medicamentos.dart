import 'dart:ui';
import 'package:flutter/material.dart';
import 'model.dart';
import 'dao.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MedicamentosPage extends StatefulWidget {
  const MedicamentosPage({super.key});

  @override
  State<MedicamentosPage> createState() => _MedicamentosPageState();
}

class _MedicamentosPageState extends State<MedicamentosPage> {
  final MedicamentoDao dao = MedicamentoDao();
  List<Medicamento> lista = [];

  // NOVO: Instância do ImagePicker
  final ImagePicker _picker = ImagePicker();

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

  //
  // --- FUNÇÃO "adicionar()" COMPLETAMENTE MODIFICADA ---
  //
  Future<void> adicionar() async {
    final novoMedicamento = await showDialog<Medicamento>(
      context: context,
      builder: (context) {
        final nomeCtrl = TextEditingController();
        // MODIFICADO: Controller de horário será preenchido pelo TimePicker
        final horarioCtrl = TextEditingController();
        // MODIFICADO: Variável para guardar o *caminho* da imagem
        String? imagePath;

        // MODIFICADO: Usamos um StatefulBuilder para que o Dialog possa
        // atualizar seu próprio estado (para mostrar a pré-visualização da imagem)
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateDialog) {

            // --- NOVO: FUNÇÃO HELPER PARA O HORÁRIO (showTimePicker) ---
            Future<void> _selecionarHorario(BuildContext context) async {
              // Chama o seletor de horário nativo
              final TimeOfDay? timeOfDay = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );

              // Se o usuário selecionar um horário (não cancelar)
              if (timeOfDay != null) {
                // Formata o horário para um padrão 24h (ex: "08:30" ou "14:05")
                final String horaFormatada = timeOfDay.hour.toString().padLeft(2, '0');
                final String minutoFormatado = timeOfDay.minute.toString().padLeft(2, '0');

                // Atualiza o controller e a UI do Dialog
                setStateDialog(() {
                  horarioCtrl.text = "$horaFormatada:$minutoFormatado";
                });
              }
            }
            // --- FIM DA FUNÇÃO HELPER DE HORÁRIO ---


            // --- NOVO: FUNÇÃO HELPER PARA A IMAGEM (image_picker) ---
            void _pegarImagem(ImageSource source) async {
              final XFile? pickedFile = await _picker.pickImage(source: source);
              if (pickedFile != null) {
                // Atualiza o estado *dentro* do Dialog
                setStateDialog(() {
                  imagePath = pickedFile.path;
                });
              }
            }
            // --- FIM DA FUNÇÃO HELPER DE IMAGEM ---

            return AlertDialog(
              title: Text('Adicionar Medicamento'),
              // MODIFICADO: Adicionado SingleChildScrollView para evitar overflow
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(controller: nomeCtrl, decoration: InputDecoration(labelText: 'Nome')),

                    // --- MODIFICADO: CAMPO DE HORÁRIO (agora usa o TimePicker) ---
                    TextField(
                      controller: horarioCtrl,
                      decoration: InputDecoration(
                        labelText: 'Horário',
                        hintText: 'Clique para selecionar',
                        suffixIcon: Icon(Icons.access_time_outlined), // Ícone de relógio
                      ),
                      readOnly: true,  // Impede o usuário de digitar
                      onTap: () {
                        // Chama a nossa nova função helper
                        _selecionarHorario(context);
                      },
                    ),
                    // --- FIM DO CAMPO DE HORÁRIO ---

                    SizedBox(height: 20),

                    // --- NOVO: UI DE SELEÇÃO DE IMAGEM (image_picker) ---
                    Text('Adicionar Imagem', style: TextStyle(color: Colors.grey[700])),
                    SizedBox(height: 10),
                    // Container para a pré-visualização
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: imagePath == null
                          ? Center(child: Icon(Icons.image_search, size: 50, color: Colors.grey))
                          : ClipRRect( // Mostra a imagem selecionada
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
                    // Botões para Câmera ou Galeria
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
                    // --- FIM DA UI DE SELEÇÃO DE IMAGEM ---
                  ],
                ),
              ),
              //
              // --- MODIFICADO: SEÇÃO "ACTIONS" (BOTÕES ESTILIZADOS) ---
              //
              // NOVO: Adiciona um preenchimento mais generoso na parte inferior
              actionsPadding: EdgeInsets.fromLTRB(24, 0, 24, 20),

              // NOVO: Alinha os botões (um em cada canto)
              actionsAlignment: MainAxisAlignment.spaceBetween,

              actions: [
                // MODIFICADO: Botão de Cancelar como "OutlinedButton" (botão de contorno)
                OutlinedButton(
                  onPressed: () => Navigator.pop(context, null),
                  child: Text('Cancelar'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue, // Cor do texto e borda
                    side: BorderSide(color: Colors.blue), // Cor da borda
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Mesma borda do outro botão
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),

                // MODIFICADO: Botão Salvar com o estilo do seu app
                ElevatedButton(
                  onPressed: () {
                    // NOVO: Validação simples para não salvar em branco
                    if (nomeCtrl.text.isNotEmpty && horarioCtrl.text.isNotEmpty) {
                      final med = Medicamento(
                        nome: nomeCtrl.text,
                        horario: horarioCtrl.text, // Agora contém "HH:mm"
                        urlImagem: imagePath ?? '', // Salvamos o *caminho* do arquivo
                      );
                      Navigator.pop(context, med);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Cor principal
                    foregroundColor: Colors.white, // Cor do texto
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Borda igual ao seu botão principal
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  // NOVO: Adicionando um ícone para ficar mais claro
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
    // MODIFICADO: Adicionado um dialog de confirmação (boa prática)
    bool? deletar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar Exclusão'),
        content: Text('Você tem certeza que deseja excluir este medicamento?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false), // Não deleta
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true), // Sim, deleta
            child: Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    // Se o usuário confirmou (deletar == true)
    if (deletar ?? false) {
      await dao.deletar(id);
      carregarMedicamentos(); // Recarrega a lista
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // (Nenhuma mudança no bottomNavigationBar)
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
        // (Nenhuma mudança no Stack de background)
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
                    // MODIFICADO: Adicionado um ternário para mostrar mensagem se a lista estiver vazia
                    child: lista.isEmpty
                        ? Center(
                      child: Text(
                        'Nenhum medicamento adicionado.',
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    )
                        : ListView( // (O ListView/Wrap não foi modificado)
                      children: [
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          alignment: WrapAlignment.center,
                          children: lista.map((med) {
                            return MedicamentoCard(
                              medicamento: med,
                              // MODIFICADO: A função de deletar agora é chamada com confirmação
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

//
// --- CLASSE MEDICAMENTOCARD MODIFICADA (PARA LIDAR COM IMAGEM DE ARQUIVO) ---
//
class MedicamentoCard extends StatelessWidget {
  final Medicamento medicamento;
  final VoidCallback onDelete;

  const MedicamentoCard({required this.medicamento, required this.onDelete, super.key});

  // NOVO: Widget helper para decidir qual imagem mostrar (Arquivo ou Placeholder)
  Widget _buildImageWidget() {
    final String path = medicamento.urlImagem;

    // Se o caminho estiver vazio (ou não foi salvo), mostre um ícone placeholder
    if (path.isEmpty) {
      return Container( // Container para dar fundo e alinhar o ícone
        height: 80,
        width: 80,
        alignment: Alignment.center,
        color: Colors.grey[200],
        child: Icon(Icons.medical_services_outlined, size: 40, color: Colors.grey[600]),
      );
    }

    // Se começar com http, é uma URL da web (mantém compatibilidade)
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
      // MODIFICADO: Se não for URL, trate como um *caminho de arquivo* local
      return Image.file(
        File(path), // Usa Image.file()
        height: 80,
        width: 80,
        fit: BoxFit.cover,
        errorBuilder: (c, e, s) { // NOVO: Error builder melhorado para arquivos
          print('Erro ao carregar imagem do arquivo: $e');
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
              // MODIFICADO: Chama o helper que decide qual imagem mostrar
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
              onPressed: onDelete, // onDelete agora chama 'deletarMedicamento' com confirmação
            ),
          ],
        ),
      ),
    );
  }
}