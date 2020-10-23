import 'package:flutter/material.dart';

class Postagem extends StatefulWidget {
  @override
  _PostagemState createState() => _PostagemState();
}

class _PostagemState extends State<Postagem> {
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
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
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
                  "Para começar a falarmos sobre autoconhecimento, vamos compreender"
                  + "o seu significado, segundo o dicionário:" + "\n \n" + "Autoconhecimento: É o "
                  +"conhecimento de si próprio, das suas características, qualidades, imperfeições"
                  +", sentimentos, etc; que caracterizam o indivíduo por si próprio."
                  + "\n \n" + "E para melhor compreendermos, separamos um vídeo logo abaixo:",
                  style: TextStyle(fontSize: 18),
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
                      borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
                    color: Colors.red[50],
                    child: Text(
                      "Começar",
                      style:
                          TextStyle(fontSize: 20, ),
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
