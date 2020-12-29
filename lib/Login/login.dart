import 'package:flutter/material.dart';
import 'package:natuvida_flutter/Login/cadastro.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
            return Form(
            key: _formKey,
            child: Column(children: [
              Center(
                child: Image.asset('assets/natuvida_logo.png',
                    color: Colors.green),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30, left: 30, right:30),
                child: Container(
                  width: constraints.maxWidth * 0.70,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      icon: Icon(Icons.mail),
                      labelText: "E-mail",
                      hintText: "example@gmail.com",
                      
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if(value.isEmpty || !value.contains('@')){
                        return "Insira um e-mail válido!";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right:30),
                child: Container(
                  width: constraints.maxWidth * 0.70,
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: "Senha",
                      hintText: "*********",
                      
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if(value.isEmpty){
                        return "Insira sua senha!";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, otherwise false.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.

                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Processando requisição')));
                  }
                },
                child: Text('Entrar'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CadastroScreen()));
                },
                child: Text('Novo Usuário'),
              )
            ]),
          );}),
        ),
      ),
    );
  }
}
