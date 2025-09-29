import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  // Salva o status do login (true = logado, false = deslogado)
  Future<void> saveUserStatus(bool isLogged) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isUserLoggedIn', isLogged);
  }

  // Busca o status do login
  Future<bool> getUserStatus() async {
    final prefs = await SharedPreferences.getInstance();
    // Retorna false se o valor não for encontrado
    return prefs.getBool('isUserLoggedIn') ?? false;
  }
}