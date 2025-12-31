import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:tasks_ia_koderx/src/presentation/CreateTasks/domain/enum/elementId.dart';
import 'package:tasks_ia_koderx/src/providers/agentsIa_providers.dart';
import 'package:tasks_ia_koderx/src/providers/configApp_provider.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/messagesIA.interface.dart';
import 'package:tasks_ia_koderx/src/shared/lang/createTask/lang.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AI/ConfigureAI.dart';
import 'package:tasks_ia_koderx/src/widgets/VoiceRecorder/constants/returnMessages.dart';
import 'package:tasks_ia_koderx/src/widgets/VoiceRecorder/enum/messageTypes.dart';

class ConvertBrainToTaskState {
  final String title;
  final String description;

  ConvertBrainToTaskState({this.title = '', this.description = ''});
}

class ConvertBrainToTaskNotifier extends Notifier<ConvertBrainToTaskState> {
  @override
  ConvertBrainToTaskState build() {
    return ConvertBrainToTaskState();
  }

  Future<void> convert(String brain) async {
    final configApp = ref.read(configAppProvider);
    final controllerAgentIa = ref.read(agentNotifierProvider.notifier);
    final controllerBrain = ref.read(brainProvider.notifier);
    final configureAgentIa = ref.watch(agentNotifierProvider);

    ConfigureAI configureAI = ConfigureAI();

    String _description = returnMessage(brain, MessageTypes.descripcion);
    String _title = returnMessage(brain, MessageTypes.title);

    if (configApp.modelAi == ModelIA.gemma3nE4Bit) {
      try {
        controllerBrain.setLoading(true);
        configureAgentIa.select == ElementId.title_input;
        final responseTitle = await configureAI.model
            .startChat()
            .sendMessage(Content.text(_title));

        final newTitle = responseTitle.text.toString();

        configureAgentIa.select == ElementId.desc_textBox;
        final responseDescription = await configureAI.model
            .startChat()
            .sendMessage(Content.text(_description));

        final newDescription = responseDescription.text.toString();
        
        state = ConvertBrainToTaskState(title: newTitle, description: newDescription);

      } catch (err) {
        controllerBrain.setError(err);
      } finally {
        controllerBrain.setLoading(false);
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

      await controllerAgentIa.makeBrain(
          configApp.modelAi, messagesTitle, ElementId.title_input);

      await Future.delayed(Duration(seconds: 2));

      await controllerAgentIa.makeBrain(
          configApp.modelAi, messagesDescription, ElementId.desc_textBox);
    }
  }
}

final convertBrainToTaskProvider =
    NotifierProvider<ConvertBrainToTaskNotifier, ConvertBrainToTaskState>(
        ConvertBrainToTaskNotifier.new);
