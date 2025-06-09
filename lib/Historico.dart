import 'package:flutter/material.dart';

class Historico extends StatefulWidget {
  const Historico({super.key});

  @override
  State<Historico> createState() => _HistoricoState();
}

class _HistoricoState extends State<Historico> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
        backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 0),
              Center(child: Image.asset(
                  'assets/Respire.png',
                  height: 280,
                ),
              ),
            ],
          ),
        ),
    );
  }
}

