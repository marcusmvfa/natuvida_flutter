import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:natuvida_flutter/Modulos/modulesDetails.dart';
import 'package:natuvida_flutter/Postagem/perguntas.dart';
import 'package:natuvida_flutter/bindings/postagemBinding.dart';
import 'package:natuvida_flutter/model/moduloModel.dart';

class ModuloWidget extends StatefulWidget {
  ModuloModel? moduloModel;
  String? idUsuario;
  ModuloWidget({this.moduloModel, this.idUsuario});

  @override
  _ModuloWidgetState createState() => _ModuloWidgetState();
}

class _ModuloWidgetState extends State<ModuloWidget> {
  @override
  Widget build(BuildContext context) {
    ModuloModel moduloModel = widget.moduloModel!;
    String idUsuario = widget.idUsuario!;

    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(7),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(color: Color(0xffdddddd), offset: Offset(1, 1), spreadRadius: 1.5)
            ],
            color: Colors.white,
            borderRadius:
                BorderRadius.horizontal(right: Radius.circular(10), left: Radius.circular(10))),
        child: ListTile(
            title: Text(moduloModel.title!),
            subtitle: Text(moduloModel.subTitle!),
            trailing:
                // CircularProgressIndicator(
                //   value: 0.33,
                //   backgroundColor: Colors.white,
                // ),
                Icon(Icons.keyboard_arrow_right)),
      ),
      onTap: () {
        Get.to(ModulesDetails(id: moduloModel.id!, idUsuario: idUsuario),
            binding: PostagemBinding());
      },
    );
  }
}
