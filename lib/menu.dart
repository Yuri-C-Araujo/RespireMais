import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// 1. Importar o SharedPrefs
import 'package:respire_mais/db/shared_prefs.dart';
// Importa a tela do assistente (exemplo, ajuste o caminho se necessário)
import 'package:respire_mais/ia.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  // 2. Criar uma variável de estado para guardar o nome
  String _nomeUsuario = "";

  @override
  void initState() {
    super.initState();
    // 3. Chamar a função para carregar o nome
    _carregarNomeUsuario();
  }

  // 4. Nova função para carregar o nome do SharedPrefs
  void _carregarNomeUsuario() async {
    String nomeCompleto = await SharedPrefs().getUserName();
    if (nomeCompleto.isNotEmpty) {
      setState(() {
        // Pega apenas o primeiro nome e coloca em maiúsculo
        _nomeUsuario = nomeCompleto.split(' ')[0].toUpperCase();
      });
    } else {
      setState(() {
        _nomeUsuario = "USUÁRIO"; // Um valor padrão
      });
    }
  }

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
            margin: const EdgeInsets.all(
                12), // Espaçamento da borda da tela para o botão
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12, // Sombra mais suave
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
        //child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            // Centraliza o logo
            heightFactor: 0.5, // Reduz o espaço vertical ocupado pela imagem
            child: Image.asset(
              'assets/Logo-Respire.png',
              height: 300,
            ),
          ),
          Center(
            child: Text(
              // 5. Usar a variável de estado aqui
              'OLÁ, $_nomeUsuario',
              style: TextStyle(
                fontSize: 28,
                color: Colors.blue,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),

          const SizedBox(height: 20), // Espaço

          // Primeira linha de botões
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // Espaça os botões igualmente na linha
            children: [
              // Botão 1
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  // Cor dos elementos dentro
                  minimumSize: Size(140, 140), //tamanho mínimo do botão
                  elevation: 6,
                  shadowColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Column(
                  // Conteúdo interno do botão
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 60,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 8), // Espaço entre ícone e texto
                    Text(
                      'AGENDA',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),

              // Botão 2 (Medicamentos)
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
                    Icon(
                      Icons.medical_services,
                      size: 60,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'MEDICAMENTOS',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
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
              // Botão 3 (Relatório)
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
                    Icon(
                      Icons.note_alt_outlined,
                      size: 60,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'RELATÓRIO',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),

              // Botão 4 (Histórico)
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
                    Icon(
                      Icons.menu_book_outlined,
                      size: 60,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'HISTÓRICO',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
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
                // Navega para a tela do assistente
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Ia()),
                );
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
                  Icon(
                    Icons.psychology_alt_outlined,
                    size: 60,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'ASSISTENTE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20), // Espaço extra no final
        ],
      ),
      //),
    );
  }
}