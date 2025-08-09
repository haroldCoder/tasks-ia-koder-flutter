import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/shared/States/configApp.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AI/ConfigureAgentsIA.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/enum/elementId.dart';
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

  ConfigureAgentsIa configureAgentsIa = Get.put(ConfigureAgentsIa());
  final configApp = Get.put(ConfigAppState());
  final controllerStreamBrain = Get.put(ControllerStreamBrain());
  final listenAgentsIAChanges = Get.put(ListenAgentsIAChanges());

  @override
  Widget build(BuildContext context) {
    if (configApp.model_ai.value != ModelIA.gemma3nE4Bit) {
      return StreamBuilder(
          stream: configureAgentsIa.stream,
          builder: (context, snapshot) {
            return Obx(() {
              bool select =
                  listenAgentsIAChanges.select.value == ElementId.desc_textBox;
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

                return TextboxsDescription(
                    value: content, onChange: handleChangeDescriptionTask);
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
              return const CircularProgressIndicator(color: Colors.blueAccent);
            }

            return TextboxsDescription(
                value: value, onChange: handleChangeDescriptionTask);
          });
        });
  }
}
