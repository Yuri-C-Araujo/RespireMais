import 'package:flutter/material.dart';
import 'package:respire_mais/domain/DadosUsu.dart';

class UserProvider extends ChangeNotifier {
  DadosUsu? _user;

  DadosUsu? get user => _user;
  String get nomeUsuario => _user?.nomeMaiusculo ?? "VISITANTE";


  void setUser(DadosUsu? user) {
    _user = user;
    notifyListeners();
  }
}
