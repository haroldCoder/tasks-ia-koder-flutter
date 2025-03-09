import 'dart:ffi';

import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/shared/States/Tasks/task_service.dart';

import '../../../views/states/createTaskState.dart';

class TaskController extends GetxController {
  final _taskService = TaskService();
  var tasks = <CreateTasksState>[].obs;
  RxList<int> selectedTasks = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasksPeriodically();
  }

  Future<void> fetchTasksPeriodically() async {
    while (true) {
      await Future.delayed(Duration(seconds: 2));
      tasks.value = await _taskService.getTasks();
    }
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