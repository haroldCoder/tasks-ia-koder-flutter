import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:tasks_ia_koderx/src/providers/task_providers.dart';
import 'package:tasks_ia_koderx/src/providers/task_state.dart';
import 'package:tasks_ia_koderx/src/domain/models/task_model.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/tasks.interface.dart';
import 'package:tasks_ia_koderx/src/shared/lang/taskContainer/lang.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AuthService.dart';
import 'package:tasks_ia_koderx/src/shared/utils/users/stateTaskServer.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/Button.dart';
import 'package:tasks_ia_koderx/src/widgets/ButtonUpload/ButtonUpload.dart';
import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/widgets/TaskContainer/utils/showUserNotLogged.dart';
import 'package:tasks_ia_koderx/src/widgets/TaskContainer/utils/uploadTask.dart';

class TaskContainer extends ConsumerStatefulWidget {
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
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TaskContainerState();
  }
}

class _TaskContainerState extends ConsumerState<TaskContainer> {
  UploadTask uploadTask = Get.put(UploadTask());
  final taskServerStateProvider =
      AsyncNotifierProvider<StateTaskServerNotifier, bool>(
          StateTaskServerNotifier.new);

  @override
  void initState() {
    super.initState();

    final stateTaskController = ref.read(taskServerStateProvider.notifier);

    if (widget.completed!) {
      Future.microtask(() {
        stateTaskController.searchTask(widget.id);
      });
    }
  }

  void UploadTaskMethod(BuildContext context) {
    final authState = ref.read(authServiceProvider);
    if (!authState.logged) {
      showUserNotLogged(context);
      return;
    }
    uploadTask.Upload(
        context,
        ITaskModel(
            id: widget.id,
            title: widget.title,
            description: widget.description,
            priority: widget.priority,
            completed: widget.completed! ? 1 : 0) as TasksInterface,
        ref);
  }

  deleteTask(int id) {
    showShadDialog(
      context: context,
      builder: (context) => ShadDialog.alert(
        backgroundColor: Colors.black,
        titleStyle: TextStyle(color: Colors.red, fontSize: 22),
        title: Text(
          warningTaskContainer,
        ),
        description: Padding(
          padding: EdgeInsets.all(9),
          child: Text(questionTaskContainer),
        ),
        actions: [
          ShadButton(
            backgroundColor: Colors.red,
            child: Text(continueTaskContainer),
            onPressed: () {
              ref.read(taskUseCasesProvider.notifier).deleteTask(id);
              ShadToaster.of(context).show(
                ShadToast(
                  description: Text(taskRemoveTaskContainer),
                ),
              );
              Navigator.of(context).pop(false);
            },
          ),
          ShadButton.outline(
            child: Text(
              cancelTaskContainer,
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
    TasksState taskState = ref.watch(taskUseCasesProvider);
    final stateTaskServer = ref.watch(taskServerStateProvider);
    final authState = ref.watch(authServiceProvider);

    return ShadCard(
      backgroundColor: taskState.selectedTasks.contains(widget.id)
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
                      color: taskState.selectedTasks.contains(widget.id)
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
                      !widget.completed!
                          ? btnEditTaskContainer
                          : btnReturnTaskContainer,
                      style: TextStyle(
                          color: !widget.completed!
                              ? Color(0xFF5B36FF)
                              : Colors.white,
                          fontSize: 15),
                    ),
                  )
                : Text(
                    statusTaskContainer,
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
                : stateTaskServer.when(loading: () {
                    return SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.blueAccent,
                      ),
                    );
                  }, data: (value) {
                    if (authState.logged) {
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
                  }, error: (e, _) {
                    return Icon(
                      Icons.cloud_off,
                      color: Colors.red,
                    );
                  })
          ],
        ),
      ),
    );
  }
}
