import 'package:flutter/material.dart';
import 'package:natuvida_flutter/Postagem/perguntas.dart';
import 'package:natuvida_flutter/Postagem/postagem.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Stack(
        children: [
          ListView(padding: EdgeInsets.zero, children: [
            DrawerHeader(
              child: Row(children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/profile_image.png'),
                    ),
                  ),
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 170,
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          "Marcus Vinícius da Fonseca Antunes",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Container(
                        width: 170,
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          "marcuspa3@gmail.com",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text("(45) 99844-9756",
                        style: TextStyle(fontSize: 12),),
                      ),
                    ])
              ]),
              decoration: BoxDecoration(color: Colors.greenAccent),
            ),
            ListTile(
              title: Center(
                child: Text("Auto Conhecimento"),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Center(
                child: Text("Perfil"),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Center(
                child: Text("Sobre Nós"),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, '/sobrenos');
              },
            ),
          ]),
          Positioned(
            bottom: 25,
            left: 100,
            child: Text("Copyright @ 2020"),
          )
        ],
      )),
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
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),
              padding: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black38, width: 2))),
              child: Text(
                "Ultimas Postagens",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                child: new ListView(
                  children: [
                    GestureDetector(
                        child: Container(
                          width: double.maxFinite,
                          height: 200,
                          margin: EdgeInsets.only(
                              top: 10, bottom: 10, left: 25, right: 25),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[100],
                          ),
                          child: Center(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Image(
                                      fit: BoxFit.fitWidth,
                                      image: AssetImage('assets/duvida.jpg'),
                                      height: 110,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Text(
                                          "Auto Conhecimento?",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: 20,
                                        ),
                                        child: Chip(
                                            label: Text(
                                              "Auto Conhecimento",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                            backgroundColor:
                                                Colors.lightGreen[600]),
                                      )
                                    ],
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 10),
                                      child: Text("12 de set. 2020",
                                          textAlign: TextAlign.left,
                                          style: TextStyle()))
                                ]),
                          ),
                        ),
                        onTap: () {
                          // Navigator.pushNamed(context, '/postagem', arguments: "auto-conhecimento");
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Perguntas(argument: 'auto-conhecimento')));
                        }),
                    GestureDetector(
                        child: Container(
                          width: double.maxFinite,
                          height: 200,
                          margin: EdgeInsets.only(
                              top: 10, bottom: 10, left: 25, right: 25),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[100],
                          ),
                          child: Center(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Image(
                                      fit: BoxFit.fitWidth,
                                      image: AssetImage('assets/duvida.jpg'),
                                      height: 110,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 20),
                                        width: 200,
                                        child: Text(
                                          "Emoções e as Cinco Linguagens do Amor",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: 20,
                                        ),
                                        child: Chip(
                                            label: Text(
                                              "Emoçoes",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                            backgroundColor:
                                                Colors.amber),
                                      )
                                    ],
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 10),
                                      child: Text("12 de set. 2020",
                                          textAlign: TextAlign.left,
                                          style: TextStyle()))
                                ]),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Perguntas(argument: 'emocoes')));
                        }),
                    GestureDetector(
                        child: Container(
                          width: double.maxFinite,
                          height: 200,
                          margin: EdgeInsets.only(
                              top: 10, bottom: 10, left: 25, right: 25),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[100],
                          ),
                          child: Center(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Image(
                                      fit: BoxFit.fitWidth,
                                      image: AssetImage('assets/duvida.jpg'),
                                      height: 110,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Text(
                                          "Pirâmide de Maslow",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: 20,
                                        ),
                                        child: Chip(
                                            label: Text(
                                              "Auto Conhecimento",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                            backgroundColor:
                                                Colors.lightGreen[600]),
                                      )
                                    ],
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 10),
                                      child: Text("12 de set. 2020",
                                          textAlign: TextAlign.left,
                                          style: TextStyle()))
                                ]),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Perguntas(argument: 'maslow')));
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
