import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import do Provider
import 'package:respire_mais/provider/user_provider.dart'; // Import do UserProvider
import 'package:respire_mais/ia.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    String nomeExibicao = userProvider.user?.nome ?? "VISITANTE";

    if (nomeExibicao != "VISITANTE") {
      nomeExibicao = nomeExibicao.split(' ')[0].toUpperCase();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(1, 3),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.person,
                color: Colors.blue,
                size: 40,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Center(
            heightFactor: 0.5,
            child: Image.asset(
              'assets/Logo-Respire.png',
              height: 300,
            ),
          ),
          Center(
            child: Text(
              'OLÁ, $nomeExibicao',
              style: TextStyle(
                fontSize: 28,
                color: Colors.blue,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),

          const SizedBox(height: 20),
          // Primeira linha de botões
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  minimumSize: Size(140, 140),
                  elevation: 6,
                  shadowColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 60, color: Colors.blue),
                    SizedBox(height: 8),
                    Text('AGENDA', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  minimumSize: Size(140, 140),
                  elevation: 6,
                  shadowColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.medical_services, size: 60, color: Colors.blue),
                    SizedBox(height: 8),
                    Text('MEDICAMENTOS', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.blue)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Segunda linha de botões
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  minimumSize: Size(140, 140),
                  elevation: 6,
                  shadowColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.note_alt_outlined, size: 60, color: Colors.blue),
                    SizedBox(height: 8),
                    Text('RELATÓRIO', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  minimumSize: Size(140, 140),
                  elevation: 6,
                  shadowColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.menu_book_outlined, size: 60, color: Colors.blue),
                    SizedBox(height: 8),
                    Text('HISTÓRICO', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Terceira linha
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Ia()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
                minimumSize: Size(140, 140),
                elevation: 6,
                shadowColor: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.psychology_alt_outlined, size: 60, color: Colors.blue),
                  SizedBox(height: 8),
                  Text('ASSISTENTE', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}