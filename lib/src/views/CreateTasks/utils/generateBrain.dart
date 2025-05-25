import 'dart:ui';

import 'package:google_generative_ai/google_generative_ai.dart';

Future<void> generateBrain(GenerativeModel model, String value, void Function(String) function) async{
  try {
    final response = await model.generateContent(
        [Content.text("Mejora este mensaje en español, lo mas corto posible ${value}")]);
    function(response.text.toString());
  } catch (err) {
    print(err);
  }
}