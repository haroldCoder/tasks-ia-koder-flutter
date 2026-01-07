import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';

class ConfigAppState extends GetxController{
  Rx<Color> color_theme = Colors.black.obs;
  Rx<ModelIA> model_ai = ModelIA.gemma3nE4Bit.obs; 

  changeColorThemeApp(Color color){
    color_theme.value = color;
  }

  changeModelIA(ModelIA modelIa){
    model_ai.value = modelIa;
  }
}