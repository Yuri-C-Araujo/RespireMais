import 'package:flutter/material.dart';
import 'package:respire_mais/Banco_Dados/shared_prefs.dart';
import 'package:respire_mais/Historico.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}
class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  static const int tempoDeRespiracao = 2; // Segundos para inspirar (ou expirar)
  static const int tempoTotalDaTela = 4; // Segundos totais que a splash fica visível
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: tempoDeRespiracao),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.repeat(reverse: true);
    checkUserHistorico();
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  checkUserHistorico() async {
    await Future.delayed(const Duration(seconds: tempoTotalDaTela));
    bool isLoggedIn = await SharedPrefs().getUserStatus();
    if (mounted) {
      if (isLoggedIn) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => Historico(),
        ));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => Historico(),
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
              backgroundColor: Color(0xFFE0E0E0),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}

