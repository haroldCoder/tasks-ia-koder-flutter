import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/shared/States/configApp.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AI/ConfigureAgentsIA.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/enum/elementId.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/layouts/InputTitle/InputTitle.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/utils/generateBrain.dart';

class InputMagnamentStreams extends StatelessWidget {
  InputMagnamentStreams(
      {super.key, required this.handleChangeTitleTask, required this.value});

  final Function(dynamic value) handleChangeTitleTask;
  final String value;

  final listenAgentsIAChanges = Get.put(ListenAgentsIAChanges());
  final configureAgentsIa = Get.find<ConfigureAgentsIa>();
  final configApp = Get.put(ConfigAppState());
  final controllerStreamBrain = Get.put(ControllerStreamBrain());

  @override
  Widget build(BuildContext context) {
    if (configApp.model_ai.value != ModelIA.gemma3nE4Bit) {
      return StreamBuilder(
          stream: configureAgentsIa.stream,
          builder: (context, snapshot) {
            return Obx(() {
              bool select =
                  listenAgentsIAChanges.select.value == ElementId.title_input;
              if (listenAgentsIAChanges.loading.value == true && select) {
                return CircularProgressIndicator(
                  color: Colors.blueAccent,
                );
              }
              if (snapshot.hasData == true && select) {
                final data = jsonDecode(snapshot.data!.body);
                String content =
                    jsonEncode(data["choices"][0]["message"]["content"]);
                content =
                    utf8.decode(latin1.encode(content), allowMalformed: true);

                return InputTitle(
                    value: content, onChange: handleChangeTitleTask);
              }
              return InputTitle(value: value, onChange: handleChangeTitleTask);
            });
          });
    }
    return StreamBuilder<bool>(
      stream: controllerStreamBrain.stream.stream,
      builder: (context, snapshot) {
        final isLoading = snapshot.data ?? false;

        return Obx(() {
          if (
              controllerStreamBrain.elementId.value == ElementId.title_input && isLoading) {
            return CircularProgressIndicator(color: Colors.blueAccent);
          }
          return InputTitle(value: value, onChange: handleChangeTitleTask);
        });
      },
    );
  }
}
