import 'package:flutter/material.dart';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
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
                      icon: Icon(Icons.person),
                      labelText: "Nome",
                      hintText: "Seu nome",
                      
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if(value.isEmpty){
                        return "Insira um Nome!";
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
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      icon: Icon(Icons.mail),
                      labelText: "Telefone",
                      hintText: "(45)99999999",
                      helperText: "Insira apenas números"
                      
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if(value.isEmpty || value.length < 6){
                        return "Insira um número válido!";
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
              SizedBox(height: 15,),
              RaisedButton(
                color: Colors.green,
                onPressed: () {
                  // Validate returns true if the form is valid, otherwise false.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.

                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Processando requisição')));
                  }
                },
                child: Text('Cadastrar',style: TextStyle(color: Colors.white),),
              ),
            ]),
          );}),
        ),
      ),
    );
  }
}