import 'package:get/get.dart';
import 'package:natuvida_flutter/Controllers/PerguntasController.dart';

class PerguntaBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<PerguntasController>(PerguntasController());
  }
}