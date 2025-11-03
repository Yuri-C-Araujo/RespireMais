import 'package:respire_mais/db/DadosUsu_dao.dart';
import 'package:respire_mais/domain/DadosUsu.dart';
import 'package:flutter/material.dart';
import 'package:respire_mais/login.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// 1. Imports necessários para a API de CEP
// (Mantendo os imports que você ajustou)
import 'package:respire_mais/domain/endereco.dart';
import 'package:respire_mais/api/endereco_api.dart';
import 'package:dio/dio.dart'; // Para tratar erros da API

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  // Controladores antigos
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController dataNascController = TextEditingController();
  TextEditingController oqSenteController = TextEditingController();

  // 2. Controladores novos para o endereço
  TextEditingController cepController = TextEditingController();
  TextEditingController ruaController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  // NOVO CAMPO
  TextEditingController estadoController = TextEditingController();

  // 3. Instância da API de endereço
  final EnderecoApi _enderecoApi = EnderecoApi();
  bool _isLoading = false;
  bool _isBuscandoCep = false; // Loading para o CEP

  // Máscara para Data de Nasc.
  final maskFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  // 4. Máscara para o CEP
  final cepMaskFormatter = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
  );

  // 5. Função para buscar o CEP
  void _buscarCep() async {
    // A verificação de 9 caracteres agora é feita no onChanged
    // mas mantemos como uma segurança extra.
    if (cepController.text.length != 9) {
      return;
    }

    setState(() {
      _isBuscandoCep = true; // Mostra o loading
    });

    try {
      final cep = cepController.text.replaceAll('-', ''); // Remove o '-'
      final endereco = await _enderecoApi.findByCep(cep);

      // 6. Preenche os campos com a resposta
      setState(() {
        ruaController.text = endereco.rua;
        bairroController.text = endereco.bairro;
        cidadeController.text = endereco.cidade;
        // PREENCHE O NOVO CAMPO
        estadoController.text = endereco.estado;
      });
      FocusScope.of(context).unfocus(); // Esconde o teclado
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
        _isBuscandoCep = false; // Esconde o loading
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
      // 7. Passa os novos dados para o objeto
      cep: cepController.text.trim(),
      rua: ruaController.text.trim(),
      bairro: bairroController.text.trim(),
      cidade: cidadeController.text.trim(),
      // PASSA O NOVO CAMPO
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
            // 8. Adiciona os novos campos na tela
            TextFormField(
              controller: cepController,
              inputFormatters: [cepMaskFormatter],
              keyboardType: TextInputType.number,
              cursorColor: Colors.blue,
              // *** MUDANÇA AQUI ***
              // Adiciona o onChanged para buscar automaticamente
              onChanged: (value) {
                if (value.length == 9) {
                  _buscarCep();
                }
              },
              decoration: inputDecorationAzul.copyWith(
                labelText: 'CEP',
                hintText: '#####-###',
                // 9. Adiciona o botão de busca de CEP
                suffixIcon: _isBuscandoCep
                    ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                )
                // Removemos o botão, pois agora é automático
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
            // ADICIONA O NOVO CAMPO NA TELA
            TextFormField(
              controller: estadoController,
              cursorColor: Colors.blue,
              decoration: inputDecorationAzul.copyWith(
                labelText: 'Estado',
              ),
            ),
            const SizedBox(height: 16),
            // --- Fim dos novos campos ---
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