import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:natuvida_flutter/Controllers/ModulosController.dart';
import 'package:natuvida_flutter/Perfil/perfil.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({Key? key}) : super(key: key);

  final modulosController = Get.put(ModulosController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Stack(
      children: [
        ListView(padding: EdgeInsets.zero, children: [
          DrawerHeader(
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 0.7, sigmaY: 0.7),
              child: new Container(
                decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
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
                            style: TextStyle(fontSize: 12, color: Colors.black),
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
                  image: new ExactAssetImage("assets/background-white.jpg"), fit: BoxFit.fill),
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey[200]!)),
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
            decoration: BoxDecoration(border: Border.all(color: Colors.grey[200]!)),
            child: ListTile(
              title: Center(
                child: Text("Perfil"),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PerfilView()));
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey[200]!)),
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
    ));
  }
}
