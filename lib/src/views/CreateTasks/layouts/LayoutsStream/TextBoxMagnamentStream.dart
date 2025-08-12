import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/shared/States/configApp.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AI/ConfigureAgentsIA.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/enum/elementId.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/layouts/TextBoxsDescription/TextBoxsDescription.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/utils/generateBrain.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/utils/modifyState/updateDataTask.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/utils/returnContentAgentIA.dart';
import 'package:tasks_ia_koderx/src/views/states/createTaskState.dart';

class Textboxmagnamentstream extends StatelessWidget {
  Textboxmagnamentstream(
      {super.key,
      required this.value,
      required this.handleChangeDescriptionTask,
      this.task});

  final Function(dynamic value) handleChangeDescriptionTask;
  final String value;
  final Rx<CreateTasksState>? task;

  ConfigureAgentsIa configureAgentsIa = Get.find<ConfigureAgentsIa>();
  final configApp = Get.put(ConfigAppState());
  final controllerStreamBrain = Get.put(ControllerStreamBrain());
  final listenAgentsIAChanges = Get.put(ListenAgentsIAChanges());

  @override
  Widget build(BuildContext context) {
    configureAgentsIa.stream.listen((snapshot) {
      if (listenAgentsIAChanges.select.value == ElementId.desc_textBox) {
        String content = returnContentAgentIA(snapshot);

        if(task != null){
          updateDataTask(task!, content, ElementId.desc_textBox);
        }
      }
    });

    return Obx(() {
      if (configApp.model_ai.value != ModelIA.gemma3nE4Bit) {
        return StreamBuilder(
            stream: configureAgentsIa.stream,
            builder: (context, snapshot) {
              return Obx(() {
                bool select = listenAgentsIAChanges.select.value ==
                    ElementId.desc_textBox;
                if (listenAgentsIAChanges.loading.value == true && select) {
                  return CircularProgressIndicator(
                    color: Colors.blueAccent,
                  );
                }
                return TextboxsDescription(
                    value: value, onChange: handleChangeDescriptionTask);
              });
            });
      }

      return StreamBuilder<bool>(
          stream: controllerStreamBrain.stream.stream,
          builder: (context, snapshot) {
            final isLoading = snapshot.data ?? false;

            return Obx(() {
              if (controllerStreamBrain.elementId.value ==
                      ElementId.desc_textBox &&
                  isLoading) {
                return const CircularProgressIndicator(
                    color: Colors.blueAccent);
              }

              return TextboxsDescription(
                  value: value, onChange: handleChangeDescriptionTask);
            });
          });
    });
  }
}
