import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:respire_mais/provider/user_provider.dart';
import 'package:respire_mais/splash_page.dart';

void main() {
  runApp(
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