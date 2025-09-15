import 'package:flutter/material.dart';
import 'dart:ui';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  bool notificacaoAtiva = true;

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
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Levi Soares",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
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
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "*****",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
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
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Cancer de pulmão",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              Text(
                "NOTIFICAÇÕES ",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              Align(
                alignment: AlignmentGeometry.centerLeft,
                child:
              Transform.scale(
                scale: 1.5,
                child: Switch(
                  value: notificacaoAtiva,
                  onChanged: (bool valor) {
                    setState(() {
                      notificacaoAtiva = valor;
                    });
                    print("Notificações ${valor ? 'ativadas' : 'desativadas'}");
                  },
                  activeColor: Colors.blue,
                  inactiveThumbColor: Colors.blue,
                  inactiveTrackColor: Colors.white,
                  padding: EdgeInsets.only(left: 27),

                ),
              ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
