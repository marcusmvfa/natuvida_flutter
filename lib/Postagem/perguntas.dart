import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:natuvida_flutter/Controllers/PerguntasController.dart';
import 'package:natuvida_flutter/Controllers/PostagemController.dart';
import 'package:natuvida_flutter/model/postagemDetalheModel.dart';
import 'package:natuvida_flutter/model/userModel.dart';
import 'package:natuvida_flutter/Postagem/Finalizar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:natuvida_flutter/Services/requests.dart' as Requests;

class Perguntas extends StatefulWidget {
  String? id;
  String? argument;
  String? image;
  dynamic? postagemDetalhes;

  Perguntas({Key? key, this.id, this.argument, this.image, this.postagemDetalhes})
      : super(key: key);

  @override
  _PerguntasState createState() => _PerguntasState();
}

class _PerguntasState extends State<Perguntas> with SingleTickerProviderStateMixin {
  List perguntas = [];
  List respostas = [];
  int questionIndex = 0;
  String questionText = "";
  final respostaController = TextEditingController();
  AnimationController? _rotationController;
  Animation<double>? rotation;
  List<PostagemDetalheModel> conteudo = [];
  SharedPreferences? prefs;
  bool isLoading = false;

  PlayerState? _playerState;
  YoutubeMetaData? _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  YoutubePlayerController? _youtubePlayerController;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  PerguntasController? perguntasController;

  void _geraPerguntas() {
    var userDataJson = prefs!.getString("userData");
    var decoded = jsonDecode(userDataJson!);
    var userData = UserModel.fromJson(decoded);
    // var respostasDecode = jsonDecode(prefs.getString("respostas"));
    this.conteudo.forEach((element) {
      this.respostas.add({"idPergunta": element.id, "idUsuario": userData.id, "valor": ""});
    });
  }

  void _buttonAvancar() {
    if (_youtubePlayerController != null) _youtubePlayerController = null;
    if (questionIndex < conteudo.length - 1) {
      setState(() {
        this.respostas[questionIndex]["valor"] = respostaController.text != ""
            ? respostaController.text
            : this.respostas[questionIndex]["valor"];

        setRespostasPreferences(this.respostas);

        questionIndex++;
        questionText = conteudo[questionIndex].texto!;
        if (this.respostas[questionIndex]["valor"].toString().isNotEmpty)
          respostaController.text = this.respostas[questionIndex]["valor"];
        else
          respostaController.text = "";
        if (conteudo[questionIndex].video != null && conteudo[questionIndex].video != "") {
          conteudo[questionIndex].video =
              YoutubePlayer.convertUrlToId(conteudo[questionIndex].video!);
          _youtubePlayerController = YoutubePlayerController(
            initialVideoId: conteudo[questionIndex].video!,
            flags: YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
            ),
          )..reset();
        }
      });
    }
  }

  void _buttonRetrocerder() {
    if (questionIndex > 0) {
      setState(() {
        questionIndex--;
        questionText = conteudo[questionIndex].texto!;
        respostaController.text = this.respostas[questionIndex]["valor"];
        if (conteudo[questionIndex].video != null && conteudo[questionIndex].video != "") {
          conteudo[questionIndex].video =
              YoutubePlayer.convertUrlToId(conteudo[questionIndex].video!);
          _youtubePlayerController = YoutubePlayerController(
            initialVideoId: conteudo[questionIndex].video!,
            flags: YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
            ),
          )..reset();
        }
      });
    }
  }

  Future parseJson() async {
    if (conteudo.length > 0 &&
        conteudo[questionIndex].video != null &&
        conteudo[questionIndex].video != "") {
      conteudo[questionIndex].video = YoutubePlayer.convertUrlToId(conteudo[questionIndex].video!);
      _youtubePlayerController = YoutubePlayerController(
        initialVideoId: conteudo[questionIndex].video!,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      )..reset();
    }

    if (conteudo.length > 0) {
      setState(() {
        questionText = conteudo.first.texto!;
      });
    }
    _geraPerguntas();
  }

  Widget factoryEscolhas() {
    if (perguntasController!.conteudo.value.length > 0) {
      if (perguntasController!
                  .conteudo.value[perguntasController!.questionIndex.value].flPergunta ==
              true &&
          perguntasController!
                  .conteudo.value[perguntasController!.questionIndex.value].respostaText ==
              false &&
          perguntasController!.conteudo.value[perguntasController!.questionIndex.value].multipla ==
              null) {
        return Container(
          child: Column(children: [
            RaisedButton(
              color: perguntasController!.respostas.value[perguntasController!.questionIndex.value]
                          ["valor"] ==
                      "sim"
                  ? Colors.green
                  : Colors.white,
              child: Text(
                "Sim",
                style: TextStyle(
                    color: perguntasController!.respostas
                                .value[perguntasController!.questionIndex.value]["valor"] ==
                            "sim"
                        ? Colors.white
                        : Colors.black),
              ),
              onPressed: () {
                setState(() {
                  perguntasController!.respostas.value[perguntasController!.questionIndex.value]
                      ["valor"] = "sim";
                });
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: perguntasController!
                            .respostas.value[perguntasController!.questionIndex.value]["valor"] ==
                        "nao"
                    ? Colors.red
                    : Colors.white,
              ),
              child: Text("Não",
                  style: TextStyle(
                      color: perguntasController!.respostas
                                  .value[perguntasController!.questionIndex.value]["valor"] ==
                              "nao"
                          ? Colors.white
                          : Colors.black)),
              onPressed: () {
                setState(() {
                  perguntasController!.respostas.value[perguntasController!.questionIndex.value]
                      ["valor"] = "nao";
                });
              },
            ),
          ]),
        );
      } else if (perguntasController!
                  .conteudo.value[perguntasController!.questionIndex.value].flPergunta ==
              true &&
          perguntasController!
                  .conteudo.value[perguntasController!.questionIndex.value].respostaText ==
              false &&
          perguntasController!.conteudo.value[perguntasController!.questionIndex.value].multipla !=
              null &&
          perguntasController!
                  .conteudo.value[perguntasController!.questionIndex.value].multipla!.length >
              0) {
        List escolhas =
            perguntasController!.conteudo.value[perguntasController!.questionIndex.value].multipla!;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: escolhas.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Container(
                width: 200,
                // height: 60,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25),
                decoration: BoxDecoration(
                    color: perguntasController!.respostas
                                .value[perguntasController!.questionIndex.value]["valor"] ==
                            escolhas[index]
                        ? Colors.green
                        : Colors.white,
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          offset: Offset(0, 1),
                          spreadRadius: 1,
                          color: Colors.black12)
                    ]),
                child: Center(
                  child: Text(
                    escolhas[index].toString(),
                    style: TextStyle(
                      color: perguntasController!.respostas
                                  .value[perguntasController!.questionIndex.value]["valor"] ==
                              escolhas[index]
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
              onTap: () {
                setState(() {
                  perguntasController!.respostas.value[perguntasController!.questionIndex.value]
                      ["valor"] = escolhas[index].toString();
                });
              },
            );
          },
        );
      } else
        return Container();
    } else
      return Container();
  }

  Future getPostagemDetalhes() async {
    try {
      var response = await Requests.getPostagemDetalhes(widget.id.toString());
      List list = json.decode(response.body);
      List<PostagemDetalheModel> listDetalehs = [];
      list.forEach((element) {
        var detail = PostagemDetalheModel.fromJson(element);
        listDetalehs.add(detail);
      });
      setState(() {
        conteudo = listDetalehs;
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  Future postRespostas() async {
    var fin = json.encode(respostas);
    print(fin);
    Requests.saveResposta(fin).then((response) {
      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => Finalizar(argument: widget.image!),
          ),
        );
      }
    });
  }

  Future<void> getPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  _launchURL() async {
    if (Platform.isIOS) {
      if (await canLaunch('youtube://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw')) {
        await launch('youtube://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw',
            forceSafariVC: false);
      } else {
        if (await canLaunch('https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw')) {
          await launch('https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw');
        } else {
          throw 'Could not launch https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
        }
      }
    } else {
      const url = 'https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  setRespostasPreferences(listRespostas) {
    var strRespostas = "";
    var tes = listRespostas.toString();
    List ks = [];
    listRespostas.forEach((el) {
      var js = {"idPergunta": el["idPergunta"], "idUsuario": el["idUsuario"], "valor": el["valor"]};
      ks.add(js);
    });
    var s = jsonEncode(ks);

    prefs!.setString("respostas", s);
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      isLoading = true;
    });
    super.initState();
    _rotationController = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _rotationController!.forward();
    rotation = Tween(begin: 0.0, end: 2.0).animate(_rotationController!);
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
    perguntasController = Get.put(PerguntasController(), permanent: false);
    perguntasController!.id = widget.id;
    perguntasController!.instantiateController();
    getPostagemDetalhes().then((value) async {
      await getPrefs();
      parseJson();
    });
  }

  @override
  void dispose() {
    _rotationController!.dispose();
    if (_youtubePlayerController != null) _youtubePlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body:
          // CustomPaint(
          //   size: Size(380, 625),
          //   painter: RPSCustomPainter(),
          //   child:
          Obx(() => perguntasController!.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: perguntasController!.questionIndex.value > 0
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                      ),
                                      onPressed: () {
                                        if (perguntasController!.youtubePlayerController != null) {
                                          perguntasController!.youtubePlayerController = null;
                                        }
                                        _buttonRetrocerder();
                                      },
                                    )
                                  : Container(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 15, top: 15),
                              child: Chip(
                                  label: Text(
                                    widget.argument ?? "",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  backgroundColor: Colors.lightGreen[100]),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 15, top: 15),
                              child: Chip(
                                label: Text(
                                    (perguntasController!.questionIndex.value + 1).toString() +
                                        '/' +
                                        conteudo.length.toString()),
                                backgroundColor: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: perguntasController!.questionIndex.value <
                                      perguntasController!.conteudo.value.length - 1
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                      ),
                                      onPressed: () {
                                        if (_rotationController!.isCompleted) {
                                          _rotationController!.value = 0;
                                          _rotationController!.forward();
                                        }
                                        setState(() {
                                          if (perguntasController!.youtubePlayerController !=
                                              null) {
                                            perguntasController!.youtubePlayerController = null;
                                          }
                                        });

                                        perguntasController!.buttonAvancar();
                                      },
                                    )
                                  : Container(),
                            ),
                          ],
                        ),

                        Wrap(children: [
                          Center(
                            child: Padding(
                              padding: perguntasController!.conteudo.value.length > 0 &&
                                      perguntasController!.conteudo
                                              .value[perguntasController!.questionIndex.value] !=
                                          null &&
                                      perguntasController!
                                              .conteudo
                                              .value[perguntasController!.questionIndex.value]
                                              .title !=
                                          null
                                  ? EdgeInsets.all(20)
                                  : EdgeInsets.all(0),
                              child: Text(
                                perguntasController!.conteudo.value.length > 0 &&
                                        perguntasController!.conteudo
                                                .value[perguntasController!.questionIndex.value] !=
                                            null &&
                                        perguntasController!
                                                .conteudo
                                                .value[perguntasController!.questionIndex.value]
                                                .title !=
                                            null
                                    ? perguntasController!.conteudo
                                        .value[perguntasController!.questionIndex.value].title!
                                    : "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: RotationTransition(
                              turns: rotation!,
                              child: Container(
                                margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black12),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.red[50]!,
                                          blurRadius: 20,
                                          spreadRadius: 1,
                                          offset: Offset(7, 7))
                                    ]),
                                child: Text(
                                  perguntasController!.questionText.value,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ]),
                        (perguntasController!.conteudo.value.length > 0 &&
                                perguntasController!
                                        .conteudo.value[perguntasController!.questionIndex.value] !=
                                    null &&
                                perguntasController!.conteudo
                                        .value[perguntasController!.questionIndex.value].video !=
                                    null &&
                                perguntasController!.conteudo
                                        .value[perguntasController!.questionIndex.value].video !=
                                    "")
                            ? Container(
                                margin: EdgeInsets.only(right: 20, left: 20),
                                height: 300,
                                child: YoutubePlayerBuilder(
                                  // onExitFullScreen: () {
                                  //   // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
                                  //   SystemChrome.setPreferredOrientations(
                                  //       DeviceOrientation.values);
                                  // },
                                  player: YoutubePlayer(
                                    controller: perguntasController!.youtubePlayerController!,
                                    showVideoProgressIndicator: true,
                                    progressIndicatorColor: Colors.red,
                                    topActions: <Widget>[
                                      const SizedBox(width: 8.0),
                                      Expanded(
                                        child: Text(
                                          perguntasController!.youtubePlayerController != null
                                              ? perguntasController!
                                                  .youtubePlayerController!.metadata.title
                                              : "",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                    onReady: () {
                                      _isPlayerReady = true;
                                    },
                                    bottomActions: [RaisedButton(onPressed: () => launch)],
                                  ),
                                  builder: (context, player) => Scaffold(
                                    key: _scaffoldKey,
                                    body: ListView(
                                      children: [
                                        player,
                                      ],
                                    ),
                                  ),
                                ))
                            : Container(),
                        (perguntasController!.conteudo.value.length > 0 &&
                                perguntasController!
                                        .conteudo.value[perguntasController!.questionIndex.value] !=
                                    null &&
                                perguntasController!.conteudo
                                        .value[perguntasController!.questionIndex.value].img !=
                                    null)
                            ? Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                                margin: EdgeInsets.only(right: 30, left: 30),
                                child: Image(
                                  image: AssetImage('assets' +
                                      perguntasController!.conteudo
                                          .value[perguntasController!.questionIndex.value].img! +
                                      '.png'),
                                ),
                              )
                            : Container(),
                        factoryEscolhas(),
                        (perguntasController!.conteudo.value.length > 0 &&
                                perguntasController!
                                        .conteudo.value[perguntasController!.questionIndex.value] !=
                                    null &&
                                perguntasController!.conteudo
                                    .value[perguntasController!.questionIndex.value].respostaText!)
                            ? Container(
                                margin: EdgeInsets.all(40),
                                child: TextField(
                                  controller: respostaController,
                                  decoration: InputDecoration(
                                      // filled: true,
                                      // fillColor: Color(0x22cffdcd),
                                      border: OutlineInputBorder(),
                                      labelText: 'Resposta...'),
                                  maxLines: 2,
                                ),
                              )
                            : Container(),
                        // Spacer(),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                          padding: EdgeInsets.all(20),
                          child: perguntasController!.questionIndex.value <
                                  perguntasController!.conteudo.value.length - 1
                              ? RaisedButton(
                                  color: Colors.red[50],
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "Avançar",
                                    style: TextStyle(color: Colors.black87, fontSize: 18),
                                  ),
                                  onPressed: () {
                                    if (_rotationController!.isCompleted) {
                                      _rotationController!.value = 0;
                                      _rotationController!.forward();
                                    }
                                    perguntasController!.buttonAvancar();
                                  },
                                )
                              : RaisedButton(
                                  color: Colors.green,
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "Finalizar",
                                    style: TextStyle(color: Colors.white, fontSize: 18),
                                  ),
                                  onPressed: () {
                                    if (perguntasController!.conteudo.value.length - 1 ==
                                        perguntasController!.questionIndex.value) {
                                      respostas[questionIndex]["valor"] =
                                          respostaController.text != ""
                                              ? respostaController.text
                                              : respostas[questionIndex]["valor"];
                                    }
                                    postRespostas();
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                )),
    );

    // ),
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Color.fromARGB(118, 66, 179, 76)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path = Path();
    path.moveTo(size.width * 0.76, size.height * 0.18);
    path.quadraticBezierTo(
        size.width * 0.67, size.height * 0.22, size.width * 0.66, size.height * 0.26);
    path.cubicTo(size.width * 0.59, size.height * 0.23, size.width * 0.64, size.height * 0.32,
        size.width * 0.68, size.height * 0.34);
    path.quadraticBezierTo(
        size.width * 0.71, size.height * 0.35, size.width * 0.76, size.height * 0.37);
    path.quadraticBezierTo(
        size.width * 0.82, size.height * 0.35, size.width * 0.84, size.height * 0.34);
    path.cubicTo(size.width * 0.89, size.height * 0.32, size.width * 0.94, size.height * 0.22,
        size.width * 0.87, size.height * 0.26);
    path.quadraticBezierTo(
        size.width * 0.85, size.height * 0.22, size.width * 0.76, size.height * 0.18);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
