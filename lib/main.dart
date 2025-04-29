import 'package:flutter/material.dart';
import 'package:flutter_login/screens/login_screen.dart';
import 'package:flutter_login/screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0CB8A9),
          primary: const Color(0xFF0CB8A9),
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const RegisterScreen(),
    );
  }
}
