import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_ia_koderx/src/presentation/CreateTasks/domain/enum/elementId.dart';
import 'package:tasks_ia_koderx/src/presentation/CreateTasks/utils/returnContentAgentIA.dart';
import 'package:tasks_ia_koderx/src/presentation/CreateTasks/widgets/TextBoxsDescription/TextBoxsDescription.dart';
import 'package:tasks_ia_koderx/src/providers/agentsIa_providers.dart';
import 'package:tasks_ia_koderx/src/providers/configApp_provider.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';

class Textboxmagnament extends ConsumerWidget {
  const Textboxmagnament({
    super.key,
    required this.value,
    required this.handleChangeDescriptionTask,
    required this.contextmain,
  });

  final Function(dynamic value) handleChangeDescriptionTask;
  final String value;
  final BuildContext contextmain;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configApp = ref.watch(configAppProvider);
    final agentState = ref.watch(agentNotifierProvider);
    final brainState = ref.watch(brainProvider);
    bool selectAgentsIa = agentState.select == ElementId.desc_textBox;
    bool selectBrain = brainState.elementId == ElementId.desc_textBox;

    ref.listen(agentNotifierProvider, (previous, next) {
      if (next.response != null && previous?.response != next.response && selectAgentsIa) {
        String content = returnContentAgentIA(next.response!);
        handleChangeDescriptionTask(content);
      }
    });

    ref.listen(brainProvider, (previous, next) {
      if (next.textGenerated != "" && previous?.textGenerated != next.textGenerated && selectBrain) {
        handleChangeDescriptionTask(next.textGenerated);
      }
    });


    if (configApp.modelAi != ModelIA.gemma3nE4Bit) {
      if (agentState.loading && selectAgentsIa) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.blueAccent,
          ),
        );
      } else if (agentState.hasError && selectAgentsIa) {
        return TextboxsDescription(
          value: value,
          onChange: handleChangeDescriptionTask,
        );
      }

      return TextboxsDescription(
        value: value,
        onChange: handleChangeDescriptionTask,
      );
    } else {
      if (brainState.loading && selectBrain) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.blueAccent,
          ),
        );
      }

      if (selectBrain && brainState.hasError) {
      }

      return TextboxsDescription(
        value: value,
        onChange: handleChangeDescriptionTask,
      );
    }
  }
}
