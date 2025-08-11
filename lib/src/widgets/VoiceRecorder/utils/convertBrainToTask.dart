import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:tasks_ia_koderx/src/shared/States/configApp.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/messagesIA.interface.dart';
import 'package:tasks_ia_koderx/src/shared/lang/createTask/es/createTaskIa.es.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AI/ConfigureAI.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AI/ConfigureAgentsIA.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/enum/elementId.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/utils/generateBrain.dart';
import 'package:tasks_ia_koderx/src/widgets/VoiceRecorder/constants/returnMessages.dart';
import 'package:tasks_ia_koderx/src/widgets/VoiceRecorder/enum/messageTypes.dart';

class ConvertBrainToTask extends GetxController {
  Rx<String> brain = new Rx<String>("");
  Rx<String> title = new Rx<String>("");
  Rx<String> description = new Rx<String>("");
  ConfigureAI configureAI = new ConfigureAI();
  final configApp = Get.find<ConfigAppState>();
  final configureAgenIa = Get.find<ConfigureAgentsIa>();
  final controllerStreamBrain = Get.find<ControllerStreamBrain>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(brain, (String val) async {
      String _description = returnMessage(val, MessageTypes.descripcion);

      String _title = returnMessage(val, MessageTypes.title);

      if (configApp.model_ai.value == ModelIA.gemma3nE4Bit) {
        try { 
          
          controllerStreamBrain.setLoading(true);
          controllerStreamBrain.elementId.value = ElementId.title_input;
          final responseTitle = await configureAI.model
              .startChat()
              .sendMessage(Content.text(_title));

          
          title.value = responseTitle.text.toString();

          controllerStreamBrain.elementId.value = ElementId.desc_textBox;
          final responseDescription = await configureAI.model
              .startChat()
              .sendMessage(Content.text(_description));
          
          description.value = responseDescription.text.toString(); 
        } catch (err) {
          controllerStreamBrain.stream.addError(err);
        } finally {
          controllerStreamBrain.setLoading(false);
        }
      } else {
        List<MessagesIAInterface> messagesTitle = [
          MessagesIAInterface(role: 'system', content: systemInteractue),
          MessagesIAInterface(role: 'user', content: _title)
        ];
        List<MessagesIAInterface> messagesDescription = [
          MessagesIAInterface(role: 'system', content: systemInteractue),
          MessagesIAInterface(role: 'user', content: _description)
        ];

        await configureAgenIa.makeBrain(
            configApp.model_ai.value, messagesTitle, ElementId.title_input);

        await Future.delayed(Duration(seconds: 8));

        await configureAgenIa.makeBrain(
            configApp.model_ai.value, messagesDescription, ElementId.desc_textBox);
      }
    });
  }
}
