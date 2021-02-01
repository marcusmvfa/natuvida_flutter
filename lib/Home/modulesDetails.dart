import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:natuvida_flutter/Postagem/perguntas.dart';
import 'package:natuvida_flutter/model/postagemModel.dart';
import 'package:http/http.dart' as http;
import 'package:natuvida_flutter/Services/requests.dart' as Requests;
import 'package:natuvida_flutter/model/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModulesDetails extends StatefulWidget {
  String id;
  String idUsuario;
  ModulesDetails({Key key, this.id, String idUsuario}) : super(key: key);
  @override
  _ModulesDetailsState createState() => _ModulesDetailsState();
}

class _ModulesDetailsState extends State<ModulesDetails> {
  List<PostagemModel> listPostagens = [];
  String idModulo;
  String idUsuario;
  SharedPreferences prefs;

  getModuloPostagens() async {
    await SharedPreferences.getInstance().then((value) {
      prefs = value;
      var firstDecode = jsonDecode(value.getString("userData"));

      UserModel user = UserModel.fromJson(firstDecode);
    idModulo = widget.id;
    idUsuario = user.id;

    // var response = await http.get("https://secure-temple-09752.herokuapp.com/getPostagemDetalhes?id=" + idModulo.toString());
    var result = Requests.getModulesDetails(idUsuario, idModulo)
        .then((response) {
          var decode = json.decode(response.body);
          List list = decode["listPostagens"];
          list.forEach((element) {
            PostagemModel postagemModel = new PostagemModel();
            postagemModel = PostagemModel.fromJson(element);
            decode["concluidas"].forEach((el) {
              if(el["idPostagem"] == element["_id"])
                postagemModel.finalizada = true;
            });
            setState(() {
            listPostagens.add(postagemModel);
            });
          });
        });
  });}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getModuloPostagens();
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
            "Business Capacitation",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body:
      Container(
      
          child: new ListView.builder(
            shrinkWrap: true,
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
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
                                child: Image.network(
                                  "https://secure-temple-09752.herokuapp.com" +
                                      listPostagens[index].imgPostagem,
                                  fit: BoxFit.fitWidth,
                                  // image: AssetImage(
                                  //     'assets/imgPosts/AUTOCONHECIMENTO.jpg'),
                                  height: 110,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 20, top: 20),
                                    child: Container(
                                      width:
                                          (MediaQuery.of(context).size.width *
                                              0.55),
                                      child: AutoSizeText(
                                        listPostagens[index].title,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: 10,
                                      top: 10
                                    ),
                                    child: Container(
                                      width:
                                          (MediaQuery.of(context).size.width *
                                              0.10),
                                      child:
                                        Icon(
                                          listPostagens[index].finalizada != null 
                                          && listPostagens[index].finalizada 
                                          ? Icons.check_circle 
                                          : Icons.linear_scale,
                                          size: 34,
                                          color: listPostagens[index].finalizada != null 
                                          && listPostagens[index].finalizada 
                                          ? Colors.green 
                                          : Colors.black
                                          ,
                                        )
                                    )
                                        
                                  )
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 20, top: 10),
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
                            image: listPostagens[index].imgPostagem,
                          ),
                        ),
                      );
                    });
              }),
        ),
      
    );
  }
}
