import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_ia_koderx/src/domain/constants/radioList.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/state/create_task_controllers_provider.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/widgets/ButtonAI/button_AI.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/widgets/ButtonAI/enum/typeRef.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/widgets/ButtonVoiceAI/button_voice_ai.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/widgets/Input/input_magnament.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/widgets/TextBox/text_box_magnament.dart';
import 'package:tasks_ia_koderx/src/providers/task_providers.dart';
import 'package:tasks_ia_koderx/src/shared/lang/createTask/lang.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/ConnectionInternet/ConnectionInternet.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/LanguagueChange.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/SelectModelIA.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/Button.dart';
import 'package:tasks_ia_koderx/src/widgets/RadioCheck/RadioCheck.dart';

class CreateTasks extends ConsumerWidget {
  final Rx<Color> color_app;

  CreateTasks({super.key, required this.color_app});

  void backPage(BuildContext context) {
    if (!context.mounted) return;
    Future.microtask(() => context.pop());
  }

  void createTask(WidgetRef ref, BuildContext context) async {
    final taskData = ref.read(createTaskControllersProvider);
    await ref.read(taskUseCasesProvider.notifier).createTask(
          taskData.titleController.text,
          taskData.descriptionController.text,
          taskData.priority,
        );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Tarea creada con éxito"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );

    ref.read(createTaskControllersProvider.notifier).resetData();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createTaskState = ref.watch(createTaskControllersProvider);
    final createTaskController =
        ref.read(createTaskControllersProvider.notifier);

    return Scaffold(
      backgroundColor: color_app.value,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: SingleChildScrollView(
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Container(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Button(
                        style: ButtonStyle(
                          alignment: Alignment.centerLeft,
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.zero),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                        ),
                        click: () => backPage(context),
                        contentbtn: const Icon(
                          Icons.arrow_back,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      const LanguagueChange(
                        background: Color(0xFF202020),
                        selectedBackground: Colors.blueAccent,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr('create_task.create'),
                          style: const TextStyle(
                            fontFamily: "normal",
                            fontSize: 30,
                            decoration: TextDecoration.none,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Align(
                          alignment: Alignment.topRight,
                          child: ConnectionInternet(),
                        ),
                        const SizedBox(height: 25),
                        Align(
                          alignment: Alignment.topRight,
                          child: SelectModelAI(enabled: true),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 30, bottom: 20),
                          height: 50,
                          child: Scaffold(
                            resizeToAvoidBottomInset: false,
                            backgroundColor: Colors.transparent,
                            body: InputMagnament(
                              value: createTaskState.titleController.text,
                              handleChangeTitleTask: (dynamic value) =>
                                  createTaskController.changeTitleTask(value),
                              contextmain: context,
                            ),
                          ),
                        ),
                        ButtonAi(
                          ref: createTaskState.titleController.text,
                          typeref: Typeref.title,
                          disabled: createTaskState.titleController.text == "",
                          widgetRef: ref,
                        ),
                        const SizedBox(height: 10),
                        TextBoxMagnament(
                          value: createTaskState.descriptionController.text,
                          handleChangeDescriptionTask: (dynamic value) =>
                              createTaskController.changeDescriptionTask(value),
                          contextmain: context,
                        ),
                        const SizedBox(height: 4),
                        ButtonAi(
                          ref: createTaskState.descriptionController.text,
                          typeref: Typeref.descripcion,
                          disabled:
                              createTaskState.descriptionController.text == "",
                          widgetRef: ref,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 20),
                          width: double.infinity,
                          height: 140,
                          child: Radiocheck(
                            value: createTaskState.priority,
                            onChange: (value) =>
                                createTaskController.changePriorityTask(value),
                            list: priorityOptions,
                          ),
                        ),
                        Button(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          click: () => createTask(ref, context),
                          contentbtn: Text(
                            btnCreate,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: 'inter',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.blueAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ButtonVoiceAi(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
