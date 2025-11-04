import 'package:respire_mais/db/DadosUsu_dao.dart';
import 'package:respire_mais/domain/DadosUsu.dart';
import 'package:flutter/material.dart';
import 'package:respire_mais/login.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:respire_mais/domain/endereco.dart';
import 'package:respire_mais/api/endereco_api.dart';
import 'package:dio/dio.dart';

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

  TextEditingController cepController = TextEditingController();
  TextEditingController ruaController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();

  final EnderecoApi _enderecoApi = EnderecoApi();
  bool _isLoading = false;
  bool _isBuscandoCep = false;

  final maskFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final cepMaskFormatter = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
  );

  void _buscarCep() async {
    if (cepController.text.length != 9) {
      return;
    }

    setState(() {
      _isBuscandoCep = true;
    });

    try {
      final cep = cepController.text.replaceAll('-', '');
      final endereco = await _enderecoApi.findByCep(cep);

      setState(() {
        ruaController.text = endereco.rua;
        bairroController.text = endereco.bairro;
        cidadeController.text = endereco.cidade;
        estadoController.text = endereco.estado;
      });
      FocusScope.of(context).unfocus();
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('CEP não encontrado ou erro de rede.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ocorreu um erro ao buscar o CEP.')),
      );
    } finally {
      setState(() {
        _isBuscandoCep = false;
      });
    }
  }

  void _fazerCadastro() async {
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

      cep: cepController.text.trim(),
      rua: ruaController.text.trim(),
      bairro: bairroController.text.trim(),
      cidade: cidadeController.text.trim(),
      estado: estadoController.text.trim(),
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
              controller: cepController,
              inputFormatters: [cepMaskFormatter],
              keyboardType: TextInputType.number,
              cursorColor: Colors.blue,

              onChanged: (value) {
                if (value.length == 9) {
                  _buscarCep();
                }
              },
              decoration: inputDecorationAzul.copyWith(
                labelText: 'CEP',
                hintText: '#####-###',
                suffixIcon: _isBuscandoCep
                    ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                )
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: ruaController,
              cursorColor: Colors.blue,
              decoration: inputDecorationAzul.copyWith(
                labelText: 'Rua',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: bairroController,
              cursorColor: Colors.blue,
              decoration: inputDecorationAzul.copyWith(
                labelText: 'Bairro',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: cidadeController,
              cursorColor: Colors.blue,
              decoration: inputDecorationAzul.copyWith(
                labelText: 'Cidade',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: estadoController,
              cursorColor: Colors.blue,
              decoration: inputDecorationAzul.copyWith(
                labelText: 'Estado',
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
            ElevatedButton(
              onPressed: _isLoading ? null : _fazerCadastro,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(80, 50),
              ),
              child: Center(
                child: _isLoading
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