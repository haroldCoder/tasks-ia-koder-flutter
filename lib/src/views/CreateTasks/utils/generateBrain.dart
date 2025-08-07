import 'dart:async';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ControllerStreamBrain extends GetxController{
  StreamController<bool> _streamControllerbrain = StreamController<bool>.broadcast();

  StreamController<bool>  get stream => _streamControllerbrain;

  void setLoading(bool value) {
    _streamControllerbrain.add(value);
  }

  @ override
  void onClose() {
    _streamControllerbrain.close();
    super.onClose();
  }
}

Future<void> generateBrain(
    GenerativeModel model, String value, void Function(String) function) async {
      final controllerStremBrain = Get.put(ControllerStreamBrain());

  try {
    controllerStremBrain.setLoading(true);

    final response = await model.startChat().sendMessage(Content.text(
        'Redacta y mejora el texto para esta tarea, solo dame el resultado, para ponerlo en un input. solo el texto con signos de puntuacio, etc: ${value}'));
    function(response.text.toString());
  } catch (err) {
    print(err);
    controllerStremBrain.stream.addError(err);
  }
  finally{
    controllerStremBrain.setLoading(false);
  }
}
