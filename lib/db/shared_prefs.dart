import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future<void> saveUserStatus(bool isLogged) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isUserLoggedIn', isLogged);
  }

  Future<bool> getUserStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isUserLoggedIn') ?? false;
  }

  Future<void> saveUserName(String nome) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', nome);
  }

  Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName') ?? '';
  }
}