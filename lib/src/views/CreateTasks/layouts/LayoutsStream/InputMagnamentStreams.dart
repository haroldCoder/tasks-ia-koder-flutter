import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/shared/States/configApp.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AI/ConfigureAgentsIA.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/enum/elementId.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/layouts/ErrorAgent/showErrorAgentIA.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/layouts/InputTitle/InputTitle.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/utils/generateBrain.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/utils/modifyState/updateDataTask.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/utils/returnContentAgentIA.dart';
import 'package:tasks_ia_koderx/src/views/states/createTaskState.dart';

class InputMagnamentStreams extends StatelessWidget {
  InputMagnamentStreams(
      {super.key,
      required this.handleChangeTitleTask,
      required this.value,
      this.task,
      required this.contextmain});

  final Function(dynamic value) handleChangeTitleTask;
  final String value;
  final Rx<CreateTasksState>? task;
  final BuildContext contextmain;

  final configureAgentsIa = Get.find<ConfigureAgentsIa>();
  final configApp = Get.find<ConfigAppState>();
  final controllerStreamBrain = Get.put(ControllerStreamBrain());
  final listenAgentsIAChanges = Get.put(ListenAgentsIAChanges());

  @override
  Widget build(BuildContext context) {
    configureAgentsIa.stream.listen((snapshot) {
      if (listenAgentsIAChanges.select.value == ElementId.title_input) {
        String content = returnContentAgentIA(snapshot);

        if (task != null) {
          updateDataTask(task!, content, ElementId.title_input);
        }
      }
    });
    return Obx(() {
      if (configApp.model_ai.value != ModelIA.gemma3nE4Bit) {
        return StreamBuilder(
          key: ValueKey(configApp.model_ai.value),
          stream: configureAgentsIa.stream,
          builder: (context, snapshot) {
            return Obx(() {
              bool select =
                  listenAgentsIAChanges.select.value == ElementId.title_input;

              if (listenAgentsIAChanges.loading.value && select) {
                return CircularProgressIndicator(color: Colors.blueAccent);
              }

              if (snapshot.hasData && select) {
                return InputTitle(
                    value: value, onChange: handleChangeTitleTask);
              } else if (snapshot.hasError && select) {
                showErrorAgentIA(
                    context: contextmain,
                    description: snapshot.error.toString());
              }

              return InputTitle(value: value, onChange: handleChangeTitleTask);
            });
          },
        );
      }
      return StreamBuilder<bool>(
        key: ValueKey(configApp.model_ai.value), // fuerza recreación
        stream: controllerStreamBrain.stream.stream,
        builder: (context, snapshot) {
          final isLoading = snapshot.data ?? false;

          return Obx(() {
            bool select =
                controllerStreamBrain.elementId.value == ElementId.title_input;
            if (select && isLoading) {
              return CircularProgressIndicator(color: Colors.blueAccent);
            }
            if (select && snapshot.hasError) {
              showErrorAgentIA(
                  context: contextmain, description: snapshot.error.toString());
            }
            return InputTitle(value: value, onChange: handleChangeTitleTask);
          });
        },
      );
    });
  }
}
