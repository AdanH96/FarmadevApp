import 'package:farmadev/conexiones/consulta_apiCima.dart';
import 'package:flutter/material.dart';

import 'config/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    CimaApiService servicioPrueba = CimaApiService();
    servicioPrueba.pruebaCima();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FARMADEV',
      //el número que se le pase a AppTheme es el índice del color que se quiere seleccionar de la lista de colores
      theme: AppTheme().getTheme(),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('FARMADEV'),
          ),
          body: Center(child: Text('¡Bienvenido a FARMADEV!'))),
    );
  }
}
