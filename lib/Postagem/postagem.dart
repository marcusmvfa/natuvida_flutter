import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Postagem extends StatefulWidget {
  @override
  _PostagemState createState() => _PostagemState();
}

class _PostagemState extends State<Postagem>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  YoutubePlayerController _controller;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print(ModalRoute.of(context).settings.arguments);

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
    )..addListener(listener);
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
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
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  onReady: () {
                    _isPlayerReady = true;
                    _controller.addListener(listener);
                  },
                ),
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.only(
                        left: 40, right: 40, top: 10, bottom: 10),
                    color: Colors.red[50],
                    child: Text(
                      "Começar",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/perguntas');
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
