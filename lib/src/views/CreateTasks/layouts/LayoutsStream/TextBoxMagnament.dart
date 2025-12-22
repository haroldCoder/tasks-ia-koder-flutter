import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/shared/States/configApp.dart';
import 'package:tasks_ia_koderx/src/shared/class/tasks/TaskDataManage.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AI/ConfigureAgentsIA.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/enum/elementId.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/layouts/ErrorAgent/showErrorAgentIA.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/layouts/TextBoxsDescription/TextBoxsDescription.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/utils/generateBrain.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/utils/modifyState/updateDataTask.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/utils/returnContentAgentIA.dart';

class Textboxmagnament extends StatelessWidget {
  Textboxmagnament(
      {super.key,
      required this.value,
      required this.handleChangeDescriptionTask,
      required this.contextmain});

  final Function(dynamic value) handleChangeDescriptionTask;
  final String value;
  final BuildContext contextmain;

  ConfigureAgentsIa configureAgentsIa = Get.find<ConfigureAgentsIa>();
  final configApp = Get.put(ConfigAppState());
  final controllerStreamBrain = Get.put(ControllerStreamBrain());
  final listenAgentsIAChanges = Get.put(ListenAgentsIAChanges());

  @override
  Widget build(BuildContext context) {
    configureAgentsIa.stream.listen((snapshot) {
      if (listenAgentsIAChanges.select.value == ElementId.desc_textBox) {
        String content = returnContentAgentIA(snapshot);

        handleChangeDescriptionTask(content);
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
                } else if (snapshot.hasError && select && !configureAgentsIa.errorShown) {
                  configureAgentsIa.errorShown = true;
                  showErrorAgentIA(
                      context: context, description: snapshot.error.toString());
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
              bool select = controllerStreamBrain.elementId.value ==
                  ElementId.desc_textBox;
              if (select && isLoading) {
                return const CircularProgressIndicator(
                    color: Colors.blueAccent);
              }
              if (select && snapshot.hasError) {
                showErrorAgentIA(
                    context: context, description: snapshot.error.toString());
              }

              return TextboxsDescription(
                  value: value, onChange: handleChangeDescriptionTask);
            });
          });
    });
  }
}
