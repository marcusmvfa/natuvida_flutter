import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 5;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  _buildPageIndicator(){
    List<Widget> list = [];
    for(int i = 0; i <_numPages; i++){
      list.add(i == _currentPage ? _indicator(true): _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive){
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: isActive ? 24 : 16,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xff7b51d3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                0.1,
                0.4,
                0.7,
                0.9
              ],
                  colors: [
                Color(0xff3594dd),
                Color(0xff4563db),
                Color(0xff5036d5),
                Color(0xff5b16d0),
              ])),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => Navigator.pushNamed(context, '/home'),
                    child: Text(
                      'Skip',
                      style: (TextStyle(color: Colors.white, fontSize: 20.0)),
                    ),
                  ),
                ),
                Container(
                  height: 600,
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
                        padding: EdgeInsets.all(40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                height: 200,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Bem-Vindo ao Business Capacitation",
                              style: TextStyle(color: Colors.white,
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 30,),
                            Text("Antes de começarmos, gostaríamos de conhecer você melhor.",
                            style: TextStyle(color: Colors.white,),)
                          ],
                        ),
                      ),Padding(
                        padding: EdgeInsets.all(40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                height: 200,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Gostariamos que se apresentasse",
                              style: TextStyle(color: Colors.white,
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 15,),
                            TextField(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                height: 200,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Seu email",
                              style: TextStyle(color: Colors.white,
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 15,),
                            TextField()
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                height: 200,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Você realmente parece estar interessado (a) em mudanças.\nVocê está preparado para iniciar um desenvolvimento pessoal juntamente com seu trabalho?",
                              style: TextStyle(color: Colors.white,
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 15,),
                            RaisedButton(child: Text("Sim"),onPressed: (){},),
                            RaisedButton(child: Text("Não"),onPressed: (){},)
                          ],
                        ),
                      ),Padding(
                        padding: EdgeInsets.all(40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                height: 200,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Antes de começar o primeiro tema, gostaria de lembrar que você é a pessoa que melhor conhece a si mesmo.\nPor isso, juntos podemos desenvolver mudanças importantes, basta você querer e colocar em prática.",
                              style: TextStyle(color: Colors.white,
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 15,),
                            RaisedButton(child: Text("SIM, EU QUERO EVOLUIR"),onPressed: (){},),
                            RaisedButton(child: Text("NÃO, PREFIRO FAZER ISSO SOZINHO(A)"),onPressed: (){},)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: _buildPageIndicator(),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
