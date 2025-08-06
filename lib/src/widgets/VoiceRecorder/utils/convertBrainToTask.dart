import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:tasks_ia_koderx/src/shared/utils/ConfigureAI.dart';

class ConvertBrainToTask extends GetxController {
  Rx<String> brain = new Rx<String>("");
  Rx<String> title = new Rx<String>("");
  Rx<String> description = new Rx<String>("");
  ConfigureAI configureAI = new ConfigureAI();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    ever(brain, (String val) async {
      final responseDescription = await configureAI.model
          .startChat()
          .sendMessage(Content.text(
              'Genera una descripcion breve de lo que podria llevar esta tarea: $val. no me des introduccion'));
              
      final responseTitle = await configureAI.model.startChat().sendMessage(
          Content.text(
              'Genera un titulo breve y descriptivo basado en una idea de tarea proporcionada: $val. Devuélvelo sin explicaciones, solo el título.'));

      print(responseDescription.text.toString());
      title.value = responseTitle.text.toString();

      description.value = responseDescription.text.toString();
    });
  }
}
