import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/shared/commands/taskCommand.dart';
import 'package:tasks_ia_koderx/src/shared/enums/taskCommandTypes.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/payloadsTaskCommand.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/tasks.interface.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/updateTask.interface.dart';

class TaskController extends GetxController {
  var tasks = <TasksInterface>[].obs;
  RxList<int> selectedTasks = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasksPeriodically();
  }

  Future<void> fetchTasksPeriodically() async {
    while (true) {
      await Future.delayed(Duration(seconds: 2));
      tasks.value = await GetTaskCommand().execute();
    }
  }

  Future<int> updateTask(UpdateTasksInterface task, int id) async {
    print(task.toMap());
    return await UpdateTaskCommand().execute(UpdateTaskPayload(id, task));
  }

  Future<void> createTask(String title, String description, int priority) async {
    await CreateTaskCommand().execute(CreateTaskPayload(title, description, priority));
  }

  Future<int> deleteTask(int id) async {
    return await DeleteTaskCommand().execute(DeleteTaskPayload(id));
  }

  Future<int> deleteSeveralTasks(List<int> ids) async {
    return await DeleteTaskSeveralCommand().execute(DeleteTaskSeveralPayload(ids));
  }

  void clearSelectTasks(){
    selectedTasks.clear();
  }

  void AssignTasksSelected(List<int> ids) {
    if(selectedTasks.isEmpty){
      selectedTasks.assignAll(ids.obs);
    }
    else{
      clearSelectTasks();
    }
  }

  @override
  void onClose() {
    clearSelectTasks();
    super.onClose();
  }
}