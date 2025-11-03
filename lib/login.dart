import 'package:respire_mais/db/DadosUsu_dao.dart';
import 'package:respire_mais/menu.dart';
import 'package:respire_mais/cadastro.dart' show Cadastro;
import 'package:flutter/material.dart';
import 'package:respire_mais/db/shared_prefs.dart';

// 1. Imports para a API Falsa
import 'package:respire_mais/api/banco_api.dart';
import 'package:respire_mais/domain/DadosUsu.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  bool _isLoading = false;

  // 2. Lógica de login ATUALIZADA
  void _fazerLogin() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });
    String email = emailController.text.trim();
    String senha = senhaController.text.trim();

    await Future.delayed(const Duration(seconds: 1));

    // Agora guardamos o objeto do usuário, não apenas um boolean
    DadosUsu? usuarioLogado;

    try {
      // ETAPA 1: Tenta autenticar pela API Falsa primeiro
      print('Tentando autenticação via API Falsa...');
      List<DadosUsu> usuariosDaApi = await BancoApi().findAll();

      // --- CORREÇÃO AQUI ---
      // Usamos try/catch porque firstWhere lança um erro se não encontrar
      try {
        usuarioLogado = usuariosDaApi.firstWhere(
              (u) => u.email == email && u.senha == senha,
        );
        print('Usuário encontrado na API Falsa.');
      } catch (e) {
        // Se firstWhere falhar (não encontrou), usuarioLogado continua null
        print('Usuário não encontrado na API Falsa.');
        usuarioLogado = null;
      }
      // --- FIM DA CORREÇÃO ---

      if (usuarioLogado == null) {
        // ETAPA 2: Se não encontrar na API, tenta no banco de dados local
        print('Usuário não encontrado na API. Tentando banco de dados local...');
        // A função agora retorna DadosUsu?
        usuarioLogado = await DadosUsuDao().autenticacao(email, senha);
        if (usuarioLogado != null) {
          print('Usuário encontrado no banco de dados local.');
        }
      }
    } catch (e) {
      // ETAPA 3: Se a API falhar (ex: sem internet), tenta o banco local
      print(
          'Erro ao contatar API: $e. Tentando banco de dados local como fallback...');
      usuarioLogado = await DadosUsuDao().autenticacao(email, senha);
    }

    if (!mounted) return;

    // ETAPA 4: Verifica o resultado final
    if (usuarioLogado != null) {
      // Se encontrou em QUALQUER um dos dois, faz o login
      await SharedPrefs().saveUserStatus(true);
      // --- LINHA MAIS IMPORTANTE ---
      // Salva o nome do usuário no SharedPrefs
      await SharedPrefs().saveUserName(usuarioLogado.nome);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Menu();
          },
        ),
      );
    } else {
      // Se não encontrou em NENHUM, mostra o erro
      print('Usuário não encontrado em nenhuma fonte.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Usuário não foi encontrado. Faça login ou cadastre-se.')),
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
              cursorColor: Colors.blue,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                floatingLabelStyle: TextStyle(color: Colors.blue),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: senhaController,
              obscureText: true,
              cursorColor: Colors.blue,
              decoration: const InputDecoration(
                labelText: 'Senha',
                floatingLabelStyle: TextStyle(color: Colors.blue),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
            ),
            const SizedBox(height: 32),
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
                child: _isLoading
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