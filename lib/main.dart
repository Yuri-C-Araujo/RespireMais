import 'package:flutter/material.dart';
import 'package:respire_mais/pages/Splash_Page.dart';
import 'package:provider/provider.dart';
import 'package:respire_mais/Provider/Hist_provider.dart';

void main() {
  runApp(
     MultiProvider(
       providers: [
       ChangeNotifierProvider(create: (_) => HistProvider()),
     ],
     child: const MaterialApp(
       debugShowCheckedModeBanner: false,
       home: SplashPage(),
     ),
     ),
  );
}