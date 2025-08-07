import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/shared/States/configApp.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AI/ConfigureAgentsIA.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/layouts/ButtonAI/enum/typeRef.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/layouts/TextBoxsDescription/TextBoxsDescription.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/utils/generateBrain.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/utils/returnMessageIA.dart';

class Textboxmagnamentstream extends StatelessWidget {
  Textboxmagnamentstream(
      {super.key,
      required this.value,
      required this.handleChangeDescriptionTask});

  final Function(dynamic value) handleChangeDescriptionTask;
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
                return TextboxsDescription(
                    value: snapshot.data,
                    onChange: handleChangeDescriptionTask);
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
                : TextboxsDescription(
                    value: value, onChange: handleChangeDescriptionTask);
          });
    });
  }
}
