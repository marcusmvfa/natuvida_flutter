import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _foneController = new TextEditingController();
  TextEditingController _senhaController = new TextEditingController();
  TextEditingController _confirmaSenhaController = new TextEditingController();
  bool reqAtiva = false;

  postNewUser(context) async {
    var newUser = {
      "nome": _nameController.text,
      "email": _emailController.text,
      "fone": _foneController.text,
      "senha": _senhaController.text,
      "confirmaSenha": _confirmaSenhaController.text,
    };
    setState(() {
      reqAtiva = true;
    });
    var resp = await http
        .post("https://secure-temple-09752.herokuapp.com/postNewUser",
            body: newUser)
        .then((response) {
      if (response.statusCode == 200) {
        Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(
                'Usuário Cadastrado!! Retorne a tela de login para entrar',
                style: TextStyle(color: Colors.white))));
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              response.body,
              style: TextStyle(color: Colors.white),
            )));
      }
      setState(() {
        reqAtiva = false;
      });
    }).catchError((onError){
      Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Ocorreu um erro tente novamente!',
              style: TextStyle(color: Colors.white),
            )));
      setState((){
        reqAtiva = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomPadding: false,
        body: Container(
          padding: EdgeInsets.only(bottom: 20),
          child: SingleChildScrollView(
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Form(
                key: _formKey,
                child: Column(children: [
                  Center(
                    child: Image.asset('assets/natuvida_logo.png',
                        height: (MediaQuery.of(context).size.height * 0.3),
                        color: Colors.green),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                    child: Container(
                      width: constraints.maxWidth * 0.70,
                      child: TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: "Nome",
                          hintText: "Seu nome",
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira um Nome!";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Container(
                      width: constraints.maxWidth * 0.70,
                      child: TextFormField(
                        controller: _emailController,
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
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Container(
                      width: constraints.maxWidth * 0.70,
                      child: TextFormField(
                        controller: _foneController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            icon: Icon(Icons.mail),
                            labelText: "Telefone",
                            hintText: "(45)99999999",
                            helperText: "Insira apenas números"),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value.isEmpty || value.length < 6) {
                            return "Insira um número válido!";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Container(
                      width: constraints.maxWidth * 0.70,
                      child: TextFormField(
                        controller: _senhaController,
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
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Container(
                      width: constraints.maxWidth * 0.70,
                      child: TextFormField(
                        controller: _confirmaSenhaController,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: "Confirmar Senha",
                          hintText: "*********",
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Campo obrigatório!";
                          } else if (_senhaController.text != value) {
                            return "Senhas não coincidem!";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  reqAtiva ? CircularProgressIndicator():
                  RaisedButton(
                    color: Colors.green,
                    onPressed: () {
                      // Validate returns true if the form is valid, otherwise false.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.

                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Processando requisição')));

                        postNewUser(context);
                      }
                    },
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ]),
              );
            }),
          ),
        ),
      ),
    );
  }
}
