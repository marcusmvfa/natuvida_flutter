import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:natuvida_flutter/Controllers/ModulosController.dart';
import 'package:natuvida_flutter/Home/components/learnSomeNew.dart';

class ProfileHeader extends StatelessWidget {
  ProfileHeader({Key? key}) : super(key: key);

  final modulosController = Get.put(ModulosController());

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.fromLTRB(16, 32, 8, 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Column(children: [
                Container(
                  margin: EdgeInsets.only(top: 8),
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Text(
                    "Bem-Vindo(a), " + modulosController.primeiroNome.value,
                    style: GoogleFonts.hammersmithOne(
                      color: Colors.grey.shade500,
                      // fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Text(
                    "Nome do Fulano" + modulosController.primeiroNome.value,
                    style: GoogleFonts.hammersmithOne(
                      color: Colors.black87,
                      // fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                ),
              ]),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: 90,
                height: 70,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      'assets/perfilMarcus.jpg',
                      height: 60.0,
                      width: 60.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      LearnSomeNew()
    ]);
  }
}
