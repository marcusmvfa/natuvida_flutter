import 'package:flutter/material.dart';

class Finalizar extends StatefulWidget {
  @override
  _FinalizarState createState() => _FinalizarState();
}

class _FinalizarState extends State<Finalizar> {
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
                  "Obrigado por suas respostas!",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                height: 300,
                width: double.maxFinite,
                decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Positioned(child: Icon(Icons.star,size: 120, color: Colors.amber,),),
                    Positioned(right: 50, top: 90, child: Opacity(opacity: 0.6, child: Icon(Icons.star,size: 100, color: Colors.amber),),),
                    Positioned(right: 30, top: 70, child: Opacity(opacity: 0.7, child: Icon(Icons.star,size: 100, color: Colors.amber),),),
                    Positioned(right: 50, top: 50, child: Opacity(opacity: 0.8, child: Icon(Icons.star,size: 100, color: Colors.amber),),),
                    Positioned(right: 70, top: 30, child: Opacity(opacity: 0.9, child: Icon(Icons.star,size: 100, color: Colors.amber,),),),
                    // Positioned(child: Icon(Icons.star),),
                  ],
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
                      "Fechar",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/');
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
