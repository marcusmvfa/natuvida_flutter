import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:natuvida_flutter/Login/login.dart';
import 'package:natuvida_flutter/Perfil/customPathClip.dart';
import 'package:natuvida_flutter/model/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PerfilView extends StatefulWidget {
  @override
  _PerfilViewState createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  bool flagEdita = false;
  late SharedPreferences? prefs;
  UserModel user = new UserModel();
  bool _requstAtiva = false;

  getPrefs() async {
    SharedPreferences.getInstance().then((preferences) {
      this.prefs = preferences;
      // nameController.text = await prefs.getString()
      var decode1 = jsonDecode(prefs!.getString("userData")!);
      // var decode2 = jsonDecode(decode1);

      user = UserModel.fromJson(decode1);
      nameController.text = decode1["nome"];
      emailController.text = decode1["email"];
      phoneController.text = decode1["fone"];
      print("eita");
    });
  }

  _processaRequisicao(context) {
    setState(() {
      _requstAtiva = true;
    });

    user.nome = nameController.text;
    user.email = emailController.text;
    user.telefone = phoneController.text;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Processando Requisição...',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    String url = "https://secure-temple-09752.herokuapp.com/putUser";

    http.put(Uri(path: url), body: {
      "_id": user.id,
      "nome": user.nome,
      "email": user.email,
      "fone": user.telefone
    }).then((response) {
      if (response.statusCode == 200 && response.body != null) {
        var jsonfilho = user.toJson();
        prefs!.setString("userData", jsonEncode(jsonfilho));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Salvo com Sucesso!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
        setState(() {
          _requstAtiva = false;
        });
      }
    });
  }

  _logout(context) {
    prefs!.remove("userData");
    prefs!.setBool("isLogged", false);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Text(
          "Perfil",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Stack(children: [
            ClipPath(
              clipper: CustomPathClip(),
              child: Container(
                color: Colors.green,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/profile_image.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: "Nome", enabled: flagEdita),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: "E-mail", enabled: flagEdita),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 30),
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(labelText: "Telefone", enabled: flagEdita),
                  ),
                ),
                ButtonTheme(
                  minWidth: (MediaQuery.of(context).size.width * 0.70),
                  height: 50,
                  buttonColor: flagEdita ? Colors.green : Colors.lightBlue[500],
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    onPressed: () {
                      if (flagEdita) {
                        _processaRequisicao(context);
                      }
                      setState(() {
                        flagEdita = !flagEdita;
                      });
                    },
                    child: _requstAtiva
                        ? CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          )
                        : Text(
                            flagEdita ? "Salvar Perfil" : "Editar Perfil",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                  ),
                ),
                SizedBox(height: 20),
                ButtonTheme(
                  minWidth: (MediaQuery.of(context).size.width * 0.70),
                  height: 50,
                  buttonColor: Colors.red,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    onPressed: () {
                      _logout(context);
                    },
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Text(
                        "Sair",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      )
                    ]),
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
