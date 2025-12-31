import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/presentation/CreateTasks/domain/enum/elementId.dart';
import 'package:tasks_ia_koderx/src/presentation/CreateTasks/utils/returnMessageIA.dart';
import 'package:tasks_ia_koderx/src/presentation/CreateTasks/widgets/ButtonAI/enum/typeRef.dart';
import 'package:tasks_ia_koderx/src/providers/agentsIa_providers.dart';
import 'package:tasks_ia_koderx/src/shared/States/configApp.dart';
import 'package:tasks_ia_koderx/src/shared/States/modifyState/updateDataTask.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';
import 'package:tasks_ia_koderx/src/shared/lang/createTask/lang.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AI/ConfigureAgentsIA.dart';
import '../../../../shared/utils/AI/ConfigureAI.dart';
import '../../../../widgets/Button/Button.dart';
import '../../utils/generateBrain.dart';
import '../../state/brain_notifier.dart';

class Buttonai extends ConsumerWidget {
  ConfigureAI configureAI = ConfigureAI();
  String ref;
  final configApp = Get.put(ConfigAppState());

  final Typeref typeref;
  ElementId? elementId = ElementId.worthless;
  bool disabled;
  final WidgetRef widgetRef;

  Buttonai(
      {super.key,
      required this.ref,
      required this.typeref,
      this.disabled = false,
      required this.widgetRef});

  void useIAModelToBrain(AgentNotifier configureAgentsIa,
      BrainNotifier controllerStreamBrain) {
    elementId = typeref == Typeref.title
        ? ElementId.title_input
        : ElementId.desc_textBox;
    switch (configApp.model_ai.value) {
      case ModelIA.gemma3nE4Bit:
        controllerStreamBrain.selectElement(elementId!);
        generateBrain(configureAI.model, ref, (value) {
          updateDataTask(widgetRef, value, elementId!);
        }, widgetRef);
        break;
      default:
        configureAgentsIa.makeBrain(configApp.model_ai.value,
            returnMessageIA(this.typeref, ref), elementId);
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configureAgentsIa = ref.read(agentNotifierProvider.notifier);
    final controllerBrain = ref.read(brainProvider.notifier);

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
        useIAModelToBrain(configureAgentsIa, controllerBrain);
      },
    );
  }
}
