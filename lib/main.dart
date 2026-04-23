import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('meu_token_seguro');

  runApp(MyApp(estaLogado: token != null));
}

class MyApp extends StatelessWidget {
  final bool estaLogado;

  const MyApp({super.key, required this.estaLogado});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: estaLogado ? const HomeScreen() : const LoginScreen(),
    );
  }
}