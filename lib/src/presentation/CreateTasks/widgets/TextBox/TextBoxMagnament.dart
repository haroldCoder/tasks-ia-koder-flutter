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

    ref.listen(agentNotifierProvider, (previous, next) {
      bool select = next.select == ElementId.desc_textBox;
      if (next.response != null && previous?.response != next.response && select) {
        String content = returnContentAgentIA(next.response!);
        handleChangeDescriptionTask(content);
      }
    });



    if (configApp.modelAi != ModelIA.gemma3nE4Bit) {
      bool select = agentState.select == ElementId.desc_textBox;

      if (agentState.loading && select) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.blueAccent,
          ),
        );
      } else if (agentState.hasError && select) {
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
      bool select = brainState.elementId == ElementId.desc_textBox;

      if (select && brainState.loading) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.blueAccent,
          ),
        );
      }

      if (select && brainState.hasError) {
      }

      return TextboxsDescription(
        value: value,
        onChange: handleChangeDescriptionTask,
      );
    }
  }
}
