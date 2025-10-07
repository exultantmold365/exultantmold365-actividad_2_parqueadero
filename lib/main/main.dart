import 'package:app2/formularios/menu_principal.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ParqueaderoApp());
}

class AppConfig {
  static const String titulo = 'App Parqueadero';
  static final ThemeData tema = ThemeData(primarySwatch: Colors.blue);
}

class ParqueaderoApp extends StatelessWidget {
  const ParqueaderoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.titulo,
      theme: AppConfig.tema,
      home: MenuPrincipal(),
    );
  }
}
