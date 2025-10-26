import'dart:ui';
import 'package:flutter/material.dart';
import 'package:respire_mais/pages/Splash_Page.dart';

class ConfirmacaoPdf extends StatefulWidget {
  const ConfirmacaoPdf({super.key});

  @override
  State<ConfirmacaoPdf> createState() => _ConfirmacaoPdfState();
}

class _ConfirmacaoPdfState extends State<ConfirmacaoPdf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.black.withOpacity(0.5),
          body: Stack(
            children: [
              BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(color: Colors.black.withOpacity(0.1)),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        spreadRadius: 8,
                        offset: Offset(0, 4)
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Você realmente deseja gerar o PDF?",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed:(){
                              },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: Size(120, 50),
                            ),
                            child: Text(
                              "SIM",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ElevatedButton(
                              onPressed:(){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SplashPage(),
                                  )

                                );
                              },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: Size(120, 50),
                            ),
                            child: Text(
                              "NÃO",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
  }
}
