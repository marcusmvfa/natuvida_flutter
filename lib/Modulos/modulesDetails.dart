import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:natuvida_flutter/Controllers/PostagemController.dart';
import 'package:natuvida_flutter/Postagem/perguntas.dart';
import 'package:natuvida_flutter/bindings/perguntaBinding.dart';
import 'package:natuvida_flutter/model/postagemModel.dart';
import 'package:http/http.dart' as http;
import 'package:natuvida_flutter/Services/requests.dart' as Requests;
import 'package:natuvida_flutter/model/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModulesDetails extends StatefulWidget {
  String? id;
  String? idUsuario;
  ModulesDetails({Key? key, this.id, this.idUsuario}) : super(key: key);
  @override
  _ModulesDetailsState createState() => _ModulesDetailsState();
}

class _ModulesDetailsState extends State<ModulesDetails> {
  List<PostagemModel> listPostagens = [];
  String? idModulo;
  String? idUsuario;
  SharedPreferences? prefs;

  PostagemController? postagemController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postagemController = Get.put(PostagemController());
    postagemController!.idModulo = widget.id;
    postagemController!.getModuloPostagens();
    // getModuloPostagens();
  }

  @override
  Widget build(BuildContext context) {
    // idModulo = widget.id;
    // postagemController!.idModulo = widget.id;

    return Scaffold(
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
      body: Obx(
        () => postagemController!.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: RefreshIndicator(
                  onRefresh: postagemController!.getModuloPostagens,
                  child: new ListView.builder(
                      shrinkWrap: true,
                      itemCount: postagemController!.listPostagens.value.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            child: Container(
                              width: double.maxFinite,
                              height: 200,
                              margin: EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: Image.network(
                                          "https://secure-temple-09752.herokuapp.com" +
                                              postagemController!
                                                  .listPostagens.value[index].imgPostagem!,
                                          fit: BoxFit.fitWidth,
                                          // image: AssetImage(
                                          //     'assets/imgPosts/AUTOCONHECIMENTO.jpg'),
                                          height: 110,
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 20, top: 20),
                                            child: Container(
                                              width: (MediaQuery.of(context).size.width * 0.55),
                                              child: AutoSizeText(
                                                postagemController!
                                                    .listPostagens.value[index].title!,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize: 18, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(right: 10, top: 10),
                                              child: Container(
                                                  width: (MediaQuery.of(context).size.width * 0.10),
                                                  child: Icon(
                                                    postagemController!.listPostagens.value[index]
                                                                    .finalizada !=
                                                                null &&
                                                            postagemController!.listPostagens
                                                                .value[index].finalizada!
                                                        ? Icons.check_circle
                                                        : Icons.linear_scale,
                                                    size: 34,
                                                    color: postagemController!.listPostagens
                                                                    .value[index].finalizada !=
                                                                null &&
                                                            postagemController!.listPostagens
                                                                .value[index].finalizada!
                                                        ? Colors.green
                                                        : Colors.black,
                                                  )))
                                        ],
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 20, top: 10),
                                          child: Text("12 de set. 2020",
                                              textAlign: TextAlign.left, style: TextStyle()))
                                    ]),
                              ),
                            ),
                            onTap: () {
                              Get.to(
                                  Perguntas(
                                    id: postagemController!.listPostagens.value[index].id!,
                                    argument: postagemController!.listPostagens.value[index].title!,
                                    image:
                                        postagemController!.listPostagens.value[index].imgPostagem!,
                                  ),
                                  binding: PerguntaBinding());
                            });
                      }),
                ),
              ),
      ),
    );
  }
}
