import 'package:get/get.dart';
import 'package:natuvida_flutter/Controllers/ModulosController.dart';
import 'package:natuvida_flutter/Controllers/PerguntasController.dart';
import 'package:natuvida_flutter/Controllers/PostagemController.dart';

class ModulosBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ModulosController>(ModulosController());
  }
}