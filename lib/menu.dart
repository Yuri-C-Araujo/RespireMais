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
      backgroundColor: Colors.white, // Define o fundo branco da tela

      appBar: AppBar(
        // Cria a barra superior (AppBar)
        toolbarHeight: 80, // Altura da AppBar
        backgroundColor: Colors.white, // Cor de fundo da AppBar
        elevation: 0, // Remove a sombra da AppBar
        actions: [
          // Adiciona itens do lado direito da AppBar
          Container(
            // Cria um container para o botão de perfil
            margin: const EdgeInsets.all(12), // Espaçamento interno do botão
            decoration: BoxDecoration(
              // Estilo do botão
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              // Bordas arredondadas (círculo)
              boxShadow: [
                // Sombra do botão
                BoxShadow(
                  color: Colors.black87,
                  blurRadius: 6,
                  offset: Offset(2, 5),
                ),
              ],
            ),
            child: IconButton(
              // Botão com ícone
              onPressed: () {
                // ação do botão
              },
              icon: const Icon(
                CupertinoIcons.person, // Ícone de pessoa (perfil)
                color: Colors.blue,
                size: 40,
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        // Permite rolar a tela
        child: Column(
          // Organiza os elementos em coluna
          mainAxisAlignment: MainAxisAlignment.start,
          // Alinha os itens no início da coluna
          children: [
            Center(
              // Centraliza o logo
              heightFactor: 0.5, // Reduz o espaço vertical ocupado
              child: Image.asset(
                'assets/Logo-Respire.png',
                height: 300, // Altura da imagem
              ),
            ),
            Text(
              'OLÁ, JOÃO',
              style: TextStyle(
                fontSize: 28, // Tamanho da fonte
                color: Colors.blue, // Cor azul
                fontWeight: FontWeight.w900, // Texto negrito
              ),
            ),

            // Primeira linha de botões
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // Espaça os botões igualmente na linha
              children: [
                // Botão 1
                ElevatedButton(
                  onPressed: () {}, // Ação ao clicar
                  style: ElevatedButton.styleFrom(
                    // Estilo do botão
                    backgroundColor: Colors.white,
                    // Cor de fundo branca
                    foregroundColor: Colors.blue,
                    // Cor dos elementos dentro
                    minimumSize: Size(140, 140),
                    // Tamanho mínimo
                    elevation: 6,
                    // Sombra
                    shadowColor: Colors.black87,
                    // Cor da sombra
                    shape: RoundedRectangleBorder(
                      // Bordas arredondadas
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Column(
                    // Conteúdo interno do botão
                    mainAxisAlignment: MainAxisAlignment.center,
                    // Centraliza o conteúdo
                    children: [
                      Icon(
                        Icons.calendar_today_outlined, // Ícone de calendário
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

            const SizedBox(height: 20), // Espaço entre as linhas
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

            const SizedBox(height: 20), // Espaço antes do último botão
            // Terceira linha
            Center(
              child: ElevatedButton(
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
          ],
        ),
      ),
    );
  }
}
