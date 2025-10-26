import'dart:ui';
import 'package:flutter/material.dart';

class ConfirmacaoPdf extends StatefulWidget {
  const ConfirmacaoPdf({super.key});

  @override
  State<ConfirmacaoPdf> createState() => _ConfirmacaoPdfState();
}

class _ConfirmacaoPdfState extends State<ConfirmacaoPdf> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.1),
          body: Stack(
            children: [
              BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(color: Colors.black.withOpacity(0)),
              ),
              Center(
                child: Container(

                ),
              ),
            ],
          ),
        )
    );
  }
}
