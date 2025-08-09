import 'dart:async';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/enum/elementId.dart';

class ControllerStreamBrain extends GetxController{
  StreamController<bool> _streamControllerbrain = StreamController<bool>.broadcast();
  StreamController<ElementId> _elementController = StreamController<ElementId>.broadcast();
  Rx<ElementId> elementId = ElementId.worthless.obs;
  Rx<bool> loading = false.obs;

  StreamController<ElementId> get streamElement => _elementController;

  void SelectElement(ElementId element){
    this.elementId = element.obs;
    _elementController.add(element);
  }

  StreamController<bool>  get stream => _streamControllerbrain;

  void setLoading(bool value) {
    loading.value = value;
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
