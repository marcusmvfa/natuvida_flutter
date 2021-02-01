import 'package:flutter/material.dart';
import 'package:natuvida_flutter/Home/modulesDetails.dart';
import 'package:natuvida_flutter/Postagem/perguntas.dart';
import 'package:natuvida_flutter/model/moduloModel.dart';

class ModuloWidget extends StatefulWidget {
  ModuloModel moduloModel;
  String idUsuario;
  ModuloWidget({this.moduloModel, String idUsuario});

  @override
  _ModuloWidgetState createState() => _ModuloWidgetState();
}

class _ModuloWidgetState extends State<ModuloWidget> {
  @override
  Widget build(BuildContext context) {
    ModuloModel moduloModel = widget.moduloModel;
    String idUsuario = widget.idUsuario;
    Widget inicial = Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.90,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      color: Colors.green[100],
                    ),
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text(
                                    moduloModel.title,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 24),
                                  ),
                                ),
                                Text(moduloModel.dataInclusao),
                              ]),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.70,
                          child: Text(moduloModel.subTitle),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ModulesDetails(
                          id: moduloModel.id,
                        ),
                      ),
                    );
                  },
                ),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      color: Colors.orange[100],
                    ),
                    width: double.maxFinite,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text("Quiz"),
                          ),
                          IconButton(
                              icon: Icon(Icons.arrow_forward), onPressed: () {})
                        ]),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Perguntas(
                                  id: moduloModel.quiz,
                                )));
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(7),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                  color: Color(0xffdddddd),
                  offset: Offset(1, 1),
                  spreadRadius: 1.5)
            ],
            color: Colors.white,
            borderRadius: BorderRadius.horizontal(
                right: Radius.circular(10), left: Radius.circular(10))),
        child: ListTile(
          title: Text(moduloModel.title),
          subtitle: Text(moduloModel.subTitle),
          trailing: 
          // CircularProgressIndicator(
          //   value: 0.33,
          //   backgroundColor: Colors.white,
          // ),
          Icon(Icons.keyboard_arrow_right)
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ModulesDetails(
              id: moduloModel.id,
              idUsuario: idUsuario
            ),
          ),
        );
      },
    );
  }
}
