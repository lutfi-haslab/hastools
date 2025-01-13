// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tool_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ToolEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadTools,
    required TResult Function(String toolName) incrementClick,
    required TResult Function() sortTools,
    required TResult Function() resetTools,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadTools,
    TResult? Function(String toolName)? incrementClick,
    TResult? Function()? sortTools,
    TResult? Function()? resetTools,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadTools,
    TResult Function(String toolName)? incrementClick,
    TResult Function()? sortTools,
    TResult Function()? resetTools,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTools value) loadTools,
    required TResult Function(IncrementClick value) incrementClick,
    required TResult Function(SortTools value) sortTools,
    required TResult Function(ResetTools value) resetTools,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTools value)? loadTools,
    TResult? Function(IncrementClick value)? incrementClick,
    TResult? Function(SortTools value)? sortTools,
    TResult? Function(ResetTools value)? resetTools,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTools value)? loadTools,
    TResult Function(IncrementClick value)? incrementClick,
    TResult Function(SortTools value)? sortTools,
    TResult Function(ResetTools value)? resetTools,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ToolEventCopyWith<$Res> {
  factory $ToolEventCopyWith(ToolEvent value, $Res Function(ToolEvent) then) =
      _$ToolEventCopyWithImpl<$Res, ToolEvent>;
}

/// @nodoc
class _$ToolEventCopyWithImpl<$Res, $Val extends ToolEvent>
    implements $ToolEventCopyWith<$Res> {
  _$ToolEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ToolEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadToolsImplCopyWith<$Res> {
  factory _$$LoadToolsImplCopyWith(
          _$LoadToolsImpl value, $Res Function(_$LoadToolsImpl) then) =
      __$$LoadToolsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadToolsImplCopyWithImpl<$Res>
    extends _$ToolEventCopyWithImpl<$Res, _$LoadToolsImpl>
    implements _$$LoadToolsImplCopyWith<$Res> {
  __$$LoadToolsImplCopyWithImpl(
      _$LoadToolsImpl _value, $Res Function(_$LoadToolsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ToolEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadToolsImpl implements LoadTools {
  const _$LoadToolsImpl();

  @override
  String toString() {
    return 'ToolEvent.loadTools()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadToolsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadTools,
    required TResult Function(String toolName) incrementClick,
    required TResult Function() sortTools,
    required TResult Function() resetTools,
  }) {
    return loadTools();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadTools,
    TResult? Function(String toolName)? incrementClick,
    TResult? Function()? sortTools,
    TResult? Function()? resetTools,
  }) {
    return loadTools?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadTools,
    TResult Function(String toolName)? incrementClick,
    TResult Function()? sortTools,
    TResult Function()? resetTools,
    required TResult orElse(),
  }) {
    if (loadTools != null) {
      return loadTools();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTools value) loadTools,
    required TResult Function(IncrementClick value) incrementClick,
    required TResult Function(SortTools value) sortTools,
    required TResult Function(ResetTools value) resetTools,
  }) {
    return loadTools(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTools value)? loadTools,
    TResult? Function(IncrementClick value)? incrementClick,
    TResult? Function(SortTools value)? sortTools,
    TResult? Function(ResetTools value)? resetTools,
  }) {
    return loadTools?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTools value)? loadTools,
    TResult Function(IncrementClick value)? incrementClick,
    TResult Function(SortTools value)? sortTools,
    TResult Function(ResetTools value)? resetTools,
    required TResult orElse(),
  }) {
    if (loadTools != null) {
      return loadTools(this);
    }
    return orElse();
  }
}

abstract class LoadTools implements ToolEvent {
  const factory LoadTools() = _$LoadToolsImpl;
}

/// @nodoc
abstract class _$$IncrementClickImplCopyWith<$Res> {
  factory _$$IncrementClickImplCopyWith(_$IncrementClickImpl value,
          $Res Function(_$IncrementClickImpl) then) =
      __$$IncrementClickImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String toolName});
}

/// @nodoc
class __$$IncrementClickImplCopyWithImpl<$Res>
    extends _$ToolEventCopyWithImpl<$Res, _$IncrementClickImpl>
    implements _$$IncrementClickImplCopyWith<$Res> {
  __$$IncrementClickImplCopyWithImpl(
      _$IncrementClickImpl _value, $Res Function(_$IncrementClickImpl) _then)
      : super(_value, _then);

  /// Create a copy of ToolEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? toolName = null,
  }) {
    return _then(_$IncrementClickImpl(
      null == toolName
          ? _value.toolName
          : toolName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$IncrementClickImpl implements IncrementClick {
  const _$IncrementClickImpl(this.toolName);

  @override
  final String toolName;

  @override
  String toString() {
    return 'ToolEvent.incrementClick(toolName: $toolName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncrementClickImpl &&
            (identical(other.toolName, toolName) ||
                other.toolName == toolName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, toolName);

  /// Create a copy of ToolEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IncrementClickImplCopyWith<_$IncrementClickImpl> get copyWith =>
      __$$IncrementClickImplCopyWithImpl<_$IncrementClickImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadTools,
    required TResult Function(String toolName) incrementClick,
    required TResult Function() sortTools,
    required TResult Function() resetTools,
  }) {
    return incrementClick(toolName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadTools,
    TResult? Function(String toolName)? incrementClick,
    TResult? Function()? sortTools,
    TResult? Function()? resetTools,
  }) {
    return incrementClick?.call(toolName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadTools,
    TResult Function(String toolName)? incrementClick,
    TResult Function()? sortTools,
    TResult Function()? resetTools,
    required TResult orElse(),
  }) {
    if (incrementClick != null) {
      return incrementClick(toolName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTools value) loadTools,
    required TResult Function(IncrementClick value) incrementClick,
    required TResult Function(SortTools value) sortTools,
    required TResult Function(ResetTools value) resetTools,
  }) {
    return incrementClick(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTools value)? loadTools,
    TResult? Function(IncrementClick value)? incrementClick,
    TResult? Function(SortTools value)? sortTools,
    TResult? Function(ResetTools value)? resetTools,
  }) {
    return incrementClick?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTools value)? loadTools,
    TResult Function(IncrementClick value)? incrementClick,
    TResult Function(SortTools value)? sortTools,
    TResult Function(ResetTools value)? resetTools,
    required TResult orElse(),
  }) {
    if (incrementClick != null) {
      return incrementClick(this);
    }
    return orElse();
  }
}

abstract class IncrementClick implements ToolEvent {
  const factory IncrementClick(final String toolName) = _$IncrementClickImpl;

  String get toolName;

  /// Create a copy of ToolEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IncrementClickImplCopyWith<_$IncrementClickImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SortToolsImplCopyWith<$Res> {
  factory _$$SortToolsImplCopyWith(
          _$SortToolsImpl value, $Res Function(_$SortToolsImpl) then) =
      __$$SortToolsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SortToolsImplCopyWithImpl<$Res>
    extends _$ToolEventCopyWithImpl<$Res, _$SortToolsImpl>
    implements _$$SortToolsImplCopyWith<$Res> {
  __$$SortToolsImplCopyWithImpl(
      _$SortToolsImpl _value, $Res Function(_$SortToolsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ToolEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SortToolsImpl implements SortTools {
  const _$SortToolsImpl();

  @override
  String toString() {
    return 'ToolEvent.sortTools()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SortToolsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadTools,
    required TResult Function(String toolName) incrementClick,
    required TResult Function() sortTools,
    required TResult Function() resetTools,
  }) {
    return sortTools();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadTools,
    TResult? Function(String toolName)? incrementClick,
    TResult? Function()? sortTools,
    TResult? Function()? resetTools,
  }) {
    return sortTools?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadTools,
    TResult Function(String toolName)? incrementClick,
    TResult Function()? sortTools,
    TResult Function()? resetTools,
    required TResult orElse(),
  }) {
    if (sortTools != null) {
      return sortTools();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTools value) loadTools,
    required TResult Function(IncrementClick value) incrementClick,
    required TResult Function(SortTools value) sortTools,
    required TResult Function(ResetTools value) resetTools,
  }) {
    return sortTools(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTools value)? loadTools,
    TResult? Function(IncrementClick value)? incrementClick,
    TResult? Function(SortTools value)? sortTools,
    TResult? Function(ResetTools value)? resetTools,
  }) {
    return sortTools?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTools value)? loadTools,
    TResult Function(IncrementClick value)? incrementClick,
    TResult Function(SortTools value)? sortTools,
    TResult Function(ResetTools value)? resetTools,
    required TResult orElse(),
  }) {
    if (sortTools != null) {
      return sortTools(this);
    }
    return orElse();
  }
}

abstract class SortTools implements ToolEvent {
  const factory SortTools() = _$SortToolsImpl;
}

/// @nodoc
abstract class _$$ResetToolsImplCopyWith<$Res> {
  factory _$$ResetToolsImplCopyWith(
          _$ResetToolsImpl value, $Res Function(_$ResetToolsImpl) then) =
      __$$ResetToolsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetToolsImplCopyWithImpl<$Res>
    extends _$ToolEventCopyWithImpl<$Res, _$ResetToolsImpl>
    implements _$$ResetToolsImplCopyWith<$Res> {
  __$$ResetToolsImplCopyWithImpl(
      _$ResetToolsImpl _value, $Res Function(_$ResetToolsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ToolEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetToolsImpl implements ResetTools {
  const _$ResetToolsImpl();

  @override
  String toString() {
    return 'ToolEvent.resetTools()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResetToolsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadTools,
    required TResult Function(String toolName) incrementClick,
    required TResult Function() sortTools,
    required TResult Function() resetTools,
  }) {
    return resetTools();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadTools,
    TResult? Function(String toolName)? incrementClick,
    TResult? Function()? sortTools,
    TResult? Function()? resetTools,
  }) {
    return resetTools?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadTools,
    TResult Function(String toolName)? incrementClick,
    TResult Function()? sortTools,
    TResult Function()? resetTools,
    required TResult orElse(),
  }) {
    if (resetTools != null) {
      return resetTools();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTools value) loadTools,
    required TResult Function(IncrementClick value) incrementClick,
    required TResult Function(SortTools value) sortTools,
    required TResult Function(ResetTools value) resetTools,
  }) {
    return resetTools(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTools value)? loadTools,
    TResult? Function(IncrementClick value)? incrementClick,
    TResult? Function(SortTools value)? sortTools,
    TResult? Function(ResetTools value)? resetTools,
  }) {
    return resetTools?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTools value)? loadTools,
    TResult Function(IncrementClick value)? incrementClick,
    TResult Function(SortTools value)? sortTools,
    TResult Function(ResetTools value)? resetTools,
    required TResult orElse(),
  }) {
    if (resetTools != null) {
      return resetTools(this);
    }
    return orElse();
  }
}

abstract class ResetTools implements ToolEvent {
  const factory ResetTools() = _$ResetToolsImpl;
}

/// @nodoc
mixin _$ToolState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Tool> tools) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Tool> tools)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Tool> tools)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ToolStateCopyWith<$Res> {
  factory $ToolStateCopyWith(ToolState value, $Res Function(ToolState) then) =
      _$ToolStateCopyWithImpl<$Res, ToolState>;
}

/// @nodoc
class _$ToolStateCopyWithImpl<$Res, $Val extends ToolState>
    implements $ToolStateCopyWith<$Res> {
  _$ToolStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ToolState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$ToolStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ToolState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'ToolState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Tool> tools) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Tool> tools)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Tool> tools)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements ToolState {
  const factory Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$ToolStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ToolState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'ToolState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Tool> tools) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Tool> tools)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Tool> tools)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements ToolState {
  const factory Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Tool> tools});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$ToolStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ToolState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tools = null,
  }) {
    return _then(_$LoadedImpl(
      null == tools
          ? _value._tools
          : tools // ignore: cast_nullable_to_non_nullable
              as List<Tool>,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements Loaded {
  const _$LoadedImpl(final List<Tool> tools) : _tools = tools;

  final List<Tool> _tools;
  @override
  List<Tool> get tools {
    if (_tools is EqualUnmodifiableListView) return _tools;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tools);
  }

  @override
  String toString() {
    return 'ToolState.loaded(tools: $tools)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._tools, _tools));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tools));

  /// Create a copy of ToolState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Tool> tools) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(tools);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Tool> tools)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(tools);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Tool> tools)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(tools);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class Loaded implements ToolState {
  const factory Loaded(final List<Tool> tools) = _$LoadedImpl;

  List<Tool> get tools;

  /// Create a copy of ToolState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$ToolStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ToolState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ToolState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ToolState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Tool> tools) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Tool> tools)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Tool> tools)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements ToolState {
  const factory Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of ToolState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
