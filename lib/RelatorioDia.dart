import 'package:flutter/material.dart';
import 'dart:ui';


class Relatoriodia extends StatefulWidget {
  const Relatoriodia({super.key});


  @override
  State<Relatoriodia> createState() => _RelatoriodiaState();
}


class _RelatoriodiaState extends State<Relatoriodia> {
  double niveldor = 5;
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
                const SizedBox( height: 60),


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


              ],
            ),
          )
        ],
      ),
    );


  }
}
