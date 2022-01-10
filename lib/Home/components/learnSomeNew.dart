import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class LearnSomeNew extends StatelessWidget {
  const LearnSomeNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color(0xffB2E4D5),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(left: 12, top: 8, bottom: 8),

                width: 100,
                // height: 75,
                // color: Colors.blue.shade200,
                child: Column(children: [
                  Text(
                    "Vamos aprender algo novo!",
                    style: GoogleFonts.hammersmithOne(fontSize: 24),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "A seguir temos alguns módulos para você dar uma olhada",
                    style: GoogleFonts.hammersmithOne(fontSize: 16, color: Colors.grey.shade700),
                  ),
                ]),
              ),
            ),
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'assets/undrawTeacher-removebg-preview.png',
                  height: 120.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
