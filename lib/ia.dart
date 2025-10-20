import 'package:flutter/material.dart';

class Ia extends StatefulWidget {
  const Ia({super.key});

  @override
  State<Ia> createState() => _IaState();
}

class _IaState extends State<Ia> {
  TextEditingController respostaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Center(
                  child: Image.asset(
                    'assets/Assistente-Respire.png',
                    height: 250,
                  ),
                ),
                const SizedBox(height: 25),
                Center(
                  child: Text(
                    'O QUE VOCÊ ESTÁ SENTINDO HOJE?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(127, 196, 255, 50),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Row(
              children: [
                TextFormField(controller: respostaController),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(170, 60),
                  ),
                  child: Text(
                    "ENVIAR",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
