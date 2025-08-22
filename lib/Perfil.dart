import 'package:flutter/material.dart';
import 'dart:ui';

class Perfil extends StatefulWidget{
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}
class _PerfilState extends State<Perfil>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Image.asset(
              'assets/Logo-Respire.png',
              fit: BoxFit.cover,
            ),
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
                  radius: 120,
                  backgroundColor: Colors.blue[50],
                  child: Icon(Icons.person, size: 200, color: Colors.blue),
                ),
              ],
          ),
        ],
      ),
    );

  }
}
