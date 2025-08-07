import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/shared/States/configApp.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AI/ConfigureAgentsIA.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/layouts/InputTitle/InputTitle.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/utils/generateBrain.dart';

class InputMagnamentStreams extends StatelessWidget {
  InputMagnamentStreams(
      {super.key,
      required this.handleChangeTitleTask,
      required this.value,
      required this.configureAgentsIa});

  final Function(dynamic value) handleChangeTitleTask;
  final String value;

  ConfigureAgentsIa? configureAgentsIa;
  final configApp = Get.put(ConfigAppState());
  final controllerStreamBrain = Get.put(ControllerStreamBrain());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (configApp.model_ai.value != ModelIA.gemma3nE4Bit) {
        StreamBuilder<dynamic>(
            stream: configureAgentsIa?.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return InputTitle(
                    value: snapshot.data, onChange: handleChangeTitleTask);
              }

              return CircularProgressIndicator(color: Colors.blueAccent);
            });
      }

      return StreamBuilder<bool>(
          stream: controllerStreamBrain.stream.stream,
          builder: (context, snapshot) {
            final isLoading = snapshot.data ?? false;

            return isLoading
                ? const CircularProgressIndicator(color: Colors.blueAccent)
                : InputTitle(value: value, onChange: handleChangeTitleTask);
          });
    });
  }
}
