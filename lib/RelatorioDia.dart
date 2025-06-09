import 'package:flutter/material.dart';
import 'dart:ui';

class Relatoriodia extends StatefulWidget {
  const Relatoriodia({super.key});

  @override
  State<Relatoriodia> createState() => _RelatoriodiaState();
}

class _RelatoriodiaState extends State<Relatoriodia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.white),
          Center(
            child: ClipRect(
              child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Opacity(opacity: 0.2,
                  child: Image.asset('assets/Logo-Respire.png',
                    fit: BoxFit.cover, // ou BoxFit.contain, conforme o efeito desejado
                    width: 600,
                    height: 600,
                  ),
                ),
              ),
          ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: const[
                SizedBox(height: 60),
                Text('RELATÓRIO\nDIARIO',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue
                ),
                )
              ],
            ),
          )
      ],
      ),
    );

  }
}

