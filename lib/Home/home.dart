import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:natuvida_flutter/Home/modules.dart';
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

  _getPostagens() async {
    var a = await Requests.getModulos();
    List dec = jsonDecode(a);
    List<ModuloModel> listDetalhesPostagens = [];
    dec.forEach((element) {
      var post = ModuloModel.fromJson(element);
      setState(() {
        listPostagens.add(post);
        isLoading = false;
      });
    });
  }

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
    _getPostagens();
    _instantiatePrefs();
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
                          nome,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Container(
                        width: 170,
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          email,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          telefone,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ])
              ]),
              decoration: BoxDecoration(color: Colors.greenAccent),
            ),
            ListTile(
              title: Center(
                child: Text("Auto Conhecimento"),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Center(
                child: Text("Perfil"),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PerfilView()));
              },
            ),
            ListTile(
              title: Center(
                child: Text("Sobre Nós"),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, '/sobrenos');
              },
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: Text(
                      "Bem-Vindo, " + primeiroNome,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 38,
                        fontFamily: "Roboto"
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(
                        top: 25, left: 25, right: 25, bottom: 10),
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.black38, width: 2))),
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
                      child: new ListView.builder(
                          itemCount: listPostagens.length,
                          itemBuilder: (context, index) {
                            return ModuloWidget(
                                moduloModel: listPostagens[index],
                                idUsuario: id);
                          }),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
