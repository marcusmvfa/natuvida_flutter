import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:natuvida_flutter/Login/onboarding_screen.dart';
import 'package:natuvida_flutter/Login/login.dart';
import 'package:natuvida_flutter/Postagem/perguntas.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home/home.dart';
import 'Postagem/finalizar.dart';
import 'Postagem/postagem.dart';
import 'SobreNos/sobre_nos.dart';
import 'package:device_preview/device_preview.dart';

import 'bindings/perguntaBinding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences? prefs = await SharedPreferences.getInstance();
  var page;

  bool? login = prefs.getBool("isLogged");

  if (login == null) {
    login = false;
  }

  page = login == false ? OnboardingScreen() : Home();
  runApp(
    // DevicePreview(
    // builder: (context) => MyApp(page: page),
    MyApp(page: page),
    // ),
  );
}

class MyApp extends StatelessWidget {
  var page;
  MyApp({Key? key, this.page}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bussiness Capacitation',
      initialRoute: '/',
      routes: {
        // '/': (context) => Home(),
        '/home': (context) => Home(),
        '/postagem': (context) => Postagem(),
        '/perguntas': (context) => Perguntas(),
        '/finalizar': (context) => Finalizar(),
        '/sobrenos': (context) => SobreNos()
      },
      getPages: [GetPage(name: "/perguntas", page: () => Perguntas(), binding: PerguntaBinding())],

      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xffF9F9F9),
        cardColor: Color(0xffD3E4CD),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // locale: DevicePreview.locale(context), // Add the locale here
      // builder: DevicePreview.appBuilder,
      home: page,
    );
  }
}
