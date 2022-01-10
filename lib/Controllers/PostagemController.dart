import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:natuvida_flutter/model/postagemModel.dart';
import 'package:natuvida_flutter/model/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:natuvida_flutter/Services/requests.dart' as Requests;

class PostagemController extends GetxController {
  Rx<RxList<PostagemModel>> listPostagens = RxList<PostagemModel>().obs;
  late String? idModulo;
  late String? idUsuario;
  late SharedPreferences prefs;
  RxBool isLoading = true.obs;

  PostagemController({this.idModulo, this.idUsuario});

  Future<void> getModuloPostagens() async {
    await SharedPreferences.getInstance().then((value) {
      prefs = value;
      var firstDecode = jsonDecode(value.getString("userData")!);

      UserModel user = UserModel.fromJson(firstDecode);
      // idModulo = widget.id;
      idUsuario = user.id;

      // var response = await http.get("https://secure-temple-09752.herokuapp.com/getPostagemDetalhes?id=" + idModulo.toString());
      Requests.getModulesDetails(idUsuario, idModulo).then((response) {
        if (response.statusCode == 200) {
          var decode = json.decode(response.body);
          List list = decode["listPostagens"];
          listPostagens.value.clear();
          list.forEach((element) {
            PostagemModel postagemModel = new PostagemModel();
            postagemModel = PostagemModel.fromJson(element);
            decode["concluidas"].forEach((el) {
              if (el["idPostagem"] == element["_id"]) postagemModel.finalizada = true;
            });
            listPostagens.value.add(postagemModel);
          });
          isLoading.value = false;
        } else {
          debugPrint("############### ERROR: " + response.body);
        }
      });
    });
  }
}
