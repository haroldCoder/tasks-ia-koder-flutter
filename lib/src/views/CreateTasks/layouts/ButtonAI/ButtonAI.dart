import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/shared/States/configApp.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';
import 'package:tasks_ia_koderx/src/shared/lang/createTask/lang.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AI/ConfigureAgentsIA.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/enum/elementId.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/layouts/ButtonAI/enum/typeRef.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/utils/returnMessageIA.dart';
import 'package:tasks_ia_koderx/src/views/states/createTaskState.dart';

import '../../../../shared/utils/AI/ConfigureAI.dart';
import '../../../../widgets/Button/Button.dart';
import '../../utils/generateBrain.dart';

class Buttonai extends StatelessWidget {
  ConfigureAI configureAI = ConfigureAI();
  Rx<CreateTasksState> task;
  String ref;
  final configureAgentsIa = Get.find<ConfigureAgentsIa>();
  final configApp = Get.put(ConfigAppState());
  final controllerStreamBrain = Get.find<ControllerStreamBrain>();
  final Typeref? typeref;
  ElementId? elementId = ElementId.worthless;
  bool disabled;

  Buttonai({super.key, required this.task, required this.ref, this.typeref, this.disabled = false});

  void useIAModelToBrain() {
    elementId = typeref == Typeref.title
            ? ElementId.title_input
            : ElementId.desc_textBox;
    switch (configApp.model_ai.value) {
      case ModelIA.gemma3nE4Bit:
        controllerStreamBrain.SelectElement(elementId!);
        generateBrain(configureAI.model, ref, (value) {
          task.update((tk) {
            if (tk != null) {
              if (ref == task.value.title_task) {
                tk.title_task = value.trim();
              } else if (ref == task.value.description) {
                tk.description = value.trim();
              }
            }
          });
        });
        break;
      default:
        configureAgentsIa.makeBrain(configApp.model_ai.value,
            returnMessageIA(this.typeref!, ref), elementId);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
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
        useIAModelToBrain();
      },
    );
  }
}
