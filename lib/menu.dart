import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
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
                  offset: Offset(2, 5),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {
                // ação do botão
              },
              icon: const Icon(
                CupertinoIcons.person,
                color: Colors.blue,
                size: 40,
              ),
            ),
          ),
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 1),
          Center(
            heightFactor: 0.5,
            child: Image.asset(
              'assets/Logo-Respire.png',
              height: 350,
            ),
          ),
          Text(
            'OLÁ, JOÃO',
            style: TextStyle(
              fontSize: 28,
              color: Colors.blue,
              fontWeight: FontWeight.w900,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
          child:
          ElevatedButton(
            onPressed: (){}, // desativa o clique, já que é só visual
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue,
              minimumSize: Size(160, 160), // tamanho do botão
              elevation: 6,
              shadowColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 80,
                  color: Colors.blue,
                ),
                SizedBox(height: 8),
                Text(
                  'AGENDA',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          ),
        ],
      ),
    );
  }
}