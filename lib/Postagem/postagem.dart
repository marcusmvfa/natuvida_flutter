import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:natuvida_flutter/Postagem/perguntas.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Postagem extends StatefulWidget {
  String? argument;

  Postagem({Key? key, this.argument}) : super(key: key);

  @override
  _PostagemState createState() => _PostagemState();
}

class _PostagemState extends State<Postagem> with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  YoutubePlayerController? _controller;

  String? caminho;

  void carregaArquivo(String arg) async {
    String argumento = arg;
    switch (argumento) {
      case 'auto-conhecimento':
        caminho = await rootBundle.loadString("assets/Auto-Conhecimento-Conteudo.json");
        break;

      case 'emocoes':
        caminho = await rootBundle.loadString("assets/Emocoes_e_cinco_linguagens_do_amor.json");
        print(caminho);
        break;

      case 'maslow':
        caminho = await rootBundle.loadString("assets/Piramide_de_Maslow.json");
        print(caminho);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    carregaArquivo(widget.argument!);

    _controller = YoutubePlayerController(
      initialVideoId: 'https://youtu.be/9OiWA0qawIo',
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
    // ..addListener(listener);
    // _videoMetaData = const YoutubeMetaData();
    // _playerState = PlayerState.unknown;
  }

  @override
  void dispose() {
    _controller!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller!.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: '9OiWA0qawIo',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );

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
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25, bottom: 50),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Center(
                  child: Chip(
                      label: Text(
                        "Auto Conhecimento",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      backgroundColor: Colors.lightGreen[600]),
                ),
              ]),
              //Imagem da postagem
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/duvida.jpg'),
                    height: 110,
                  ),
                ),
              ),
              //Titulo da Postagem
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Quem é você?",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              //Texto da postagem
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Para começar a falarmos sobre autoconhecimento, vamos compreender" +
                      "o seu significado, segundo o dicionário:" +
                      "\n \n" +
                      "Autoconhecimento: É o " +
                      "conhecimento de si próprio, das suas características, qualidades, imperfeições" +
                      ", sentimentos, etc; que caracterizam o indivíduo por si próprio." +
                      "\n \n" +
                      "E para melhor compreendermos, separamos um vídeo logo abaixo:",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20),
                height: 500,
                // child:
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Vamos Começar?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
                    color: Colors.red[50],
                    child: Text(
                      "Começar",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Perguntas(
                                    argument: caminho,
                                  )));
                    },
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
