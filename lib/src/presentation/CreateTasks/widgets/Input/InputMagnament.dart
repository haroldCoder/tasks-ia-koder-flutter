import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/presentation/CreateTasks/domain/enum/elementId.dart';
import 'package:tasks_ia_koderx/src/presentation/CreateTasks/utils/returnContentAgentIA.dart';
import 'package:tasks_ia_koderx/src/presentation/CreateTasks/widgets/ErrorAgent/showErrorAgentIA.dart';
import 'package:tasks_ia_koderx/src/presentation/CreateTasks/widgets/InputTitle/InputTitle.dart';
import 'package:tasks_ia_koderx/src/providers/agentsIa_providers.dart';
import 'package:tasks_ia_koderx/src/shared/States/configApp.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AI/ConfigureAgentsIA.dart';
import 'package:tasks_ia_koderx/src/presentation/CreateTasks/state/brain_notifier.dart';

class InputMagnament extends ConsumerWidget {
  InputMagnament(
      {super.key,
      required this.handleChangeTitleTask,
      required this.value,
      required this.contextmain});

  final Function(dynamic value) handleChangeTitleTask;
  final String value;
  final BuildContext contextmain;

  final configApp = Get.find<ConfigAppState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configureAgentsIa = ref.watch(agentNotifierProvider);
    final controllerBrain = ref.watch(brainProvider);
    bool select = configureAgentsIa.select == ElementId.title_input;

    ref.listen(agentNotifierProvider, (previous, next) {
      if (next.response != null && previous?.response != next.response) {
        String content = returnContentAgentIA(configureAgentsIa.response!);
        handleChangeTitleTask(content);
      }
    });

    if (configApp.model_ai.value != ModelIA.gemma3nE4Bit) {

      if (configureAgentsIa.loading && select) {
        return CircularProgressIndicator(color: Colors.blueAccent);
      }

      if (configureAgentsIa.response != null && select) {
        return InputTitle(value: value, onChange: handleChangeTitleTask);
      } else if (configureAgentsIa.hasError &&
          select &&
          configureAgentsIa.error != null) {
        showErrorAgentIA(
            context: contextmain, description: configureAgentsIa.error!);
      }

      return InputTitle(value: value, onChange: handleChangeTitleTask);
    }
    if(controllerBrain.loading && select){
      return CircularProgressIndicator(color: Colors.blueAccent);
    }

    if(controllerBrain.hasError && select){
      showErrorAgentIA(
          context: contextmain, description: controllerBrain.error.toString());
    }

    return InputTitle(value: value, onChange: handleChangeTitleTask);
  }
}
