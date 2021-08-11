import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:natuvida_flutter/Login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Home/home.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 5;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  int colorButton = 0;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var prefs;
  TextEditingController _nome = new TextEditingController();
  TextEditingController _email = new TextEditingController();

  _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    setState(() {
      colorButton = 0;
    });
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: isActive ? 24 : 16,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.black54,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  getPrefs() async {
    prefs = await _prefs;
  }

  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Container(
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: [
              0.1,
              0.4,
              0.7,
              0.9
            ], colors: [
              Color(0xbb29917d),
              Color(0xff329c70),
              Color(0xdd329c5c),
              Color(0xdd30bf51),
            ])),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        prefs.setString('nomeCompleto', _nome.text);
                        prefs.setString('email', _email.text);
                        // prefs.setBool('isLogged', true);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
                      },
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(
                          "Pular",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ]),
                    ),
                  ),
                  (MediaQuery.of(context).size.height < 550)
                      ? Container()
                      : Center(
                          child: Container(
                              // height: 200,
                              height: (MediaQuery.of(context).size.height * 0.2),
                              child: Image.asset(
                                'assets/natuvida_logo.png',
                                color: Colors.white,
                                fit: BoxFit.fill,
                              )),
                        ),
                  Container(
                    // height: 400,
                    height: (MediaQuery.of(context).size.height * 0.55),
                    child: PageView(
                      physics: ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Bem-Vindo ao Business Capacitation",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Antes de começarmos, gostaríamos de conhecer você melhor.",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Gostariamos que se apresentasse",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: _nome,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    hintText: "Seu nome completo...",
                                    fillColor: Colors.white,
                                    filled: true),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Seu email",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: _email,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    hintText: "exemplo@gmail.com",
                                    fillColor: Colors.white,
                                    filled: true),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(40),
                          child: Center(
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  // height: 30,
                                  height: (MediaQuery.of(context).size.height * 0.03),
                                ),
                                Container(
                                  child: Text(
                                    "Você realmente parece estar interessado (a) em mudanças.\nVocê está preparado para iniciar um desenvolvimento pessoal juntamente com seu trabalho?",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                FlatButton(
                                  color: colorButton == 0 || colorButton == 2
                                      ? Colors.white
                                      : Colors.greenAccent,
                                  child: Text(
                                    "Sim",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      colorButton = 1;
                                    });
                                  },
                                ),
                                FlatButton(
                                  color: colorButton == 0 || colorButton == 1
                                      ? Colors.white
                                      : Colors.red,
                                  child: Text("Não",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: colorButton == 0 || colorButton == 1
                                              ? Colors.black87
                                              : Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  onPressed: () {
                                    setState(() {
                                      colorButton = 2;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: (MediaQuery.of(context).size.height < 550) ? 0 : 30,
                              ),
                              Text(
                                "Antes de começar o primeiro tema, gostaria de lembrar que você é a pessoa que melhor conhece a si mesmo.\nPor isso, juntos podemos desenvolver mudanças importantes, basta você querer e colocar em prática.",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              FlatButton(
                                color: colorButton == 0 || colorButton == 2
                                    ? Colors.white
                                    : Colors.greenAccent,
                                child: Text(
                                  "SIM, EU QUERO EVOLUIR",
                                  style: TextStyle(color: Colors.black87, fontSize: 18),
                                ),
                                onPressed: () {
                                  setState(() {
                                    colorButton = 1;
                                  });
                                },
                              ),
                              FlatButton(
                                color: colorButton == 0 || colorButton == 1
                                    ? Colors.white
                                    : Colors.red,
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    "NÃO, PREFIRO FAZER ISSO SOZINHO(A)",
                                    style: TextStyle(
                                        color: colorButton == 0 || colorButton == 1
                                            ? Colors.black87
                                            : Colors.white,
                                        fontSize: 16),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    colorButton = 2;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  )
                ],
              ),
            ),
          ),
        ),
        bottomSheet: _currentPage == _numPages - 1
            ? GestureDetector(
                child: Container(
                    height: 70,
                    width: double.infinity,
                    color: Colors.white,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Começar",
                          style: TextStyle(
                              color: Color(0xdd30bf51), fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                onTap: () {
                  prefs.setString('nomeCompleto', _nome.text);
                  prefs.setString('email', _email.text);
                  // prefs.setBool('isLogged', true);
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
                },
              )
            : Text(''));
  }
}
