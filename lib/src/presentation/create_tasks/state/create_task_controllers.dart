import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_task_controllers.freezed.dart';

@freezed
class CreateTaskControllers with _$CreateTaskControllers {
  factory CreateTaskControllers({
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    required int priority,
  }) = _CreateTaskControllers;
}