import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:natuvida_flutter/Home/home.dart';
import 'package:natuvida_flutter/Login/cadastro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerSenha = new TextEditingController();
  SharedPreferences prefs;
  loginApp(context) {
    String url = "https://secure-temple-09752.herokuapp.com/login";
    http.post(url, body: {
      "email": controllerEmail.text,
      "senha": controllerSenha.text
    }).then((response) {
      if (response.statusCode == 200 && response.body != "null") {
        prefs.setString("userData", json.encode(response.body));
        prefs.setBool("isLogged", true);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => Home()));
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Verifique o E-mail e Senha',
              style: TextStyle(color: Colors.white),
            )));
      }
    });
  }

  getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    controllerEmail.text = prefs.getString('email');
  }

  @override
  initState() {
    super.initState();
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          child: Container(
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Form(
                key: _formKey,
                child: Column(children: [
                  Center(
                    child: Image.asset('assets/natuvida_logo.png',
                        height: (MediaQuery.of(context).size.height * 0.4),
                        color: Colors.green),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                    child: Container(
                      width: constraints.maxWidth * 0.70,
                      child: TextFormField(
                        controller: controllerEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          icon: Icon(Icons.mail),
                          labelText: "E-mail",
                          hintText: "example@gmail.com",
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return "Insira um e-mail válido!";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30, bottom: 15),
                    child: Container(
                      width: constraints.maxWidth * 0.70,
                      child: TextFormField(
                        controller: controllerSenha,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: "Senha",
                          hintText: "*********",
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira sua senha!";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  // ElevatedButton(
                  RaisedButton(
                    color: Colors.green,
                    onPressed: () {
                      // Validate returns true if the form is valid, otherwise false.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.

                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Processando requisição')));

                        loginApp(context);
                      }
                    },
                    child: Text(
                      'Entrar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  // ElevatedButton(
                  RaisedButton(
                    color: Colors.green,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CadastroScreen()));
                    },
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      Text(
                        'Novo Usuário',
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                  )
                ]),
              );
            }),
          ),
        ),
      
    );
  }
}
