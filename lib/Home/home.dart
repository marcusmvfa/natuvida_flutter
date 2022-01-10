import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:natuvida_flutter/Controllers/ModulosController.dart';
import 'package:natuvida_flutter/Home/components/ProfileHeader.dart';
import 'package:natuvida_flutter/Home/components/homeDrawer.dart';
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
  SharedPreferences? prefs;
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
      var firstDecode = jsonDecode(value.getString("userData")!);

      UserModel user = UserModel.fromJson(firstDecode);
      setState(() {
        nome = user.nome!;
        email = user.email!;
        telefone = user.telefone!;
        id = user.id!;
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
        drawer: HomeDrawer(),
        body: GetX<ModulosController>(
            init: modulosController,
            builder: (_) {
              if (modulosController.isLoading.value)
                return Center(child: CircularProgressIndicator());
              else
                return Container(
                  // color: Color(0xffFEF5ED),
                  child: Column(
                    children: [
                      ProfileHeader(),
                      Expanded(
                        child: SizedBox(
                          child: RefreshIndicator(
                            onRefresh: modulosController.getPostagens,
                            child: new ListView.builder(
                                itemCount: modulosController.listPostagens.length,
                                itemBuilder: (context, index) {
                                  return ModuloWidget(
                                      moduloModel: modulosController.listPostagens[index],
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
