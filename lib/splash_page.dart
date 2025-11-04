import 'package:flutter/material.dart';
import 'package:respire_mais/db/shared_prefs.dart';
import 'package:respire_mais/login.dart';
import 'package:respire_mais/menu.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  static const int tempoDeRespiracao = 2;
  static const int tempoTotalDaTela = 4;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this, // ticker
      duration: const Duration(seconds: tempoDeRespiracao),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.repeat(reverse: true);

    checkUserLogin();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  checkUserLogin() async {
    await Future.delayed(const Duration(seconds: tempoTotalDaTela));

    bool isLoggedIn = await SharedPrefs().getUserStatus();

    if (mounted) {
      if (isLoggedIn) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => Login(), //Menu(),
        ));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => Login(),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            ScaleTransition(
              scale: _scaleAnimation,
              child: Image.asset('assets/Logo-Respire-Carr-Contorno.png', height: 150),
            ),
            const Spacer(),
            const CircularProgressIndicator(
              backgroundColor: Color(0xFFE0E0E0), //cinza
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), //azul
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}