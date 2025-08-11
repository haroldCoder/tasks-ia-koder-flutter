import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/shared/States/configApp.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AI/ConfigureAgentsIA.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/enum/elementId.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/layouts/InputTitle/InputTitle.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/utils/generateBrain.dart';
import 'package:tasks_ia_koderx/src/widgets/VoiceRecorder/utils/convertBrainToTask.dart';

class InputMagnamentStreams extends StatelessWidget {
  InputMagnamentStreams(
      {super.key, required this.handleChangeTitleTask, required this.value});

  final Function(dynamic value) handleChangeTitleTask;
  final String value;

  final configureAgentsIa = Get.find<ConfigureAgentsIa>();
  final configApp = Get.find<ConfigAppState>();
  final controllerStreamBrain = Get.put(ControllerStreamBrain());
  final listenAgentsIAChanges = Get.put(ListenAgentsIAChanges());

  @override
  Widget build(BuildContext context) {
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
                final data = jsonDecode(snapshot.data!.body);
                dynamic content =
                    jsonEncode(data["choices"][0]["message"]["content"]);
                content =
                    utf8.decode(latin1.encode(content), allowMalformed: true);

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  handleChangeTitleTask(content);
                });

                return InputTitle(
                    value: value, onChange: handleChangeTitleTask);
              }

              return InputTitle(value: value, onChange: handleChangeTitleTask);
            });
          },
        );
      } else {
        return StreamBuilder<bool>(
          key: ValueKey(configApp.model_ai.value), // fuerza recreación
          stream: controllerStreamBrain.stream.stream,
          builder: (context, snapshot) {
            final isLoading = snapshot.data ?? false;

            return Obx(() {
              if (controllerStreamBrain.elementId.value ==
                      ElementId.title_input &&
                  isLoading) {
                return CircularProgressIndicator(color: Colors.blueAccent);
              }
              return InputTitle(value: value, onChange: handleChangeTitleTask);
            });
          },
        );
      }
    });
  }
}
