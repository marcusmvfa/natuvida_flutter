import 'package:flutter/material.dart';

class SobreNos extends StatefulWidget {
  @override
  _SobreNosState createState() => _SobreNosState();
}

class _SobreNosState extends State<SobreNos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: 
      ListView(children: [Container(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 30, bottom: 20),
            child: Text("Sobre Nós", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
            Divider(),
            Padding(
              padding: EdgeInsets.only(right: 30, left: 30),
              child: Text(
                "Somos uma equipe que juntamente com o Parque Tecnológico de Itaipu e a empresa Natuvida," 
                + " estamos desenvolvendo uma aplicação onde os colaboradores da empresa podem ter acesso a "
                + "treinamentos e capacitações, dado que diante a circunstância gerada pelo COVID-19, "
                + "não se pode realizar treinamentos ou capacitações presencias, assim, através desse aplicativo, "
                + "o colaborador poderá realizar estas capacitações de forma segura e no local onde achar mais propício.",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 1),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Equipe",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/perfilMarcus.jpg',
                      height: 80,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    width: 200,
                    child: Text(
                      "Acadêmic do curso de Ciência da Computação - 8º Período",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/perfilChris.jpg',
                      height: 80,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    width: 200,
                    child: Text(
                      "Acadêmica do curso de Psicologia - 8º Período",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/perfilMonica.jpg',
                      height: 80,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    width: 200,
                    child: Text(
                      "Acadêmica do curso de Psicologia - 8º Período",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),])
    );
  }
}
