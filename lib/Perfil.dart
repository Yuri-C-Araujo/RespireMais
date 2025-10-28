import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:respire_mais/Loading_page.dart';
import 'api/cheetaho_api_service.dart';
import 'domain/perfil.dart';
import 'package:respire_mais/api/PerfilApi.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  bool notificacaoAtiva = true;
  bool _mostrarSenha = false;
  final PerfilApiService _perfilService = PerfilApiService();
  PerfilModel? perfil;
  bool _carregandoPerfil = true;
  final CheetahoApiService _apiService = CheetahoApiService();
  String? urlImagemOtimizada;
  bool _estaCarregandoApi = false;


  @override
  void initState() {
    super.initState();
    _mostrarLoadingEnquantoCarrega();
  }

  Future<void> _mostrarLoadingEnquantoCarrega() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          barrierDismissible: false,
          pageBuilder: (_, __, ___) => const LoadingPage(),
        ),
      );
    });

    await _carregarPerfil();

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _carregarPerfil() async {
    PerfilModel? dados = await _perfilService.getPerfil();
    if (mounted) {
      setState(() {
        perfil = dados;
        _carregandoPerfil = false;
      });
    }
  }

  Future<void> _otimizarImagem() async {
    if (_estaCarregandoApi) return;

    setState(() {
      _estaCarregandoApi = true;
    });

    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: false,
        pageBuilder: (_, __, ___) => const LoadingPage(),
      ),
    );

    final String? novaUrl = await _apiService.otimizarImagem(perfil!.urlImagemOriginal);

    Navigator.of(context).pop();

    if (novaUrl != null) {
      setState(() {
        perfil = PerfilModel(
          id: perfil!.id,
          nome: perfil!.nome,
          senha: perfil!.senha,
          diagnostico: perfil!.diagnostico,
          urlImagemOriginal: novaUrl,
        );
        urlImagemOtimizada = novaUrl;
      });
    } else {
      print("Falha ao otimizar a imagem.");
    }

    setState(() {
      _estaCarregandoApi = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //if (_carregandoPerfil) {
      //return Scaffold(body: Center(child: CircularProgressIndicator()));
    //}

    if (perfil == null) {
      return Scaffold(body: Center(child: Text("Erro ao carregar perfil.")));
    }

    String? urlParaMostrar = urlImagemOtimizada;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  'assets/Logo-Respire.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.white.withOpacity(0.5)),
            ),
            ListView(
              padding: EdgeInsets.all(16),
              children: [
                GestureDetector(
                  onTap: _otimizarImagem,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.blue[50],
                    backgroundImage: (urlImagemOtimizada != null)
                        ? NetworkImage(urlImagemOtimizada!)
                        : null,
                    child: (urlImagemOtimizada == null)
                        ? Icon(Icons.person, size: 100, color: Colors.blue[200])
                        : null,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "PERFIL",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "NOME DO USUÁRIO: ",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                Container(
                  width: 450,
                  height: 50,
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 6,
                        offset: Offset(2, 5),
                      ),
                    ],
                  ),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      perfil != null ? perfil!.nome : "Carregando...",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(0, 51, 102, 50),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  "SENHA: ",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                Container(
                  width: 450,
                  height: 50,
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 6,
                        offset: Offset(2, 5),
                      ),
                    ],
                  ),
                  child: Align(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _mostrarSenha ? (perfil?.senha ?? "") : "*******",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(0, 51, 102, 1),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _mostrarSenha
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            setState(() {
                              _mostrarSenha = !_mostrarSenha;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  "DIAGNÓSTICO: ",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                Container(
                  width: 450,
                  height: 50,
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 6,
                        offset: Offset(2, 5),
                      ),
                    ],
                  ),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      perfil != null ? perfil!.diagnostico : "Carregando...",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(0, 51, 102, 50),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  "NOTIFICAÇÕES ",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),

                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Transform.scale(
                    scale: 1.7,
                    child: Switch(
                      value: notificacaoAtiva,
                      onChanged: (bool valor) {
                        setState(() {
                          notificacaoAtiva = valor;
                        });
                        print(
                          "Notificações ${valor ? 'ativadas' : 'desativadas'}",
                        );
                      },

                      inactiveThumbColor: Colors.blue,
                      inactiveTrackColor: Colors.white,
                      activeTrackColor: Colors.blue,

                      padding: EdgeInsets.only(left: 27),
                    ),
                  ),
                ),

                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 100),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: Size(170, 60),
                      ),
                      child: Text(
                        "SAIR",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 100),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
