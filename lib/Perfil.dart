import 'package:flutter/material.dart';
import 'dart:ui';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  bool notificacaoAtiva = true;
  bool _mostrarSenha = false;
  String senha = "minhasenha123";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.blue[50],
                child: Icon(Icons.person, size: 150, color: Colors.blue),
              ),

              SizedBox(height: 20),

              Center(
                child: Text(
                  "PERFIL",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "NOME DO USUÁRIO: ",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              Container(
                width: 450,
                height: 50,
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 6,
                      offset: Offset(2, 5),
                    ),
                  ],
                ),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    "Levi Soares Passos",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(0, 51, 102, 50),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              Text(
                "SENHA: ",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              Container(
                width: 450,
                height: 50,
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 6,
                      offset: Offset(2, 5),
                    ),
                  ],
                ),
                child: Align(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _mostrarSenha ? senha : "*******",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(0, 51, 102, 1),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _mostrarSenha ? Icons.visibility : Icons.visibility_off,
                            color: Colors.blue
                          ),
                          onPressed: () {
                            setState(() {
                              _mostrarSenha = !_mostrarSenha;
                            });
                          },
                        ),
                      ],
                    ),
                ),
              ),

              SizedBox(height: 20),

              Text(
                "DIAGNÓSTICO: ",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              Container(
                width: 450,
                height: 50,
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 6,
                      offset: Offset(2, 5),
                    ),
                  ],
                ),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    "Cancer de Pulmão",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(0, 51, 102, 50),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              Text(
                "NOTIFICAÇÕES ",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Transform.scale(
                  scale: 1.7,
                  child: Switch(
                    value: notificacaoAtiva,
                    onChanged: (bool valor) {
                      setState(() {
                        notificacaoAtiva = valor;
                      });
                      print(
                        "Notificações ${valor ? 'ativadas' : 'desativadas'}",
                      );
                    },

                    inactiveThumbColor: Colors.blue,
                    inactiveTrackColor: Colors.white,
                    activeTrackColor: Colors.blue,

                    padding: EdgeInsets.only(left: 27),
                  ),
                ),
              ),

              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 100),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(170, 60)
                    ),
                    child: Text(
                      "SAIR",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 100),
                ],
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }
}
