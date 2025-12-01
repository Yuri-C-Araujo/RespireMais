import 'package:flutter/material.dart';
import 'package:respire_mais/domain/Informacoes.dart';

class HistProvider extends ChangeNotifier{
  List<Informacoes> _listInformacoes = [];
  List<Informacoes> get listInformacoes => _listInformacoes;

  void setlist(List<Informacoes> newList){
    _listInformacoes = newList;
    notifyListeners();
  }
}