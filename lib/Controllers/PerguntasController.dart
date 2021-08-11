import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:natuvida_flutter/model/postagemDetalheModel.dart';
import 'package:natuvida_flutter/model/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:natuvida_flutter/Services/requests.dart' as Requests;

class PerguntasController extends GetxController {
  
  var id;
  SharedPreferences prefs;
  Rx<RxList<PostagemDetalheModel>> conteudo = RxList<PostagemDetalheModel>().obs;
  Rx<RxList> respostas = RxList().obs;
  YoutubePlayerController youtubePlayerController;
  RxBool isLoading = true.obs;
  final respostaController = TextEditingController();


  var questionIndex = 0.obs;

  RxString questionText = "".obs;

void buttonAvancar() {
    if (youtubePlayerController != null) youtubePlayerController = null;
    if (questionIndex.value < conteudo.value.length - 1) {
        this.respostas.value[questionIndex.value]["valor"] = respostaController.text != ""
            ? respostaController.text
            : this.respostas.value[questionIndex.value]["valor"];

        // setRespostasPreferences(this.respostas);

        questionIndex.value++;
        questionText.value = conteudo.value[questionIndex.value].texto;
        if (this.respostas.value[questionIndex.value]["valor"].toString().isNotEmpty)
          respostaController.text = this.respostas.value[questionIndex.value]["valor"];
        else
          respostaController.text = "";
        if (conteudo.value[questionIndex.value].video != null &&
            conteudo.value[questionIndex.value].video != "") {
          conteudo.value[questionIndex.value].video =
              YoutubePlayer.convertUrlToId(conteudo.value[questionIndex.value].video);
          youtubePlayerController = YoutubePlayerController(
            initialVideoId: conteudo.value[questionIndex.value].video,
            flags: YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
            ),
          )..reset();
        }
    }
  }
Future getPostagemDetalhes() async {
    try {
      var response = await Requests.getPostagemDetalhes(id.toString());
      List list = json.decode(response.body);
      RxList<PostagemDetalheModel> listDetalehs =
          new RxList<PostagemDetalheModel>();
      list.forEach((element) {
        var detail = PostagemDetalheModel.fromJson(element);
        listDetalehs.add(detail);
      });
        conteudo.value = listDetalehs;
        isLoading.value = false;
    } catch (e) {
      print(e);
    }
  }
  void geraPerguntas() {
    var userDataJson = prefs.getString("userData");
    var decoded = jsonDecode(userDataJson);
    var userData = UserModel.fromJson(decoded);
    // var respostasDecode = jsonDecode(prefs.getString("respostas"));
    this.conteudo.value.forEach((element) {
      this.respostas.value.add(
          {"idPergunta": element.id, "idUsuario": userData.id, "valor": ""});
    });
  }

  Future parseJson() async {
    if (conteudo.value.length > 0 &&
        conteudo.value[questionIndex.value].video != null &&
        conteudo.value[questionIndex.value].video != "") {
      conteudo.value[questionIndex.value].video =
          YoutubePlayer.convertUrlToId(conteudo.value[questionIndex.value].video);
      youtubePlayerController = YoutubePlayerController(
        initialVideoId: conteudo.value[questionIndex.value].video,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      )..reset();
    }
      if(conteudo.value.length > 0)
      questionText = conteudo.value[0].texto.obs;
    geraPerguntas();
  }

  void getPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  instantiateController(){
    getPostagemDetalhes().then((val) async {
      await getPrefs();
      parseJson();
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    print("Baile da Gaiola");
    // TODO: implement onClose
    isLoading.value = true;
    super.onClose();
  }
}