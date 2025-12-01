import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import do Provider
import 'package:respire_mais/provider/user_provider.dart'; // Import do seu novo Provider
import 'package:respire_mais/splash_page.dart';

void main() {
  runApp(
    // Envolvemos o app no MultiProvider (ou ChangeNotifierProvider)
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    ),
  );
}