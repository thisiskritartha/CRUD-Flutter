import 'package:crud_firebase_flutter/controllers/word_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<WordController>(WordController());
  }
}
