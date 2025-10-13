import 'package:respire_mais/db/DadosUsu_dao.dart';
import 'package:respire_mais/domain/DadosUsu.dart';
import 'package:flutter/material.dart';
import 'package:respire_mais/login.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController dataNascController = TextEditingController();
  TextEditingController oqSenteController = TextEditingController();
  bool _isLoading = false;

  final maskFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  void _fazerCadastro() async {
    // ... (sua função _fazerCadastro continua a mesma)
    FocusScope.of(context).unfocus();
    if (nomeController.text.isEmpty ||
        emailController.text.isEmpty ||
        senhaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha nome, e-mail e senha.'),
        ),
      );
      return;
    }
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    DadosUsu dadosUsu = DadosUsu(
      nome: nomeController.text.trim(),
      email: emailController.text.trim(),
      senha: senhaController.text.trim(),
      dataNasc: dataNascController.text.trim(),
      oqSente: oqSenteController.text.trim(),
    );
    await DadosUsuDao().salvar(dadosUsu);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cadastro efetuado com sucesso!')),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Dica: Crie uma decoração base para reutilizar
    const inputDecorationAzul = InputDecoration(
      floatingLabelStyle: TextStyle(color: Colors.blue),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2.0),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            const Center(
              child: Text(
                'CADASTRO',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: nomeController,
              cursorColor: Colors.blue,
              // Reutilizando o estilo e adicionando o labelText
              decoration: inputDecorationAzul.copyWith(
                labelText: 'Nome Completo',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: emailController,
              cursorColor: Colors.blue,
              decoration: inputDecorationAzul.copyWith(labelText: 'E-mail'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: senhaController,
              obscureText: true,
              cursorColor: Colors.blue,
              decoration: inputDecorationAzul.copyWith(labelText: 'Senha'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: dataNascController,
              inputFormatters: [maskFormatter],
              keyboardType: TextInputType.number,
              cursorColor: Colors.blue,
              decoration: inputDecorationAzul.copyWith(
                labelText: 'Data de Nascimento',
                hintText: 'DD/MM/AAAA',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: oqSenteController,
              cursorColor: Colors.blue,
              decoration: inputDecorationAzul.copyWith(
                labelText: 'O que você sente?',
              ),
            ),
            const SizedBox(height: 32),
            // ... (resto do seu código do botão)
            ElevatedButton(
              onPressed: _isLoading ? null : _fazerCadastro,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(80, 50),
              ),
              child: Center(
                child:
                    _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                          'CADASTRE-SE',
                          style: TextStyle(
                            fontSize: 23,
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