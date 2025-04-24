import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigAppState extends GetxController{
  Rx<Color> color_theme = Colors.black.obs;

  changeColorThemeApp(Color color){
    color_theme.value = color;
  }
}