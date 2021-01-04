import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:natuvida_flutter/Postagem/perguntas.dart';
import 'package:natuvida_flutter/Services/requests.dart' as Requests;
import 'package:natuvida_flutter/model/postagemDetalheModel.dart';
import 'package:natuvida_flutter/model/postagemModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferences prefs;
  String nome = "";
  String email = "";
  List<PostagemModel> listPostagens = [];

  _getPostagens() async {
    var a = await Requests.getPostagens();
    List dec = jsonDecode(a);
    List<PostagemDetalheModel> listDetalhesPostagens = [];
    dec.forEach((element) {
      var post = PostagemModel.fromJson(element);
      // element["postagemDetalhes"].forEach((el) {
      //   var obj = PostagemDetalheModel.fromJson(el);
      //   listDetalhesPostagens.add(obj);
      // });
      // post.detalhesPostagens = listDetalhesPostagens;
      listDetalhesPostagens = [];
      setState((){
      listPostagens.add(post);
      listPostagens.sort((a,b) => a.order.compareTo(b.order));
      });
    });
  }

  _instantiatePrefs() async {
    await SharedPreferences.getInstance().then((value) {
      prefs = value;
      setState(() {
        nome = prefs.getString("nomeCompleto");
        email = prefs.getString("email");
      });
    });
  }

  @override
  void initState() {
    Requests.getUsers();
    _getPostagens();
    _instantiatePrefs();
    super.initState();
  }

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
                      image: AssetImage('assets/natuvida_logo.png'),
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
                          nome,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Container(
                        width: 170,
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          email,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          "(45) 99999-9999",
                          style: TextStyle(fontSize: 12),
                        ),
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
                child: new ListView.builder(
                    itemCount: listPostagens.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          child: Container(
                            width: double.maxFinite,
                            height: 200,
                            margin: EdgeInsets.only(
                                top: 10, bottom: 10, left: 25, right: 25),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: Image.network(
                                        "https://secure-temple-09752.herokuapp.com" + listPostagens[index].imgPostagem,
                                        fit: BoxFit.fitWidth,
                                        // image: AssetImage(
                                        //     'assets/imgPosts/AUTOCONHECIMENTO.jpg'),
                                        height: 110,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 20, top: 20),
                                          child: Text(
                                            listPostagens[index].title,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: EdgeInsets.only(
                                        //     right: 20,
                                        //   ),
                                        //   child: Chip(
                                        //       label: Text(
                                        //         "Auto Conhecimento",
                                        //         style: TextStyle(
                                        //             color: Colors.white,
                                        //             fontWeight: FontWeight.bold,
                                        //             fontSize: 12),
                                        //       ),
                                        //       backgroundColor:
                                        //           Colors.lightGreen[600]),
                                        // )
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Perguntas(
                                      id: listPostagens[index].id,
                                        argument: listPostagens[index].title,
                                        image: listPostagens[index].imgPostagem,),),);
                          });
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
