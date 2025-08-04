import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:tasks_ia_koderx/src/shared/States/Tasks/TaskController.dart';
import 'package:tasks_ia_koderx/src/shared/States/Tasks/task_service.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/tasks.interface.dart';
import 'package:tasks_ia_koderx/src/shared/utils/users/stateTaskServer.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/Button.dart';
import 'package:tasks_ia_koderx/src/widgets/ButtonUpload/ButtonUpload.dart';
import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/widgets/MarkDown/Markdown.dart';
import 'package:tasks_ia_koderx/src/widgets/TaskContainer/utils/uploadTask.dart';

class TaskContainer extends StatefulWidget {
  TaskContainer(
      {super.key,
      this.title = "Test",
      this.description = "Test description",
      this.priority = 1,
      this.onClick,
      this.completed = false,
      required this.id,
      this.online = false});

  final String title;
  final String description;
  final int priority;
  final VoidCallback? onClick;
  final bool? completed;
  final int id;
  final bool? online;

  @override
  State<StatefulWidget> createState() {
    return _TaskContainerState();
  }
}

class _TaskContainerState extends State<TaskContainer> {
  TaskController taskController = Get.put(TaskController());
  late StateTaskServer stateTaskServer;
  UploadTask uploadTask = Get.put(UploadTask());

  @override
  void initState() {
    stateTaskServer = StateTaskServer();
    super.initState();
  }

  void UploadTaskMethod(BuildContext context) {
    uploadTask.Upload(
        context,
        TasksInterface(
            id: widget.id,
            title: widget.title,
            description: widget.description,
            priority: widget.priority,
            completed: widget.completed! ? 1 : 0));
  }

  deleteTask(int id) {
    showShadDialog(
      context: context,
      builder: (context) => ShadDialog.alert(
        backgroundColor: Colors.black,
        titleStyle: TextStyle(color: Colors.red, fontSize: 22),
        title: Text(
          "Advertencia",
        ),
        description: Padding(
          padding: EdgeInsets.all(9),
          child: Text("Esta seguro que quiere eliminar esta tarea?"),
        ),
        actions: [
          ShadButton(
            backgroundColor: Colors.red,
            child: const Text('Continuar'),
            onPressed: () {
              TaskService().deleteTask(id);
              ShadToaster.of(context).show(
                const ShadToast(
                  description: Text('Tarea eliminada exitosamente'),
                ),
              );
              Navigator.of(context).pop(false);
            },
          ),
          ShadButton.outline(
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.white54),
            ),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.completed!) {
      stateTaskServer.searchTask(widget.id);
    }

    return ShadCard(
      backgroundColor: taskController.selectedTasks.contains(widget.id)
          ? Colors.lightBlueAccent
          : Colors.white70,
      shadows: [
        BoxShadow(
          color: Colors.white,
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
      width: double.infinity,
      title: Container(
        margin: EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                widget.title,
                softWrap: true,
                overflow: TextOverflow.clip,
                maxLines: null,
              ),
            ),
            !widget.online!
                ? Button(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: Colors.transparent,
                        elevation: 0),
                    click: () {
                      deleteTask(widget.id);
                    },
                    contentbtn: Icon(
                      Icons.close,
                      color: taskController.selectedTasks.contains(widget.id)
                          ? Colors.white
                          : Color(0x9095A0FF),
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
      description: Container(
        margin: EdgeInsets.only(top: 0),
        child: Text(widget.description),
      ),
      border: Border.all(width: 1, color: Colors.blueAccent),
      radius: BorderRadius.all(Radius.circular(20)),
      padding: EdgeInsets.all(10),
      child: Container(
        margin: EdgeInsets.only(top: 15),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            !widget.online!
                ? ShadButton.outline(
                    onPressed: widget.onClick,
                    height: 30,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    backgroundColor:
                        widget.completed! ? Colors.black : Colors.transparent,
                    decoration: ShadDecoration(
                        border: ShadBorder.all(
                            color: Color(0xFF5B36FF), width: .5)),
                    child: Text(
                      !widget.completed! ? "Editar" : "Devolver",
                      style: TextStyle(
                          color: !widget.completed!
                              ? Color(0xFF5B36FF)
                              : Colors.white,
                          fontSize: 15),
                    ),
                  )
                : Text(
                    "Online",
                    style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
            !widget.completed!
                ? Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        color: widget.priority == 1
                            ? Colors.red
                            : widget.priority == 2
                                ? Colors.orange
                                : Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(5))))
                : StreamBuilder<bool>(
                    stream: stateTaskServer.stream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.blueAccent,
                          ),
                        );
                      } else if (snapshot.hasData && snapshot.data == true) {
                        return Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      }
                      return Buttonupload(click: () {
                        UploadTaskMethod(context);
                      });
                    })
          ],
        ),
      ),
    );
  }
}
