// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_task_controllers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateTaskControllers {
  TextEditingController get titleController =>
      throw _privateConstructorUsedError;
  TextEditingController get descriptionController =>
      throw _privateConstructorUsedError;
  int get priority => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateTaskControllersCopyWith<CreateTaskControllers> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateTaskControllersCopyWith<$Res> {
  factory $CreateTaskControllersCopyWith(CreateTaskControllers value,
          $Res Function(CreateTaskControllers) then) =
      _$CreateTaskControllersCopyWithImpl<$Res, CreateTaskControllers>;
  @useResult
  $Res call(
      {TextEditingController titleController,
      TextEditingController descriptionController,
      int priority});
}

/// @nodoc
class _$CreateTaskControllersCopyWithImpl<$Res,
        $Val extends CreateTaskControllers>
    implements $CreateTaskControllersCopyWith<$Res> {
  _$CreateTaskControllersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titleController = null,
    Object? descriptionController = null,
    Object? priority = null,
  }) {
    return _then(_value.copyWith(
      titleController: null == titleController
          ? _value.titleController
          : titleController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      descriptionController: null == descriptionController
          ? _value.descriptionController
          : descriptionController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateTaskControllersImplCopyWith<$Res>
    implements $CreateTaskControllersCopyWith<$Res> {
  factory _$$CreateTaskControllersImplCopyWith(
          _$CreateTaskControllersImpl value,
          $Res Function(_$CreateTaskControllersImpl) then) =
      __$$CreateTaskControllersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TextEditingController titleController,
      TextEditingController descriptionController,
      int priority});
}

/// @nodoc
class __$$CreateTaskControllersImplCopyWithImpl<$Res>
    extends _$CreateTaskControllersCopyWithImpl<$Res,
        _$CreateTaskControllersImpl>
    implements _$$CreateTaskControllersImplCopyWith<$Res> {
  __$$CreateTaskControllersImplCopyWithImpl(_$CreateTaskControllersImpl _value,
      $Res Function(_$CreateTaskControllersImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titleController = null,
    Object? descriptionController = null,
    Object? priority = null,
  }) {
    return _then(_$CreateTaskControllersImpl(
      titleController: null == titleController
          ? _value.titleController
          : titleController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      descriptionController: null == descriptionController
          ? _value.descriptionController
          : descriptionController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CreateTaskControllersImpl implements _CreateTaskControllers {
  _$CreateTaskControllersImpl(
      {required this.titleController,
      required this.descriptionController,
      required this.priority});

  @override
  final TextEditingController titleController;
  @override
  final TextEditingController descriptionController;
  @override
  final int priority;

  @override
  String toString() {
    return 'CreateTaskControllers(titleController: $titleController, descriptionController: $descriptionController, priority: $priority)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTaskControllersImpl &&
            (identical(other.titleController, titleController) ||
                other.titleController == titleController) &&
            (identical(other.descriptionController, descriptionController) ||
                other.descriptionController == descriptionController) &&
            (identical(other.priority, priority) ||
                other.priority == priority));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, titleController, descriptionController, priority);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateTaskControllersImplCopyWith<_$CreateTaskControllersImpl>
      get copyWith => __$$CreateTaskControllersImplCopyWithImpl<
          _$CreateTaskControllersImpl>(this, _$identity);
}

abstract class _CreateTaskControllers implements CreateTaskControllers {
  factory _CreateTaskControllers(
      {required final TextEditingController titleController,
      required final TextEditingController descriptionController,
      required final int priority}) = _$CreateTaskControllersImpl;

  @override
  TextEditingController get titleController;
  @override
  TextEditingController get descriptionController;
  @override
  int get priority;
  @override
  @JsonKey(ignore: true)
  _$$CreateTaskControllersImplCopyWith<_$CreateTaskControllersImpl>
      get copyWith => throw _privateConstructorUsedError;
}
