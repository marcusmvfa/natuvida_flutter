import 'dart:convert';

import 'package:get/get.dart';
import 'package:natuvida_flutter/model/moduloModel.dart';
import 'package:natuvida_flutter/model/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:natuvida_flutter/Services/requests.dart' as Requests;

class ModulosController extends GetxController {
  late SharedPreferences prefs;
  RxList<ModuloModel> listPostagens = RxList<ModuloModel>();
  RxBool isLoading = true.obs;
  var nome = "".obs;
  var email = "".obs;
  var telefone = "".obs;
  var id = "".obs;
  var primeiroNome = "".obs;
  RxString das = "true".obs;

  instantiatePrefs() async {
    try {
      await SharedPreferences.getInstance().then((value) {
        prefs = value;
        var firstDecode = jsonDecode(value.getString("userData")!);

        UserModel user = UserModel.fromJson(firstDecode);
        nome.value = user.nome!;
        email.value = user.email!;
        telefone.value = user.telefone!;
        id.value = user.id!;
        primeiroNome.value = nome.split(" ").first;
      });
    } on Exception catch (e) {
      // TODO
    }
  }

  Future<void> getPostagens() async {
    var a = await Requests.getModulos();
    List dec = jsonDecode(a!.body);
    listPostagens.clear();
    dec.forEach((element) {
      var post = ModuloModel.fromJson(element);
      listPostagens.add(post);
    });
    isLoading.value = false;
    das.value = "true";
  }
}
