import 'package:flutter/material.dart';
import 'package:respire_mais/db/shared_prefs.dart';
import 'package:respire_mais/login.dart';
import 'package:respire_mais/menu.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    checkUserLogin();
  }

  checkUserLogin() async {
    // Aguarda 3 segundos para mostrar a splash
    await Future.delayed(Duration(seconds: 3));

    bool isLoggedIn = await SharedPrefs().getUserStatus();

    if (mounted) { // Verifica se o widget ainda está na árvore de widgets
      if (isLoggedIn) {
        // Se estiver logado, vai para o Menu
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => Menu(),
        ));
      } else {
        // Se não, vai para o Login
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => Login(),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Cor de fundo do seu app
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset('assets/respireMais-unscreen.gif', height: 350),
            Spacer(),
            CircularProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}