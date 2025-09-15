import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:respire_mais/RelatorioDAO.dart';
import 'package:respire_mais/relatorio.dart';
import 'ConfirmarSalvamento.dart';

class Relatoriodia extends StatefulWidget {
  const Relatoriodia({super.key});

  @override
  State<Relatoriodia> createState() => _RelatoriodiaState();
}

class _RelatoriodiaState extends State<Relatoriodia> {
  double niveldor = 5;
  String? fadiga;
  bool nausea = false;
  bool faltaDeAr = false;
  bool tosse = false;
  TextEditingController descricaoCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset('assets/Logo-Respire.png', fit: BoxFit.cover),
            ),
          ),

          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.white.withOpacity(0.5)),
          ),

          ListView(
            padding: EdgeInsets.all(16),
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'RELATÓRIO',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      'DIÁRIO',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),

              Text(
                'COMO VOCÊ ESTÁ SE SENTINDO HOJE? ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  textSelectionTheme: TextSelectionThemeData(
                    selectionHandleColor: Colors.blue, // Cor da gotinha
                  ),
                ),
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(8),
                  child: TextField(
                    controller: descricaoCont,
                    maxLines: 4,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      hintText:
                          'Fale como você está ultimamente, dificuldades, acontecimentos etc.',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 15),

              Text(
                'NÍVEL DE DOR ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              Row(
                children: [
                  Text('0'),
                  Expanded(
                    child: Slider(
                      value: niveldor,
                      min: 0,
                      max: 10,
                      divisions: 10,
                      activeColor: Colors.blue,
                      inactiveColor: Colors.grey[300],
                      label: niveldor.round().toString(),
                      onChanged: (valor) {
                        setState(() {
                          niveldor = valor;
                        });
                      },
                    ),
                  ),
                  Text('10'),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'FADIGA ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              Row(
                children: [
                  Radio<String>(
                    value: 'Leve',
                    groupValue: fadiga,
                    activeColor: Colors.blue,
                    onChanged: (valor) {
                      setState(() {
                        fadiga = valor;
                      });
                    },
                  ),
                  Text(
                    'LEVE',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),

                  Radio<String>(
                    value: 'Moderada',
                    groupValue: fadiga,
                    activeColor: Colors.blue,
                    onChanged: (valor) {
                      setState(() {
                        fadiga = valor;
                      });
                    },
                  ),
                  Text(
                    'MODERADA',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Radio<String>(
                    value: 'Intensa',
                    groupValue: fadiga,
                    activeColor: Colors.blue,
                    onChanged: (valor) {
                      setState(() {
                        fadiga = valor;
                      });
                    },
                  ),
                  Text(
                    'INTENSA',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'EFEITOS COLATERAIS ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              Row(
                children: [
                  Checkbox(
                    value: nausea,
                    activeColor: Colors.blue,
                    onChanged: (bool? valor) {
                      setState(() {
                        nausea = valor ?? false;
                      });
                    },
                  ),
                  Text(
                    'NÁUSEA',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Checkbox(
                    value: faltaDeAr,
                    activeColor: Colors.blue,
                    onChanged: (bool? valor) {
                      setState(() {
                        faltaDeAr = valor ?? false;
                      });
                    },
                  ),
                  Text(
                    'FALTA DE AR',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Checkbox(
                    value: tosse,
                    activeColor: Colors.blue,
                    onChanged: (bool? valor) {
                      setState(() {
                        tosse = valor ?? false;
                      });
                    },
                  ),
                  Text(
                    'TOSSE',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              SizedBox(height: 10),

              ElevatedButton(
                onPressed: () async {
                  bool? confirmar = await Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      barrierDismissible: false,
                      pageBuilder: (_, __, ___) => const ConfirmarSalvamento(),
                    ),
                  );

                  if (confirmar == true) {
                    String descricao = descricaoCont.text;
                    String data = DateTime.now().toIso8601String();

                    Relatorio relatorio = Relatorio(
                      descricao: descricao,
                      niveldor: niveldor,
                      fadiga: fadiga,
                      nausea: nausea,
                      faltaDeAr: faltaDeAr,
                      tosse: tosse,
                      data: data,
                    );

                    await RelatorioDao().salvarRelatorio(relatorio);
                    await RelatorioDao().listarEImprimirRelatorios();

                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Relatório salvo com sucesso!')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Operação cancelada')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'SALVAR RELATÓRIO',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 20),
              Text(
                'Sinto que você está tendo um dia difícil. Que tal respirar fundo e caminhar por 5 minutos?',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
