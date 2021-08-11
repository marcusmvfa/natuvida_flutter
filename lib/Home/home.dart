import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:natuvida_flutter/Controllers/ModulosController.dart';
import 'package:natuvida_flutter/Modulos/modules.dart';
import 'package:natuvida_flutter/Perfil/perfil.dart';
import 'package:natuvida_flutter/Postagem/perguntas.dart';
import 'package:natuvida_flutter/Services/requests.dart' as Requests;
import 'package:natuvida_flutter/model/moduloModel.dart';
import 'package:natuvida_flutter/model/postagemDetalheModel.dart';
import 'package:natuvida_flutter/model/postagemModel.dart';
import 'package:natuvida_flutter/model/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferences prefs;
  String nome = "";
  String email = "";
  String telefone = "";
  String id = "";
  String primeiroNome = "";
  List<ModuloModel> listPostagens = [];
  bool isLoading = false;

  final modulosController = Get.put(ModulosController());

  _instantiatePrefs() async {
    await SharedPreferences.getInstance().then((value) {
      prefs = value;
      var firstDecode = jsonDecode(value.getString("userData"));

      UserModel user = UserModel.fromJson(firstDecode);
      setState(() {
        nome = user.nome;
        email = user.email;
        telefone = user.telefone;
        id = user.id;
        primeiroNome = nome.split(" ").first;
      });
    });
  }

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    // Requests.getUsers();
    modulosController.getPostagens();
    modulosController.instantiatePrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            child: Stack(
          children: [
            ListView(padding: EdgeInsets.zero, children: [
              DrawerHeader(
                child: new BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 0.7, sigmaY: 0.7),
                  child: new Container(
                    decoration:
                        new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                    child: Row(children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/natuvida_logo.png'),
                          ),
                        ),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 170,
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                modulosController.nome.value,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Container(
                              width: 170,
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                modulosController.email.value,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                modulosController.telefone.value,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ])
                    ]),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  image: DecorationImage(
                      image: new ExactAssetImage("assets/background-white.jpg"),
                      fit: BoxFit.fill),
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[200])),
                child: ListTile(
                  title: Center(
                    child: Text("Auto Conhecimento"),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[200])),
                child: ListTile(
                  title: Center(
                    child: Text("Perfil"),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PerfilView()));
                  },
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[200])),
                child: ListTile(
                  title: Center(
                    child: Text("Sobre Nós"),
                  ),
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/sobrenos');
                  },
                ),
              ),
            ]),
            Positioned(
              bottom: 25,
              left: 100,
              child: Text("Copyright @ 2021"),
            )
          ],
        )),
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: Colors.black),
          title: Container(
            width: 250,
            child: Text(
              "Business Capacitation",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: GetX<ModulosController>(
            init: modulosController,
            builder: (_) {
              if (modulosController.isLoading.value)
                return Center(child: CircularProgressIndicator());
              else
                return Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Text(
                          "Bem-Vindo(a), " +
                              modulosController.primeiroNome.value,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 38,
                              fontFamily: "Roboto"),
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(
                            top: 25, left: 25, right: 25, bottom: 10),
                        padding: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black38, width: 2))),
                        child: Text(
                          "Modulos Disponíveis",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          child: RefreshIndicator(
                            onRefresh: modulosController.getPostagens,
                            child: new ListView.builder(
                                itemCount:
                                    modulosController.listPostagens.length,
                                itemBuilder: (context, index) {
                                  return ModuloWidget(
                                      moduloModel: modulosController
                                          .listPostagens[index],
                                      idUsuario: id);
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
            }));
  }
}
