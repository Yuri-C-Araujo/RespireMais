import 'package:respire_mais/db/DadosUsu_dao.dart';
import 'package:respire_mais/domain/DadosUsu.dart';

import 'package:flutter/material.dart';
import 'package:respire_mais/login.dart';
import 'package:respire_mais/menu.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController dataNascController = TextEditingController();
  TextEditingController oqSenteController = TextEditingController();

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
              controller: nomeController,
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
              controller: emailController,
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
              controller: senhaController,
              obscureText: true,
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
              controller: dataNascController,
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
              controller: oqSenteController,
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
                  onPressed: () async {
                    String nome = nomeController.text.trim();
                    String email = emailController.text.trim();
                    String senha = senhaController.text.trim();
                    String dataNasc = dataNascController.text.trim();
                    String oqSente = oqSenteController.text.trim();

                    DadosUsu dadosUsu = DadosUsu(
                      nome: nome,
                      email: email,
                      senha: senha,
                      dataNasc: dataNasc,
                      oqSente: oqSente,
                    );

                    await DadosUsuDao().salvar(dadosUsu);
                    await DadosUsuDao().listarCadastroUsuario();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
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
