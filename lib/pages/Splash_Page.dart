import 'package:flutter/material.dart';
import 'package:respire_mais/pages/Historico.dart';


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
    _navigateToHome();
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  _navigateToHome() async {
   await Future.delayed(const Duration(seconds: tempoTotalDaTela));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Historico(),
        ),
      );
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
              child: Image.asset(
                'assets/Logo-Respire-Carregamento.png',
                height: 150,
              ),
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

