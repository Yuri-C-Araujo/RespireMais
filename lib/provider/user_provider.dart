import 'package:flutter/material.dart';
import 'package:respire_mais/domain/DadosUsu.dart';

class UserProvider extends ChangeNotifier {
  // Variável que guarda os dados do usuário. Pode ser nula se ninguém estiver logado.
  DadosUsu? _user;

  // Getter para recuperar o usuário (Leitura)
  DadosUsu? get user => _user;

  // Setter para definir o usuário (Escrita)
  void setUser(DadosUsu? user) {
    _user = user;
    // Avisa a todos os "ouvintes" (telas) que os dados mudaram
    notifyListeners();
  }
}