import 'package:flutter/material.dart';
import 'package:natuvida_flutter/Postagem/perguntas.dart';

import 'Home/home.dart';
import 'Postagem/finalizar.dart';
import 'Postagem/postagem.dart';
import 'SobreNos/sobre_nos.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Natuvida',
      initialRoute: '/',
      routes: {
        // '/': (context) => Home(),
        '/postagem': (context) => Postagem(),
        '/perguntas': (context) => Perguntas(),
        '/finalizar': (context) => Finalizar(),
        '/sobrenos' : (context) => SobreNos()
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}
