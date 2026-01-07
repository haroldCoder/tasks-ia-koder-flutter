// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brain_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BrainState {
  ElementId get elementId => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  bool get hasError => throw _privateConstructorUsedError;
  String get textGenerated => throw _privateConstructorUsedError;
  bool get clearError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BrainStateCopyWith<BrainState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrainStateCopyWith<$Res> {
  factory $BrainStateCopyWith(
          BrainState value, $Res Function(BrainState) then) =
      _$BrainStateCopyWithImpl<$Res, BrainState>;
  @useResult
  $Res call(
      {ElementId elementId,
      bool loading,
      Object? error,
      bool hasError,
      String textGenerated,
      bool clearError});
}

/// @nodoc
class _$BrainStateCopyWithImpl<$Res, $Val extends BrainState>
    implements $BrainStateCopyWith<$Res> {
  _$BrainStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? elementId = null,
    Object? loading = null,
    Object? error = freezed,
    Object? hasError = null,
    Object? textGenerated = null,
    Object? clearError = null,
  }) {
    return _then(_value.copyWith(
      elementId: null == elementId
          ? _value.elementId
          : elementId // ignore: cast_nullable_to_non_nullable
              as ElementId,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _value.error : error,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      textGenerated: null == textGenerated
          ? _value.textGenerated
          : textGenerated // ignore: cast_nullable_to_non_nullable
              as String,
      clearError: null == clearError
          ? _value.clearError
          : clearError // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BrainStateImplCopyWith<$Res>
    implements $BrainStateCopyWith<$Res> {
  factory _$$BrainStateImplCopyWith(
          _$BrainStateImpl value, $Res Function(_$BrainStateImpl) then) =
      __$$BrainStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ElementId elementId,
      bool loading,
      Object? error,
      bool hasError,
      String textGenerated,
      bool clearError});
}

/// @nodoc
class __$$BrainStateImplCopyWithImpl<$Res>
    extends _$BrainStateCopyWithImpl<$Res, _$BrainStateImpl>
    implements _$$BrainStateImplCopyWith<$Res> {
  __$$BrainStateImplCopyWithImpl(
      _$BrainStateImpl _value, $Res Function(_$BrainStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? elementId = null,
    Object? loading = null,
    Object? error = freezed,
    Object? hasError = null,
    Object? textGenerated = null,
    Object? clearError = null,
  }) {
    return _then(_$BrainStateImpl(
      elementId: null == elementId
          ? _value.elementId
          : elementId // ignore: cast_nullable_to_non_nullable
              as ElementId,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _value.error : error,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      textGenerated: null == textGenerated
          ? _value.textGenerated
          : textGenerated // ignore: cast_nullable_to_non_nullable
              as String,
      clearError: null == clearError
          ? _value.clearError
          : clearError // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$BrainStateImpl extends _BrainState {
  const _$BrainStateImpl(
      {this.elementId = ElementId.worthless,
      this.loading = false,
      this.error,
      this.hasError = false,
      this.textGenerated = "",
      this.clearError = false})
      : super._();

  @override
  @JsonKey()
  final ElementId elementId;
  @override
  @JsonKey()
  final bool loading;
  @override
  final Object? error;
  @override
  @JsonKey()
  final bool hasError;
  @override
  @JsonKey()
  final String textGenerated;
  @override
  @JsonKey()
  final bool clearError;

  @override
  String toString() {
    return 'BrainState(elementId: $elementId, loading: $loading, error: $error, hasError: $hasError, textGenerated: $textGenerated, clearError: $clearError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrainStateImpl &&
            (identical(other.elementId, elementId) ||
                other.elementId == elementId) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.hasError, hasError) ||
                other.hasError == hasError) &&
            (identical(other.textGenerated, textGenerated) ||
                other.textGenerated == textGenerated) &&
            (identical(other.clearError, clearError) ||
                other.clearError == clearError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      elementId,
      loading,
      const DeepCollectionEquality().hash(error),
      hasError,
      textGenerated,
      clearError);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BrainStateImplCopyWith<_$BrainStateImpl> get copyWith =>
      __$$BrainStateImplCopyWithImpl<_$BrainStateImpl>(this, _$identity);
}

abstract class _BrainState extends BrainState {
  const factory _BrainState(
      {final ElementId elementId,
      final bool loading,
      final Object? error,
      final bool hasError,
      final String textGenerated,
      final bool clearError}) = _$BrainStateImpl;
  const _BrainState._() : super._();

  @override
  ElementId get elementId;
  @override
  bool get loading;
  @override
  Object? get error;
  @override
  bool get hasError;
  @override
  String get textGenerated;
  @override
  bool get clearError;
  @override
  @JsonKey(ignore: true)
  _$$BrainStateImplCopyWith<_$BrainStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
