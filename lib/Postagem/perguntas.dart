import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:natuvida_flutter/model/postagemModel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Perguntas extends StatefulWidget {
  final String argument;

  const Perguntas({Key key, this.argument}) : super(key: key);

  @override
  _PerguntasState createState() => _PerguntasState();
}

class _PerguntasState extends State<Perguntas>
    with SingleTickerProviderStateMixin {
  List perguntas = new List();
  List respostas = new List();
  int questionIndex = 0;
  String questionText = "";
  final respostaController = TextEditingController();
  AnimationController _rotationController;
  Animation rotation;
  List<PostagemModel> conteudo = new List<PostagemModel>();

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  YoutubePlayerController _youtubePlayerController;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void _geraPerguntas() {
    this.perguntas.add("O que te faz bem?");
    this.perguntas.add("O que te motiva?");
    this.perguntas.add("O que você mais gosta de fazer?");
    this.perguntas.add("O que te torna forte?");
    this.perguntas.add("O que te enfraquece?");
    this.perguntas.add("O que você precisa melhorar?");
    this.conteudo.forEach((element) {
      this.respostas.add("");
    });
  }

  void _buttonAvancar() {
    if (questionIndex < conteudo.length - 1) {
      setState(() {
        this.respostas[questionIndex] = respostaController.text;

        questionIndex++;
        questionText = conteudo[questionIndex].texto;
        if (this.respostas[questionIndex].toString().isNotEmpty)
          respostaController.text = this.respostas[questionIndex];
        else
          respostaController.text = "";
        if (conteudo[questionIndex].video != null) {
          conteudo[questionIndex].video =
              YoutubePlayer.convertUrlToId(conteudo[questionIndex].video);
          _youtubePlayerController = YoutubePlayerController(
            initialVideoId: conteudo[questionIndex].video,
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
        questionText = conteudo[questionIndex].texto;
        respostaController.text = this.respostas[questionIndex];
        if (conteudo[questionIndex].video != null) {
          conteudo[questionIndex].video =
              YoutubePlayer.convertUrlToId(conteudo[questionIndex].video);
          _youtubePlayerController = YoutubePlayerController(
            initialVideoId: conteudo[questionIndex].video,
            flags: YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
            ),
          )..reset();
        }
      });
    }
  }

  Future<String> _loadFromAsset() async {
    return await rootBundle
        .loadString("assets/Auto-Conhecimento-Conteudo.json");
  }

  Future parseJson() async {
    // String jsonString = await _loadFromAsset();
    String jsonString = widget.argument;
    switch (widget.argument) {
      case 'auto-conhecimento':
        jsonString = await rootBundle
            .loadString("assets/Auto-Conhecimento-Conteudo.json");
        break;

      case 'emocoes':
        jsonString = await rootBundle
            .loadString("assets/Emocoes_e_cinco_linguagens_do_amor.json");
        break;

      case 'maslow':
        jsonString =
            await rootBundle.loadString("assets/Piramide_de_Maslow.json");
        break;
    }
    final jsonResponse = jsonDecode(jsonString) as List;
    conteudo = jsonResponse.map((e) => PostagemModel.fromJson(e)).toList();
    // .map((data) => PostagemModel.fromJson(data))
    // .toList();

    setState(() {
      questionText = conteudo[0].texto;
    });
    _geraPerguntas();
  }

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value ?? '',
            style: const TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parseJson();
    _rotationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _rotationController.forward();
    rotation = Tween(begin: 0.0, end: 2.0).animate(_rotationController);
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.black),
        title: Container(
          width: 250,
          child: Text(
            "Natuvida",
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
          SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: questionIndex > 0 ? IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                      ),
                      onPressed: () {
                        if (_youtubePlayerController != null) {
                          _youtubePlayerController = null;
                        }
                        _buttonRetrocerder();
                      },
                    ) : Container(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15, top: 15),
                    child: Chip(
                        label: Text(
                          "Auto Conhecimento",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        backgroundColor: Colors.lightGreen[600]),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: questionIndex < conteudo.length - 1 ? IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                      ),
                      onPressed: () {
                        if (_rotationController.isCompleted) {
                          _rotationController.value = 0;
                          _rotationController.forward();
                        }
                        setState(() {
                          if (_youtubePlayerController != null) {
                            _youtubePlayerController = null;
                          }
                        });

                        _buttonAvancar();
                      },
                    ) : Container(),
                  ),
                ],
              ),

              Wrap(children: [
                Center(
                  child: RotationTransition(
                    turns: rotation,
                    child: Container(
                      margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.red[50],
                                blurRadius: 20,
                                spreadRadius: 1,
                                offset: Offset(7, 7))
                          ]),
                      child: Text(
                        questionText,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ]),
              (conteudo.length > 0 != null &&
                      conteudo[questionIndex].video != null)
                  ? Container(
                      margin: EdgeInsets.only(right: 20, left: 20),
                      height: 200,
                      child: YoutubePlayerBuilder(
                        // onExitFullScreen: () {
                        //   // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
                        //   SystemChrome.setPreferredOrientations(
                        //       DeviceOrientation.values);
                        // },
                        player: YoutubePlayer(
                          controller: _youtubePlayerController,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.red,
                          topActions: <Widget>[
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Text(
                                _youtubePlayerController.metadata.title,
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
              conteudo[questionIndex].img != null
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      margin: EdgeInsets.only(right: 30, left: 30),
                      child: Image(
                        image: AssetImage('assets/divertidamente.png'),
                      ),
                    )
                  : Container(),
              conteudo[questionIndex].flPergunta == true &&
                      conteudo[questionIndex].respostaText == false
                  ? Container(
                      child: Column(children: [
                        RaisedButton(
                          color: respostas[questionIndex] == "sim"
                              ? Colors.green
                              : Colors.white,
                          child: Text(
                            "Sim",
                            style: TextStyle(
                                color: respostas[questionIndex] == "sim"
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          onPressed: () {
                            setState(() {
                              respostas[questionIndex] = "sim";
                            });
                          },
                        ),
                        RaisedButton(
                          color: respostas[questionIndex] == "nao"
                              ? Colors.red
                              : Colors.white,
                          child: Text("Não",
                              style: TextStyle(
                                  color: respostas[questionIndex] == "nao"
                                      ? Colors.white
                                      : Colors.black)),
                          onPressed: () {
                            setState(() {
                              respostas[questionIndex] = "nao";
                            });
                          },
                        ),
                      ]),
                    )
                  : Container(),
              conteudo[questionIndex].respostaText
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
                child: questionIndex < conteudo.length - 1
                    ? RaisedButton(
                        color: Colors.red[50],
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Avançar",
                          style: TextStyle(color: Colors.black87, fontSize: 18),
                        ),
                        onPressed: () {
                          if (_rotationController.isCompleted) {
                            _rotationController.value = 0;
                            _rotationController.forward();
                          }
                          _buttonAvancar();
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
                          Navigator.of(context).pushNamed('/finalizar');
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
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
    path.quadraticBezierTo(size.width * 0.67, size.height * 0.22,
        size.width * 0.66, size.height * 0.26);
    path.cubicTo(size.width * 0.59, size.height * 0.23, size.width * 0.64,
        size.height * 0.32, size.width * 0.68, size.height * 0.34);
    path.quadraticBezierTo(size.width * 0.71, size.height * 0.35,
        size.width * 0.76, size.height * 0.37);
    path.quadraticBezierTo(size.width * 0.82, size.height * 0.35,
        size.width * 0.84, size.height * 0.34);
    path.cubicTo(size.width * 0.89, size.height * 0.32, size.width * 0.94,
        size.height * 0.22, size.width * 0.87, size.height * 0.26);
    path.quadraticBezierTo(size.width * 0.85, size.height * 0.22,
        size.width * 0.76, size.height * 0.18);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
