import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:natuvida_flutter/model/postagemModel.dart';
import 'package:natuvida_flutter/model/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:natuvida_flutter/Services/requests.dart' as Requests;

class PostagemController extends GetxController{
  Rx<RxList<PostagemModel>> listPostagens = RxList<PostagemModel>().obs;
  String idModulo;
  String idUsuario;
  SharedPreferences prefs;
  RxBool isLoading = true.obs;

  PostagemController({idModulo, idUsuario}){
    this.idModulo = idModulo;
    this.idUsuario = idUsuario;
  }


  Future<void> getModuloPostagens() async {
    await SharedPreferences.getInstance().then((value) {
      prefs = value;
      var firstDecode = jsonDecode(value.getString("userData"));

      UserModel user = UserModel.fromJson(firstDecode);
    // idModulo = widget.id;
    idUsuario = user.id;

    // var response = await http.get("https://secure-temple-09752.herokuapp.com/getPostagemDetalhes?id=" + idModulo.toString());
    var result = Requests.getModulesDetails(idUsuario, idModulo)
        .then((response) {
          var decode = json.decode(response.body);
          List list = decode["listPostagens"];
          listPostagens.value.clear();
          list.forEach((element) {
            PostagemModel postagemModel = new PostagemModel();
            postagemModel = PostagemModel.fromJson(element);
            decode["concluidas"].forEach((el) {
              if(el["idPostagem"] == element["_id"])
                postagemModel.finalizada = true;
            });
            listPostagens.value.add(postagemModel);
          });
          isLoading.value = false;
        });
  });}

}