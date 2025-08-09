import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_ia_koderx/src/constants/radioList.dart';
import 'package:tasks_ia_koderx/src/shared/States/Tasks/task_service.dart';
import 'package:tasks_ia_koderx/src/shared/States/configApp.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/SelectModelIA.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AI/ConfigureAgentsIA.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/layouts/ButtonAI/ButtonAI.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/layouts/ButtonAI/enum/typeRef.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/layouts/ButtonVoiceAI/ButtonVoiceAI.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/layouts/LayoutsStream/InputMagnamentStreams.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/layouts/LayoutsStream/TextBoxMagnamentStream.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/utils/generateBrain.dart';
import 'package:tasks_ia_koderx/src/views/states/createTaskState.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/Button.dart';
import 'package:tasks_ia_koderx/src/widgets/RadioCheck/RadioCheck.dart';
import 'package:tasks_ia_koderx/src/widgets/VoiceRecorder/utils/convertBrainToTask.dart';

class Createtasks extends StatelessWidget {
  Createtasks({super.key, required this.color_app});
  Rx<Color> color_app;
  Rx<CreateTasksState> task = CreateTasksState().obs;
  final convertBrainToTask = Get.put(ConvertBrainToTask());
  final configApp = Get.put(ConfigAppState());

  backPage(BuildContext context) {
    if (!context.mounted) return;
    Future.microtask(() => context.pop());
  }

  handleChangeTitleTask(value) {
    task.update((t) {
      if (t != null) t.setTitle(value);
    });
    task.refresh();
  }

  handleChangeDescriptionTask(value) {
    task.update((t) {
      if (t != null) t.setDescription(value);
    });
    task.refresh();
  }

  handeChangePriority(value) {
    task.update((t) {
      if (t != null) t.setPriorityValue(value);
    });
    task.refresh();
  }

  createTask(BuildContext context) async {
    TaskService().saveTasks(task.value.title_task, task.value.description,
        task.value.value_priority);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Tarea creada con éxito"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );

    task.update((t) {
      if (t != null) t.resetData();
    });
    task.refresh();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ConfigureAgentsIa(ListenAgentsIAChanges()));
    Get.put(ControllerStreamBrain());

    ever(convertBrainToTask.title, (String tt) {
      handleChangeTitleTask(tt);
    });

    ever(convertBrainToTask.description, (String dp) {
      handleChangeDescriptionTask(dp);
    });

    return Scaffold(
        backgroundColor: color_app.value,
        resizeToAvoidBottomInset: true,
        body: SafeArea(child: Obx(() {
          return Container(
            height: double.infinity,
            padding: EdgeInsets.only(left: 15, right: 15),
            child: SingleChildScrollView(
                child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Container(
                    height: 50,
                    width: double.infinity,
                    child: Stack(children: [
                      Button(
                        style: ButtonStyle(
                            alignment: Alignment.centerLeft,
                            padding: MaterialStatePropertyAll<EdgeInsets>(
                                EdgeInsets.all(0)),
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Colors.transparent)),
                        click: () => backPage(context),
                        contentbtn: Icon(
                          Icons.arrow_back,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ])),
                Container(
                    margin: EdgeInsets.only(top: 30),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Crear Tareas",
                            style: TextStyle(
                                fontFamily: "normal",
                                fontSize: 30,
                                decoration: TextDecoration.none,
                                color: Colors.white),
                          ),
                          SizedBox(height: 40),
                          Align(
                            alignment: Alignment.topRight,
                            child: SelectModelAI(),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 30, bottom: 20),
                            height: 50,
                            child: Scaffold(
                              resizeToAvoidBottomInset: false,
                              backgroundColor: Colors.transparent,
                              body: InputMagnamentStreams(
                                handleChangeTitleTask: (dynamic value) =>
                                    handleChangeTitleTask(value),
                                value: task.value.title_task,
                              ),
                            ),
                          ),
                          Buttonai(
                            task: task,
                            ref: task.value.title_task,
                            typeref: Typeref.title,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                          ),
                          Textboxmagnamentstream(
                              value: task.value.description,
                              handleChangeDescriptionTask: (dynamic value) =>
                                  handleChangeDescriptionTask(value)),
                          SizedBox(height: 4),
                          Buttonai(
                            task: task,
                            ref: task.value.description,
                            typeref: Typeref.descripcion,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 20),
                            width: double.infinity,
                            height: 140,
                            child: Radiocheck(
                              value: task.value.value_priority,
                              onChange: handeChangePriority,
                              list: priorityOptions,
                            ),
                          ),
                          Button(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            click: () => createTask(context),
                            contentbtn: Text("Crear Tarea",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: 'inter',
                                    fontWeight: FontWeight.bold)),
                            style: ButtonStyle(
                                shape: WidgetStatePropertyAll<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16))),
                                backgroundColor: WidgetStatePropertyAll<Color>(
                                    Colors.blueAccent)),
                          ),
                        ],
                      ),
                    )),
                ButtonvoiceAi(),
              ],
            )),
          );
        })));
  }
}
