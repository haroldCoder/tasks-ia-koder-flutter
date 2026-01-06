import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_ia_koderx/src/domain/models/convert_brain_to_task_model.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/domain/enum/elementId.dart';
import 'package:tasks_ia_koderx/src/providers/agentsIa_providers.dart';
import 'package:tasks_ia_koderx/src/providers/configApp_provider.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/messagesIA.interface.dart';
import 'package:tasks_ia_koderx/src/shared/lang/createTask/lang.dart';
import 'package:tasks_ia_koderx/src/widgets/voice_recorder/constants/return_messages.dart';
import 'package:tasks_ia_koderx/src/widgets/voice_recorder/enum/messageTypes.dart';

class ConvertBrainToTaskNotifier extends Notifier<IConvertBrainToTaskModel> {
  @override
  IConvertBrainToTaskModel build() {
    return const IConvertBrainToTaskModel(title: '', description: '');
  }

  Future<void> convert(String brain) async {
    final configApp = ref.read(configAppProvider);
    final controllerAgentIa = ref.read(agentNotifierProvider.notifier);
    final controllerBrain = ref.read(brainProvider.notifier);
    final brainState = ref.watch(brainProvider);

    String _description = returnMessage(brain, MessageTypes.descripcion);
    String _title = returnMessage(brain, MessageTypes.title);

    if (configApp.modelAi == ModelIA.gemma3nE4Bit) {
      try {
        controllerBrain.selectElement(ElementId.title_input);

        await controllerBrain.generateBrain(_title);

        final newTitle = brainState.textGenerated;

        await Future.delayed(Duration(seconds: 2));

        controllerBrain.selectElement(ElementId.desc_textBox);

        await controllerBrain.generateBrain(_description);

        final newDescription = brainState.textGenerated;

        state = IConvertBrainToTaskModel(
            title: newTitle, description: newDescription);
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
    NotifierProvider<ConvertBrainToTaskNotifier, IConvertBrainToTaskModel>(
        ConvertBrainToTaskNotifier.new);
