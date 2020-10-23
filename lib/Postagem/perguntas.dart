import 'package:flutter/material.dart';

class Perguntas extends StatefulWidget {
  @override
  _PerguntasState createState() => _PerguntasState();
}

class _PerguntasState extends State<Perguntas>
    with SingleTickerProviderStateMixin {
  List perguntas = new List();
  List respostas = new List();
  int questionIndex = 0;
  String questionText = "";
  final respostaController = TextEditingController();
  AnimationController _rotationController;
  Animation rotation;

  void _geraPerguntas() {
    this.perguntas.add("O que te faz bem?");
    this.perguntas.add("O que te motiva?");
    this.perguntas.add("O que você mais gosta de fazer?");
    this.perguntas.add("O que te torna forte?");
    this.perguntas.add("O que te enfraquece?");
    this.perguntas.add("O que você precisa melhorar?");
    this.perguntas.forEach((element) {
      this.respostas.add("");
    });
    setState(() {
      questionText = perguntas[0];
    });
  }

  void _buttonAvancar() {
    if (questionIndex < perguntas.length - 1) {
      setState(() {
        this.respostas[questionIndex] = respostaController.text;

        questionIndex++;
        questionText = perguntas[questionIndex];
        if (this.respostas[questionIndex].toString().isNotEmpty)
          respostaController.text = this.respostas[questionIndex];
        else
          respostaController.text = "";
      });
    }
  }

  void _buttonRetrocerder() {
    if (questionIndex > 0) {
      setState(() {
        questionIndex--;
        questionText = perguntas[questionIndex];
        respostaController.text = this.respostas[questionIndex];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _geraPerguntas();
    _rotationController = AnimationController(
        duration: Duration(milliseconds: 500), vsync: this);
        _rotationController.forward();
        rotation = Tween(begin: 0.0, end: 2.0).animate(_rotationController);
  }
  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

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
      // CustomPaint(
      //   size: Size(380, 625),
      //   painter: RPSCustomPainter(),
      //   child: 
        SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 15, top: 15),
                child: Chip(
                    label: Text(
                      "Auto Conhecimento",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    backgroundColor: Colors.lightGreen[600]),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                      ),
                      onPressed: () {
                        _buttonRetrocerder();
                      },
                    ),
                    Text(
                      "Quem é você?",
                      style: TextStyle(fontSize: 24),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                      ),
                      onPressed: () {
                        if(_rotationController.isCompleted){
                          _rotationController.value = 0;
                          _rotationController.forward();
                        }
                        
                        _buttonAvancar();
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(35),
              ),
              Wrap(children: [
                Center(
                  child: RotationTransition(
                    turns: rotation,
                    child: Container(
                      margin: EdgeInsets.only(left: 50, right: 50),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.red[50],
                                blurRadius: 20,
                                spreadRadius: 1,
                                offset: Offset(7, 7))
                          ]),
                      child: Text(
                        questionText,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ]),
              Container(
                margin: EdgeInsets.all(40),
                child: TextField(
                  controller: respostaController,
                  decoration: InputDecoration(
                    // filled: true,
                    // fillColor: Color(0x22cffdcd),
                      border: OutlineInputBorder(), labelText: 'Resposta...'),
                  maxLines: 2,
                ),
              ),
              // Spacer(),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                padding: EdgeInsets.all(20),
                child: questionIndex < perguntas.length - 1
                    ? RaisedButton(
                        color: Colors.red[50],
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Avançar",
                          style: TextStyle(color: Colors.black87, fontSize: 18),
                        ),
                        onPressed: () {
                          _buttonAvancar();
                        },
                      )
                    : RaisedButton(
                        color: Colors.green,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Finalizar",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/finalizar');
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
class RPSCustomPainter extends CustomPainter{
  
  @override
  void paint(Canvas canvas, Size size) {
    
    Paint paint = new Paint()
      ..color = Color.fromARGB(118, 66, 179, 76)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
        
    Path path = Path();
    path.moveTo(size.width*0.76,size.height*0.18);
    path.quadraticBezierTo(size.width*0.67,size.height*0.22,size.width*0.66,size.height*0.26);
    path.cubicTo(size.width*0.59,size.height*0.23,size.width*0.64,size.height*0.32,size.width*0.68,size.height*0.34);
    path.quadraticBezierTo(size.width*0.71,size.height*0.35,size.width*0.76,size.height*0.37);
    path.quadraticBezierTo(size.width*0.82,size.height*0.35,size.width*0.84,size.height*0.34);
    path.cubicTo(size.width*0.89,size.height*0.32,size.width*0.94,size.height*0.22,size.width*0.87,size.height*0.26);
    path.quadraticBezierTo(size.width*0.85,size.height*0.22,size.width*0.76,size.height*0.18);
    path.close();

    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}
