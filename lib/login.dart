import 'package:respire_mais/db/DadosUsu_dao.dart';
import 'package:respire_mais/menu.dart';
import 'package:respire_mais/cadastro.dart' show Cadastro;
import 'package:flutter/material.dart';
import 'package:respire_mais/db/shared_prefs.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  bool _isLoading = false;

  void _fazerLogin() async {
    // ... (sua função _fazerLogin continua a mesma)
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });
    String email = emailController.text.trim();
    String senha = senhaController.text.trim();
    await Future.delayed(const Duration(seconds: 1));
    bool auth = await DadosUsuDao().autenticacao(email, senha);
    if (!mounted) return;
    if (auth) {
      await SharedPrefs().saveUserStatus(true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Menu();
          },
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário e/ou senha incorretos.')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

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
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              heightFactor: 0.5,
              child: Image.asset('assets/Logo-Respire.png', height: 350),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'LOGIN',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              // Adicionando a cor do cursor
              cursorColor: Colors.blue,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                // Estilo do rótulo quando está "flutuando"
                floatingLabelStyle: TextStyle(color: Colors.blue),
                // Borda quando o campo está focado (selecionado)
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: senhaController,
              obscureText: true,
              // Adicionando a cor do cursor
              cursorColor: Colors.blue,
              decoration: const InputDecoration(
                labelText: 'Senha',
                // Estilo do rótulo quando está "flutuando"
                floatingLabelStyle: TextStyle(color: Colors.blue),
                // Borda quando o campo está focado (selecionado)
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // ... (resto do seu código do botão e texto)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Cadastro()),
                );
              },
              child: const Text(
                'Não possui conta? Cadastre-se!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _fazerLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(90, 60),
              ),
              child: Center(
                child:
                    _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
