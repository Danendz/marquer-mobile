// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_study_session_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StoreStudySessionRequest {

 String get name;@JsonKey(name: 'study_subject_id') int? get studySubjectId;@JsonKey(name: 'timer_mode') TimerMode get timerMode;@JsonKey(name: 'planned_duration_seconds') int? get plannedDurationSeconds;@JsonKey(name: 'pomodoro_work_minutes') int? get pomodoroWorkMinutes;@JsonKey(name: 'pomodoro_short_break_minutes') int? get pomodoroShortBreakMinutes;@JsonKey(name: 'pomodoro_long_break_minutes') int? get pomodoroLongBreakMinutes;@JsonKey(name: 'pomodoro_cycles') int? get pomodoroCycles;
/// Create a copy of StoreStudySessionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreStudySessionRequestCopyWith<StoreStudySessionRequest> get copyWith => _$StoreStudySessionRequestCopyWithImpl<StoreStudySessionRequest>(this as StoreStudySessionRequest, _$identity);

  /// Serializes this StoreStudySessionRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreStudySessionRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.studySubjectId, studySubjectId) || other.studySubjectId == studySubjectId)&&(identical(other.timerMode, timerMode) || other.timerMode == timerMode)&&(identical(other.plannedDurationSeconds, plannedDurationSeconds) || other.plannedDurationSeconds == plannedDurationSeconds)&&(identical(other.pomodoroWorkMinutes, pomodoroWorkMinutes) || other.pomodoroWorkMinutes == pomodoroWorkMinutes)&&(identical(other.pomodoroShortBreakMinutes, pomodoroShortBreakMinutes) || other.pomodoroShortBreakMinutes == pomodoroShortBreakMinutes)&&(identical(other.pomodoroLongBreakMinutes, pomodoroLongBreakMinutes) || other.pomodoroLongBreakMinutes == pomodoroLongBreakMinutes)&&(identical(other.pomodoroCycles, pomodoroCycles) || other.pomodoroCycles == pomodoroCycles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,studySubjectId,timerMode,plannedDurationSeconds,pomodoroWorkMinutes,pomodoroShortBreakMinutes,pomodoroLongBreakMinutes,pomodoroCycles);

@override
String toString() {
  return 'StoreStudySessionRequest(name: $name, studySubjectId: $studySubjectId, timerMode: $timerMode, plannedDurationSeconds: $plannedDurationSeconds, pomodoroWorkMinutes: $pomodoroWorkMinutes, pomodoroShortBreakMinutes: $pomodoroShortBreakMinutes, pomodoroLongBreakMinutes: $pomodoroLongBreakMinutes, pomodoroCycles: $pomodoroCycles)';
}


}

/// @nodoc
abstract mixin class $StoreStudySessionRequestCopyWith<$Res>  {
  factory $StoreStudySessionRequestCopyWith(StoreStudySessionRequest value, $Res Function(StoreStudySessionRequest) _then) = _$StoreStudySessionRequestCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: 'study_subject_id') int? studySubjectId,@JsonKey(name: 'timer_mode') TimerMode timerMode,@JsonKey(name: 'planned_duration_seconds') int? plannedDurationSeconds,@JsonKey(name: 'pomodoro_work_minutes') int? pomodoroWorkMinutes,@JsonKey(name: 'pomodoro_short_break_minutes') int? pomodoroShortBreakMinutes,@JsonKey(name: 'pomodoro_long_break_minutes') int? pomodoroLongBreakMinutes,@JsonKey(name: 'pomodoro_cycles') int? pomodoroCycles
});




}
/// @nodoc
class _$StoreStudySessionRequestCopyWithImpl<$Res>
    implements $StoreStudySessionRequestCopyWith<$Res> {
  _$StoreStudySessionRequestCopyWithImpl(this._self, this._then);

  final StoreStudySessionRequest _self;
  final $Res Function(StoreStudySessionRequest) _then;

/// Create a copy of StoreStudySessionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? studySubjectId = freezed,Object? timerMode = null,Object? plannedDurationSeconds = freezed,Object? pomodoroWorkMinutes = freezed,Object? pomodoroShortBreakMinutes = freezed,Object? pomodoroLongBreakMinutes = freezed,Object? pomodoroCycles = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,studySubjectId: freezed == studySubjectId ? _self.studySubjectId : studySubjectId // ignore: cast_nullable_to_non_nullable
as int?,timerMode: null == timerMode ? _self.timerMode : timerMode // ignore: cast_nullable_to_non_nullable
as TimerMode,plannedDurationSeconds: freezed == plannedDurationSeconds ? _self.plannedDurationSeconds : plannedDurationSeconds // ignore: cast_nullable_to_non_nullable
as int?,pomodoroWorkMinutes: freezed == pomodoroWorkMinutes ? _self.pomodoroWorkMinutes : pomodoroWorkMinutes // ignore: cast_nullable_to_non_nullable
as int?,pomodoroShortBreakMinutes: freezed == pomodoroShortBreakMinutes ? _self.pomodoroShortBreakMinutes : pomodoroShortBreakMinutes // ignore: cast_nullable_to_non_nullable
as int?,pomodoroLongBreakMinutes: freezed == pomodoroLongBreakMinutes ? _self.pomodoroLongBreakMinutes : pomodoroLongBreakMinutes // ignore: cast_nullable_to_non_nullable
as int?,pomodoroCycles: freezed == pomodoroCycles ? _self.pomodoroCycles : pomodoroCycles // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [StoreStudySessionRequest].
extension StoreStudySessionRequestPatterns on StoreStudySessionRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoreStudySessionRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoreStudySessionRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoreStudySessionRequest value)  $default,){
final _that = this;
switch (_that) {
case _StoreStudySessionRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoreStudySessionRequest value)?  $default,){
final _that = this;
switch (_that) {
case _StoreStudySessionRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'study_subject_id')  int? studySubjectId, @JsonKey(name: 'timer_mode')  TimerMode timerMode, @JsonKey(name: 'planned_duration_seconds')  int? plannedDurationSeconds, @JsonKey(name: 'pomodoro_work_minutes')  int? pomodoroWorkMinutes, @JsonKey(name: 'pomodoro_short_break_minutes')  int? pomodoroShortBreakMinutes, @JsonKey(name: 'pomodoro_long_break_minutes')  int? pomodoroLongBreakMinutes, @JsonKey(name: 'pomodoro_cycles')  int? pomodoroCycles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoreStudySessionRequest() when $default != null:
return $default(_that.name,_that.studySubjectId,_that.timerMode,_that.plannedDurationSeconds,_that.pomodoroWorkMinutes,_that.pomodoroShortBreakMinutes,_that.pomodoroLongBreakMinutes,_that.pomodoroCycles);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'study_subject_id')  int? studySubjectId, @JsonKey(name: 'timer_mode')  TimerMode timerMode, @JsonKey(name: 'planned_duration_seconds')  int? plannedDurationSeconds, @JsonKey(name: 'pomodoro_work_minutes')  int? pomodoroWorkMinutes, @JsonKey(name: 'pomodoro_short_break_minutes')  int? pomodoroShortBreakMinutes, @JsonKey(name: 'pomodoro_long_break_minutes')  int? pomodoroLongBreakMinutes, @JsonKey(name: 'pomodoro_cycles')  int? pomodoroCycles)  $default,) {final _that = this;
switch (_that) {
case _StoreStudySessionRequest():
return $default(_that.name,_that.studySubjectId,_that.timerMode,_that.plannedDurationSeconds,_that.pomodoroWorkMinutes,_that.pomodoroShortBreakMinutes,_that.pomodoroLongBreakMinutes,_that.pomodoroCycles);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(name: 'study_subject_id')  int? studySubjectId, @JsonKey(name: 'timer_mode')  TimerMode timerMode, @JsonKey(name: 'planned_duration_seconds')  int? plannedDurationSeconds, @JsonKey(name: 'pomodoro_work_minutes')  int? pomodoroWorkMinutes, @JsonKey(name: 'pomodoro_short_break_minutes')  int? pomodoroShortBreakMinutes, @JsonKey(name: 'pomodoro_long_break_minutes')  int? pomodoroLongBreakMinutes, @JsonKey(name: 'pomodoro_cycles')  int? pomodoroCycles)?  $default,) {final _that = this;
switch (_that) {
case _StoreStudySessionRequest() when $default != null:
return $default(_that.name,_that.studySubjectId,_that.timerMode,_that.plannedDurationSeconds,_that.pomodoroWorkMinutes,_that.pomodoroShortBreakMinutes,_that.pomodoroLongBreakMinutes,_that.pomodoroCycles);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _StoreStudySessionRequest implements StoreStudySessionRequest {
  const _StoreStudySessionRequest({required this.name, @JsonKey(name: 'study_subject_id') this.studySubjectId, @JsonKey(name: 'timer_mode') required this.timerMode, @JsonKey(name: 'planned_duration_seconds') this.plannedDurationSeconds, @JsonKey(name: 'pomodoro_work_minutes') this.pomodoroWorkMinutes, @JsonKey(name: 'pomodoro_short_break_minutes') this.pomodoroShortBreakMinutes, @JsonKey(name: 'pomodoro_long_break_minutes') this.pomodoroLongBreakMinutes, @JsonKey(name: 'pomodoro_cycles') this.pomodoroCycles});
  factory _StoreStudySessionRequest.fromJson(Map<String, dynamic> json) => _$StoreStudySessionRequestFromJson(json);

@override final  String name;
@override@JsonKey(name: 'study_subject_id') final  int? studySubjectId;
@override@JsonKey(name: 'timer_mode') final  TimerMode timerMode;
@override@JsonKey(name: 'planned_duration_seconds') final  int? plannedDurationSeconds;
@override@JsonKey(name: 'pomodoro_work_minutes') final  int? pomodoroWorkMinutes;
@override@JsonKey(name: 'pomodoro_short_break_minutes') final  int? pomodoroShortBreakMinutes;
@override@JsonKey(name: 'pomodoro_long_break_minutes') final  int? pomodoroLongBreakMinutes;
@override@JsonKey(name: 'pomodoro_cycles') final  int? pomodoroCycles;

/// Create a copy of StoreStudySessionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoreStudySessionRequestCopyWith<_StoreStudySessionRequest> get copyWith => __$StoreStudySessionRequestCopyWithImpl<_StoreStudySessionRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoreStudySessionRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoreStudySessionRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.studySubjectId, studySubjectId) || other.studySubjectId == studySubjectId)&&(identical(other.timerMode, timerMode) || other.timerMode == timerMode)&&(identical(other.plannedDurationSeconds, plannedDurationSeconds) || other.plannedDurationSeconds == plannedDurationSeconds)&&(identical(other.pomodoroWorkMinutes, pomodoroWorkMinutes) || other.pomodoroWorkMinutes == pomodoroWorkMinutes)&&(identical(other.pomodoroShortBreakMinutes, pomodoroShortBreakMinutes) || other.pomodoroShortBreakMinutes == pomodoroShortBreakMinutes)&&(identical(other.pomodoroLongBreakMinutes, pomodoroLongBreakMinutes) || other.pomodoroLongBreakMinutes == pomodoroLongBreakMinutes)&&(identical(other.pomodoroCycles, pomodoroCycles) || other.pomodoroCycles == pomodoroCycles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,studySubjectId,timerMode,plannedDurationSeconds,pomodoroWorkMinutes,pomodoroShortBreakMinutes,pomodoroLongBreakMinutes,pomodoroCycles);

@override
String toString() {
  return 'StoreStudySessionRequest(name: $name, studySubjectId: $studySubjectId, timerMode: $timerMode, plannedDurationSeconds: $plannedDurationSeconds, pomodoroWorkMinutes: $pomodoroWorkMinutes, pomodoroShortBreakMinutes: $pomodoroShortBreakMinutes, pomodoroLongBreakMinutes: $pomodoroLongBreakMinutes, pomodoroCycles: $pomodoroCycles)';
}


}

/// @nodoc
abstract mixin class _$StoreStudySessionRequestCopyWith<$Res> implements $StoreStudySessionRequestCopyWith<$Res> {
  factory _$StoreStudySessionRequestCopyWith(_StoreStudySessionRequest value, $Res Function(_StoreStudySessionRequest) _then) = __$StoreStudySessionRequestCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: 'study_subject_id') int? studySubjectId,@JsonKey(name: 'timer_mode') TimerMode timerMode,@JsonKey(name: 'planned_duration_seconds') int? plannedDurationSeconds,@JsonKey(name: 'pomodoro_work_minutes') int? pomodoroWorkMinutes,@JsonKey(name: 'pomodoro_short_break_minutes') int? pomodoroShortBreakMinutes,@JsonKey(name: 'pomodoro_long_break_minutes') int? pomodoroLongBreakMinutes,@JsonKey(name: 'pomodoro_cycles') int? pomodoroCycles
});




}
/// @nodoc
class __$StoreStudySessionRequestCopyWithImpl<$Res>
    implements _$StoreStudySessionRequestCopyWith<$Res> {
  __$StoreStudySessionRequestCopyWithImpl(this._self, this._then);

  final _StoreStudySessionRequest _self;
  final $Res Function(_StoreStudySessionRequest) _then;

/// Create a copy of StoreStudySessionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? studySubjectId = freezed,Object? timerMode = null,Object? plannedDurationSeconds = freezed,Object? pomodoroWorkMinutes = freezed,Object? pomodoroShortBreakMinutes = freezed,Object? pomodoroLongBreakMinutes = freezed,Object? pomodoroCycles = freezed,}) {
  return _then(_StoreStudySessionRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,studySubjectId: freezed == studySubjectId ? _self.studySubjectId : studySubjectId // ignore: cast_nullable_to_non_nullable
as int?,timerMode: null == timerMode ? _self.timerMode : timerMode // ignore: cast_nullable_to_non_nullable
as TimerMode,plannedDurationSeconds: freezed == plannedDurationSeconds ? _self.plannedDurationSeconds : plannedDurationSeconds // ignore: cast_nullable_to_non_nullable
as int?,pomodoroWorkMinutes: freezed == pomodoroWorkMinutes ? _self.pomodoroWorkMinutes : pomodoroWorkMinutes // ignore: cast_nullable_to_non_nullable
as int?,pomodoroShortBreakMinutes: freezed == pomodoroShortBreakMinutes ? _self.pomodoroShortBreakMinutes : pomodoroShortBreakMinutes // ignore: cast_nullable_to_non_nullable
as int?,pomodoroLongBreakMinutes: freezed == pomodoroLongBreakMinutes ? _self.pomodoroLongBreakMinutes : pomodoroLongBreakMinutes // ignore: cast_nullable_to_non_nullable
as int?,pomodoroCycles: freezed == pomodoroCycles ? _self.pomodoroCycles : pomodoroCycles // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
