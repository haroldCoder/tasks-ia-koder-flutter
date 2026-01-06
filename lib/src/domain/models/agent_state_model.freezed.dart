// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$IAgentStateModel {
  ElementId get select => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  http.Response? get response => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  bool get hasError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IAgentStateModelCopyWith<IAgentStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IAgentStateModelCopyWith<$Res> {
  factory $IAgentStateModelCopyWith(
          IAgentStateModel value, $Res Function(IAgentStateModel) then) =
      _$IAgentStateModelCopyWithImpl<$Res, IAgentStateModel>;
  @useResult
  $Res call(
      {ElementId select,
      bool loading,
      http.Response? response,
      String? error,
      bool hasError});
}

/// @nodoc
class _$IAgentStateModelCopyWithImpl<$Res, $Val extends IAgentStateModel>
    implements $IAgentStateModelCopyWith<$Res> {
  _$IAgentStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? select = null,
    Object? loading = null,
    Object? response = freezed,
    Object? error = freezed,
    Object? hasError = null,
  }) {
    return _then(_value.copyWith(
      select: null == select
          ? _value.select
          : select // ignore: cast_nullable_to_non_nullable
              as ElementId,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      response: freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as http.Response?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IAgentStateModelImplCopyWith<$Res>
    implements $IAgentStateModelCopyWith<$Res> {
  factory _$$IAgentStateModelImplCopyWith(_$IAgentStateModelImpl value,
          $Res Function(_$IAgentStateModelImpl) then) =
      __$$IAgentStateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ElementId select,
      bool loading,
      http.Response? response,
      String? error,
      bool hasError});
}

/// @nodoc
class __$$IAgentStateModelImplCopyWithImpl<$Res>
    extends _$IAgentStateModelCopyWithImpl<$Res, _$IAgentStateModelImpl>
    implements _$$IAgentStateModelImplCopyWith<$Res> {
  __$$IAgentStateModelImplCopyWithImpl(_$IAgentStateModelImpl _value,
      $Res Function(_$IAgentStateModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? select = null,
    Object? loading = null,
    Object? response = freezed,
    Object? error = freezed,
    Object? hasError = null,
  }) {
    return _then(_$IAgentStateModelImpl(
      select: null == select
          ? _value.select
          : select // ignore: cast_nullable_to_non_nullable
              as ElementId,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      response: freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as http.Response?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$IAgentStateModelImpl implements _IAgentStateModel {
  const _$IAgentStateModelImpl(
      {this.select = ElementId.worthless,
      this.loading = false,
      this.response,
      this.error,
      this.hasError = false});

  @override
  @JsonKey()
  final ElementId select;
  @override
  @JsonKey()
  final bool loading;
  @override
  final http.Response? response;
  @override
  final String? error;
  @override
  @JsonKey()
  final bool hasError;

  @override
  String toString() {
    return 'IAgentStateModel(select: $select, loading: $loading, response: $response, error: $error, hasError: $hasError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IAgentStateModelImpl &&
            (identical(other.select, select) || other.select == select) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.hasError, hasError) ||
                other.hasError == hasError));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, select, loading, response, error, hasError);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IAgentStateModelImplCopyWith<_$IAgentStateModelImpl> get copyWith =>
      __$$IAgentStateModelImplCopyWithImpl<_$IAgentStateModelImpl>(
          this, _$identity);
}

abstract class _IAgentStateModel implements IAgentStateModel {
  const factory _IAgentStateModel(
      {final ElementId select,
      final bool loading,
      final http.Response? response,
      final String? error,
      final bool hasError}) = _$IAgentStateModelImpl;

  @override
  ElementId get select;
  @override
  bool get loading;
  @override
  http.Response? get response;
  @override
  String? get error;
  @override
  bool get hasError;
  @override
  @JsonKey(ignore: true)
  _$$IAgentStateModelImplCopyWith<_$IAgentStateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
