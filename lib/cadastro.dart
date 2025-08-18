import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
        padding: EdgeInsets.all(15),
        children: [
          Center(
            child: Text(
                'CADASTRO',
              style: TextStyle(
                fontSize: 30,
                color: Colors.blue,
                fontWeight: FontWeight.w900
              ),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Text(
                  'NOME COMPLETO',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w900
                ),
              )
            ],
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(8),
            child: TextField(
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
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                'E-MAIL',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w900
                ),
              )
            ],
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(8),
            child: TextField(
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
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                'SENHA',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w900
                ),
              )
            ],
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(8),
            child: TextField(
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
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                'DATA DE NASCIMENTO',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w900
                ),
              )
            ],
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(8),
            child: TextField(
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
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                'O QUE VOCÊ SENTE?',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w900
                ),
              )
            ],
          ),
          Material(
            elevation: 10,
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
          const SizedBox(height: 35),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.blue,
                      minimumSize: Size(80, 50)
                  ),
                  child: Center(
                    child: Text(
                      'CADASTRE-SE',
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.w900


                      ),
                    ),
                  ),
                ),
              ]
          )
        ],
      ),
      )
    );
  }
}
