import 'package:flutter/material.dart';
import 'medicamentos.dart';

void main() {
  runApp(RespireMaisApp());
}

class RespireMaisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Respire Mais',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MedicamentosPage(),
    );
  }
}
