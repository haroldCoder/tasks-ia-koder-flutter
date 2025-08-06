import 'dart:ui';

import 'package:google_generative_ai/google_generative_ai.dart';

Future<void> generateBrain(
    GenerativeModel model, String value, void Function(String) function) async {
  try {
    final response = await model.startChat().sendMessage(Content.text(
        'Redacta y mejora el texto para esta tarea, solo dame el resultado, para ponerlo en un input. solo el texto con signos de puntuacio, etc: ${value}'));
    function(response.text.toString());
  } catch (err) {
    print(err);
  }
}
