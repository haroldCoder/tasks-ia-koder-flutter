import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/domain/enum/element_id.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/utils/return_message_IA.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/widgets/button_AI/enum/typeRef.dart';
import 'package:tasks_ia_koderx/src/providers/agentsIa_providers.dart';
import 'package:tasks_ia_koderx/src/providers/configApp_provider.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';
import 'package:tasks_ia_koderx/src/shared/lang/AI/lang.dart';
import 'package:tasks_ia_koderx/src/shared/lang/createTask/lang.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AI/configure_agents_IA.dart';
import '../../../../shared/utils/AI/ConfigureAI.dart';
import '../../../../widgets/Button/Button.dart';
import '../../state/brain_notifier.dart';

class ButtonAI extends ConsumerWidget {
  ConfigureAI configureAI = ConfigureAI();
  String ref;

  final Typeref typeref;
  ElementId? elementId = ElementId.worthless;
  bool disabled;
  final WidgetRef widgetRef;

  ButtonAI(
      {super.key,
      required this.ref,
      required this.typeref,
      this.disabled = false,
      required this.widgetRef});

  Future<void> useIAModelToBrain(AgentNotifier configureAgentsIa,
      BrainNotifier controllerBrain, ConfigAppState configApp) async {
    elementId = typeref == Typeref.title
        ? ElementId.title_input
        : ElementId.desc_textBox;
    switch (configApp.modelAi) {
      case ModelIA.gemma3nE4Bit:
        controllerBrain.selectElement(elementId!);
        controllerBrain.generateBrain("$generateText $ref");
        break;
      default:
        configureAgentsIa.makeBrain(
            configApp.modelAi, returnMessageIA(this.typeref, ref), elementId);
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configureAgentsIa = ref.read(agentNotifierProvider.notifier);
    final controllerBrain = ref.read(brainProvider.notifier);
    final configAppState = ref.watch(configAppProvider);

    return Button(
      disable: ref == "" || disabled ?? true,
      style: ButtonStyle(
          side: MaterialStatePropertyAll<BorderSide>(
              BorderSide(color: Colors.blueAccent)),
          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: MaterialStatePropertyAll<Color>(Colors.black)),
      contentbtn: Wrap(
        children: [
          Text(
            btnGenerate,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          SizedBox(width: 8.0),
          Icon(
            Icons.auto_awesome,
            color: Colors.blueAccent,
            size: 15,
          )
        ],
      ),
      click: () {
        useIAModelToBrain(configureAgentsIa, controllerBrain, configAppState);
      },
    );
  }
}
