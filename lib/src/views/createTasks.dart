import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_ia_koderx/src/constants/radioList.dart';
import 'package:tasks_ia_koderx/src/providers/task_providers.dart';
import 'package:tasks_ia_koderx/src/shared/class/tasks/TaskDataManage.dart';
import 'package:tasks_ia_koderx/src/shared/lang/createTask/lang.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/ConnectionInternet/ConnectionInternet.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/LanguagueChange.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/SelectModelIA.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/layouts/ButtonAI/ButtonAI.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/layouts/ButtonAI/enum/typeRef.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/layouts/ButtonVoiceAI/ButtonVoiceAI.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/layouts/LayoutsStream/InputMagnament.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/layouts/LayoutsStream/TextBoxMagnament.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/Button.dart';
import 'package:tasks_ia_koderx/src/widgets/RadioCheck/RadioCheck.dart';

class Createtasks extends ConsumerWidget {
  final Rx<Color> color_app;

  Createtasks({super.key, required this.color_app});

  void backPage(BuildContext context) {
    if (!context.mounted) return;
    Future.microtask(() => context.pop());
  }

  void createTask(WidgetRef ref, BuildContext context) async {
    final taskData = ref.read(taskDataManageProvider);
    await ref.read(taskUseCasesProvider.notifier).createTask(
          taskData.title,
          taskData.description,
          taskData.priority,
        );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Tarea creada con éxito"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
    ref.read(taskDataManageProvider.notifier).resetData();
  }

  void handleChangeTitleTask(WidgetRef ref, dynamic value) {
    ref.read(taskDataManageProvider.notifier).setTitle(value);
  }

  void handleChangeDescription(WidgetRef ref, dynamic value) {
    ref.read(taskDataManageProvider.notifier).setDescription(value);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskDataManageProvider);

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
                              handleChangeTitleTask: (dynamic value) =>
                                  handleChangeTitleTask(ref, value),
                              value: task.title,
                              contextmain: context,
                            ),
                          ),
                        ),
                        Buttonai(
                          ref: task.title,
                          typeref: Typeref.title,
                          disabled: false,
                          widgetRef: ref,
                        ),
                        const SizedBox(height: 10),
                        Textboxmagnament(
                          value: task.description,
                          handleChangeDescriptionTask: (dynamic value) =>
                              handleChangeDescription(ref, value),
                          contextmain: context,
                        ),
                        const SizedBox(height: 4),
                        Buttonai(
                          ref: task.description,
                          typeref: Typeref.descripcion,
                          disabled: false,
                          widgetRef: ref,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 20),
                          width: double.infinity,
                          height: 140,
                          child: Radiocheck(
                            value: task.priority,
                            onChange: (value) => ref
                                .read(taskDataManageProvider.notifier)
                                .setPriority(value),
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
                ButtonvoiceAi(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
