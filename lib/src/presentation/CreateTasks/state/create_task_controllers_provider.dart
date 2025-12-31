import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'create_task_controllers.dart';

class CreateTaskControllersNotifier extends StateNotifier<CreateTaskControllers> {
  CreateTaskControllersNotifier()
      : super(CreateTaskControllers(
          titleController: TextEditingController(),
          descriptionController: TextEditingController(),
          priority: 0,
        ));

  @override
  void dispose() {
    state.titleController.dispose();
    state.descriptionController.dispose();
    super.dispose();
  }

  void changeTitleTask(dynamic value) {
    state = state.copyWith(
      titleController: TextEditingController(text: value),
    );
  }

  void changeDescriptionTask(dynamic value) {
    state = state.copyWith(
      descriptionController: TextEditingController(text: value),
    );
  }

  void changePriorityTask(int value) {
    state = state.copyWith(
      priority: value,
    );
  }

  void resetData(){
    state = state.copyWith(
      titleController: TextEditingController(),
      descriptionController: TextEditingController(),
      priority: 0,
    );
  }
}

final createTaskControllersProvider =
    StateNotifierProvider.autoDispose<CreateTaskControllersNotifier, CreateTaskControllers>(
  (ref) => CreateTaskControllersNotifier(),
);
