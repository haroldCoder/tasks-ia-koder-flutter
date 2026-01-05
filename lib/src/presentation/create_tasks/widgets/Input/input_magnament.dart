import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/domain/enum/elementId.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/utils/returnContentAgentIA.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/widgets/ErrorAgent/show_error_agent_IA.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/widgets/InputTitle/input_title.dart';
import 'package:tasks_ia_koderx/src/providers/agentsIa_providers.dart';
import 'package:tasks_ia_koderx/src/providers/configApp_provider.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';

class InputMagnament extends ConsumerWidget {
  InputMagnament(
      {super.key,
      required this.handleChangeTitleTask,
      required this.value,
      required this.contextmain});

  final Function(dynamic value) handleChangeTitleTask;
  final String value;
  final BuildContext contextmain;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configureAgentsIa = ref.watch(agentNotifierProvider);
    final brainState = ref.watch(brainProvider);
    final configAppState = ref.watch(configAppProvider);

    bool selectAgentsIa = configureAgentsIa.select == ElementId.title_input;
    bool selectBrain = brainState.elementId == ElementId.title_input;

    ref.listen(agentNotifierProvider, (previous, next) {
      print(next.select);
      if (next.response != null && previous?.response != next.response && selectAgentsIa) {
        String content = returnContentAgentIA(next.response!);
        handleChangeTitleTask(content);
      }
    });

    ref.listen(brainProvider, (previous, next) {
      if (next.textGenerated != "" && previous?.textGenerated != next.textGenerated && selectBrain) {
        handleChangeTitleTask(next.textGenerated);
      }
    });

    if (configAppState.modelAi != ModelIA.gemma3nE4Bit) {
      if (configureAgentsIa.loading && selectAgentsIa) {
        return CircularProgressIndicator(color: Colors.blueAccent);
      }

      if (configureAgentsIa.response != null && selectAgentsIa) {
        return InputTitle(value: value, onChange: handleChangeTitleTask);
      } else if (configureAgentsIa.hasError &&
          selectAgentsIa &&
          configureAgentsIa.error != null) {
        showErrorAgentIA(
            context: contextmain, description: configureAgentsIa.error!);
      }

      return InputTitle(value: value, onChange: handleChangeTitleTask);
    } else {
      if (brainState.loading && selectBrain) {
        return CircularProgressIndicator(color: Colors.blueAccent);
      }

      if (brainState.hasError && selectBrain) {
        showErrorAgentIA(
            context: contextmain,
            description: brainState.error.toString());
      }

      return InputTitle(value: value, onChange: handleChangeTitleTask);
    }
  }
}
