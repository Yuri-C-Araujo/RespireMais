import 'package:flutter/material.dart';
import 'dart:ui';


class Relatoriodia extends StatefulWidget {
  const Relatoriodia({super.key});


  @override
  State<Relatoriodia> createState() => _RelatoriodiaState();
}


class _RelatoriodiaState extends State<Relatoriodia> {
  double niveldor = 5;
  String? _fadiga;
  bool nausea = false;
  bool faltaDeAr = false;
  bool tosse = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagem de fundo
          Center(
          child: Opacity(opacity: 0.4,
            child: Image.asset(
              'assets/Logo-Respire.png',
              fit: BoxFit.cover,
              width: 600,
              height: 600,
              ),
          ),
          ),

          // Filtro de desfoque (blur)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0), // Transparente para ativar o filtro
              ),
            ),
          ),

          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
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
                SizedBox( height: 40),


                Text(
                  'COMO VOCÊ ESTÁ SE SENTINDO HOJE? ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,


                  ),
                ),
                Material(
                  elevation: 8,
                  shadowColor: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                  child: TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox( height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'NÍVEL DE DOR ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                            onChanged: (value){
                              setState(() { niveldor = value; });
                            }

                        ),
                    ),
                    Text('10')
                  ],
                ),
                SizedBox( height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'FADIGA ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Row(
                  children: [
                    Radio<String>(
                        value: 'Leve',
                        groupValue: _fadiga,
                        onChanged: (valor){
                          setState(() {
                            _fadiga = valor;
                          });
                        }
                    ),
                    Text(
                      'LEVE',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Radio<String>(
                        value: 'Moderada',
                        groupValue: _fadiga,
                        onChanged: (valor){
                          setState(() {
                            _fadiga = valor;
                          });
                        }
                    ),
                    Text(
                      'MODERADA',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Radio<String>(
                        value: 'Intensa',
                        groupValue: _fadiga,
                        onChanged: (valor){
                          setState(() {
                            _fadiga = valor;
                          });
                        }
                    ),
                    Text(
                      'INTENSA',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox( height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'EFEITOS COLATERAIS ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Row(
                  children: [
                    Checkbox(
                        value: nausea,
                        onChanged: (bool? valor){
                          setState(() {
                            nausea = valor ?? false;
                          });
                        }
                    ),
                    Text(
                      'NÁUSEA',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Checkbox(
                        value: faltaDeAr,
                        onChanged: (bool? valor){
                          setState(() {
                            faltaDeAr = valor ?? false;
                          });
                        }
                    ),
                    Text(
                      'FALTA DE AR',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Checkbox(
                        value: tosse,
                        onChanged: (bool? valor){
                          setState(() {
                            tosse = valor ?? false;
                          });
                        }
                    ),
                    Text(
                      'TOSSE',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox( height: 10),

                ElevatedButton(
                    onPressed: (){
                      print('llllll');
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
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ),

                SizedBox(height: 15),
                Text(
                  'Sinto que você está tendo um dia difícil. Que tal respirar fundo e caminhar por 5 minutos?',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),


              ],
            ),
          )
        ],
      ),
    );


  }
}
