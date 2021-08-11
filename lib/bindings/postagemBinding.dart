import 'package:get/get.dart';
import 'package:natuvida_flutter/Controllers/PerguntasController.dart';
import 'package:natuvida_flutter/Controllers/PostagemController.dart';

class PostagemBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<PostagemController>(PostagemController());
  }
}