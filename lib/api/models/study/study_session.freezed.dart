// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StudySession {

 int get id;@JsonKey(name: 'user_id') int get userId;@JsonKey(name: 'study_subject_id') int? get studySubjectId; String get name;@JsonKey(name: 'timer_mode') TimerMode get timerMode; StudySessionStatus get status;@JsonKey(name: 'planned_duration_seconds') int? get plannedDurationSeconds;@JsonKey(name: 'actual_duration_seconds') int get actualDurationSeconds;@JsonKey(name: 'started_at') String get startedAt;@JsonKey(name: 'ended_at') String? get endedAt;@JsonKey(name: 'pomodoro_work_minutes') int? get pomodoroWorkMinutes;@JsonKey(name: 'pomodoro_short_break_minutes') int? get pomodoroShortBreakMinutes;@JsonKey(name: 'pomodoro_long_break_minutes') int? get pomodoroLongBreakMinutes;@JsonKey(name: 'pomodoro_cycles') int? get pomodoroCycles;@JsonKey(name: 'pomodoro_completed_cycles') int get pomodoroCompletedCycles; StudySubject? get subject;@JsonKey(name: 'created_at') String get createdAt;@JsonKey(name: 'updated_at') String get updatedAt;
/// Create a copy of StudySession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudySessionCopyWith<StudySession> get copyWith => _$StudySessionCopyWithImpl<StudySession>(this as StudySession, _$identity);

  /// Serializes this StudySession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudySession&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.studySubjectId, studySubjectId) || other.studySubjectId == studySubjectId)&&(identical(other.name, name) || other.name == name)&&(identical(other.timerMode, timerMode) || other.timerMode == timerMode)&&(identical(other.status, status) || other.status == status)&&(identical(other.plannedDurationSeconds, plannedDurationSeconds) || other.plannedDurationSeconds == plannedDurationSeconds)&&(identical(other.actualDurationSeconds, actualDurationSeconds) || other.actualDurationSeconds == actualDurationSeconds)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.pomodoroWorkMinutes, pomodoroWorkMinutes) || other.pomodoroWorkMinutes == pomodoroWorkMinutes)&&(identical(other.pomodoroShortBreakMinutes, pomodoroShortBreakMinutes) || other.pomodoroShortBreakMinutes == pomodoroShortBreakMinutes)&&(identical(other.pomodoroLongBreakMinutes, pomodoroLongBreakMinutes) || other.pomodoroLongBreakMinutes == pomodoroLongBreakMinutes)&&(identical(other.pomodoroCycles, pomodoroCycles) || other.pomodoroCycles == pomodoroCycles)&&(identical(other.pomodoroCompletedCycles, pomodoroCompletedCycles) || other.pomodoroCompletedCycles == pomodoroCompletedCycles)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,studySubjectId,name,timerMode,status,plannedDurationSeconds,actualDurationSeconds,startedAt,endedAt,pomodoroWorkMinutes,pomodoroShortBreakMinutes,pomodoroLongBreakMinutes,pomodoroCycles,pomodoroCompletedCycles,subject,createdAt,updatedAt);

@override
String toString() {
  return 'StudySession(id: $id, userId: $userId, studySubjectId: $studySubjectId, name: $name, timerMode: $timerMode, status: $status, plannedDurationSeconds: $plannedDurationSeconds, actualDurationSeconds: $actualDurationSeconds, startedAt: $startedAt, endedAt: $endedAt, pomodoroWorkMinutes: $pomodoroWorkMinutes, pomodoroShortBreakMinutes: $pomodoroShortBreakMinutes, pomodoroLongBreakMinutes: $pomodoroLongBreakMinutes, pomodoroCycles: $pomodoroCycles, pomodoroCompletedCycles: $pomodoroCompletedCycles, subject: $subject, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $StudySessionCopyWith<$Res>  {
  factory $StudySessionCopyWith(StudySession value, $Res Function(StudySession) _then) = _$StudySessionCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'user_id') int userId,@JsonKey(name: 'study_subject_id') int? studySubjectId, String name,@JsonKey(name: 'timer_mode') TimerMode timerMode, StudySessionStatus status,@JsonKey(name: 'planned_duration_seconds') int? plannedDurationSeconds,@JsonKey(name: 'actual_duration_seconds') int actualDurationSeconds,@JsonKey(name: 'started_at') String startedAt,@JsonKey(name: 'ended_at') String? endedAt,@JsonKey(name: 'pomodoro_work_minutes') int? pomodoroWorkMinutes,@JsonKey(name: 'pomodoro_short_break_minutes') int? pomodoroShortBreakMinutes,@JsonKey(name: 'pomodoro_long_break_minutes') int? pomodoroLongBreakMinutes,@JsonKey(name: 'pomodoro_cycles') int? pomodoroCycles,@JsonKey(name: 'pomodoro_completed_cycles') int pomodoroCompletedCycles, StudySubject? subject,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt
});


$StudySubjectCopyWith<$Res>? get subject;

}
/// @nodoc
class _$StudySessionCopyWithImpl<$Res>
    implements $StudySessionCopyWith<$Res> {
  _$StudySessionCopyWithImpl(this._self, this._then);

  final StudySession _self;
  final $Res Function(StudySession) _then;

/// Create a copy of StudySession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? studySubjectId = freezed,Object? name = null,Object? timerMode = null,Object? status = null,Object? plannedDurationSeconds = freezed,Object? actualDurationSeconds = null,Object? startedAt = null,Object? endedAt = freezed,Object? pomodoroWorkMinutes = freezed,Object? pomodoroShortBreakMinutes = freezed,Object? pomodoroLongBreakMinutes = freezed,Object? pomodoroCycles = freezed,Object? pomodoroCompletedCycles = null,Object? subject = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,studySubjectId: freezed == studySubjectId ? _self.studySubjectId : studySubjectId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,timerMode: null == timerMode ? _self.timerMode : timerMode // ignore: cast_nullable_to_non_nullable
as TimerMode,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StudySessionStatus,plannedDurationSeconds: freezed == plannedDurationSeconds ? _self.plannedDurationSeconds : plannedDurationSeconds // ignore: cast_nullable_to_non_nullable
as int?,actualDurationSeconds: null == actualDurationSeconds ? _self.actualDurationSeconds : actualDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as String?,pomodoroWorkMinutes: freezed == pomodoroWorkMinutes ? _self.pomodoroWorkMinutes : pomodoroWorkMinutes // ignore: cast_nullable_to_non_nullable
as int?,pomodoroShortBreakMinutes: freezed == pomodoroShortBreakMinutes ? _self.pomodoroShortBreakMinutes : pomodoroShortBreakMinutes // ignore: cast_nullable_to_non_nullable
as int?,pomodoroLongBreakMinutes: freezed == pomodoroLongBreakMinutes ? _self.pomodoroLongBreakMinutes : pomodoroLongBreakMinutes // ignore: cast_nullable_to_non_nullable
as int?,pomodoroCycles: freezed == pomodoroCycles ? _self.pomodoroCycles : pomodoroCycles // ignore: cast_nullable_to_non_nullable
as int?,pomodoroCompletedCycles: null == pomodoroCompletedCycles ? _self.pomodoroCompletedCycles : pomodoroCompletedCycles // ignore: cast_nullable_to_non_nullable
as int,subject: freezed == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as StudySubject?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of StudySession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudySubjectCopyWith<$Res>? get subject {
    if (_self.subject == null) {
    return null;
  }

  return $StudySubjectCopyWith<$Res>(_self.subject!, (value) {
    return _then(_self.copyWith(subject: value));
  });
}
}


/// Adds pattern-matching-related methods to [StudySession].
extension StudySessionPatterns on StudySession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudySession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudySession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudySession value)  $default,){
final _that = this;
switch (_that) {
case _StudySession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudySession value)?  $default,){
final _that = this;
switch (_that) {
case _StudySession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'study_subject_id')  int? studySubjectId,  String name, @JsonKey(name: 'timer_mode')  TimerMode timerMode,  StudySessionStatus status, @JsonKey(name: 'planned_duration_seconds')  int? plannedDurationSeconds, @JsonKey(name: 'actual_duration_seconds')  int actualDurationSeconds, @JsonKey(name: 'started_at')  String startedAt, @JsonKey(name: 'ended_at')  String? endedAt, @JsonKey(name: 'pomodoro_work_minutes')  int? pomodoroWorkMinutes, @JsonKey(name: 'pomodoro_short_break_minutes')  int? pomodoroShortBreakMinutes, @JsonKey(name: 'pomodoro_long_break_minutes')  int? pomodoroLongBreakMinutes, @JsonKey(name: 'pomodoro_cycles')  int? pomodoroCycles, @JsonKey(name: 'pomodoro_completed_cycles')  int pomodoroCompletedCycles,  StudySubject? subject, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudySession() when $default != null:
return $default(_that.id,_that.userId,_that.studySubjectId,_that.name,_that.timerMode,_that.status,_that.plannedDurationSeconds,_that.actualDurationSeconds,_that.startedAt,_that.endedAt,_that.pomodoroWorkMinutes,_that.pomodoroShortBreakMinutes,_that.pomodoroLongBreakMinutes,_that.pomodoroCycles,_that.pomodoroCompletedCycles,_that.subject,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'study_subject_id')  int? studySubjectId,  String name, @JsonKey(name: 'timer_mode')  TimerMode timerMode,  StudySessionStatus status, @JsonKey(name: 'planned_duration_seconds')  int? plannedDurationSeconds, @JsonKey(name: 'actual_duration_seconds')  int actualDurationSeconds, @JsonKey(name: 'started_at')  String startedAt, @JsonKey(name: 'ended_at')  String? endedAt, @JsonKey(name: 'pomodoro_work_minutes')  int? pomodoroWorkMinutes, @JsonKey(name: 'pomodoro_short_break_minutes')  int? pomodoroShortBreakMinutes, @JsonKey(name: 'pomodoro_long_break_minutes')  int? pomodoroLongBreakMinutes, @JsonKey(name: 'pomodoro_cycles')  int? pomodoroCycles, @JsonKey(name: 'pomodoro_completed_cycles')  int pomodoroCompletedCycles,  StudySubject? subject, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _StudySession():
return $default(_that.id,_that.userId,_that.studySubjectId,_that.name,_that.timerMode,_that.status,_that.plannedDurationSeconds,_that.actualDurationSeconds,_that.startedAt,_that.endedAt,_that.pomodoroWorkMinutes,_that.pomodoroShortBreakMinutes,_that.pomodoroLongBreakMinutes,_that.pomodoroCycles,_that.pomodoroCompletedCycles,_that.subject,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'study_subject_id')  int? studySubjectId,  String name, @JsonKey(name: 'timer_mode')  TimerMode timerMode,  StudySessionStatus status, @JsonKey(name: 'planned_duration_seconds')  int? plannedDurationSeconds, @JsonKey(name: 'actual_duration_seconds')  int actualDurationSeconds, @JsonKey(name: 'started_at')  String startedAt, @JsonKey(name: 'ended_at')  String? endedAt, @JsonKey(name: 'pomodoro_work_minutes')  int? pomodoroWorkMinutes, @JsonKey(name: 'pomodoro_short_break_minutes')  int? pomodoroShortBreakMinutes, @JsonKey(name: 'pomodoro_long_break_minutes')  int? pomodoroLongBreakMinutes, @JsonKey(name: 'pomodoro_cycles')  int? pomodoroCycles, @JsonKey(name: 'pomodoro_completed_cycles')  int pomodoroCompletedCycles,  StudySubject? subject, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _StudySession() when $default != null:
return $default(_that.id,_that.userId,_that.studySubjectId,_that.name,_that.timerMode,_that.status,_that.plannedDurationSeconds,_that.actualDurationSeconds,_that.startedAt,_that.endedAt,_that.pomodoroWorkMinutes,_that.pomodoroShortBreakMinutes,_that.pomodoroLongBreakMinutes,_that.pomodoroCycles,_that.pomodoroCompletedCycles,_that.subject,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _StudySession implements StudySession {
  const _StudySession({required this.id, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'study_subject_id') this.studySubjectId, required this.name, @JsonKey(name: 'timer_mode') required this.timerMode, required this.status, @JsonKey(name: 'planned_duration_seconds') this.plannedDurationSeconds, @JsonKey(name: 'actual_duration_seconds') this.actualDurationSeconds = 0, @JsonKey(name: 'started_at') required this.startedAt, @JsonKey(name: 'ended_at') this.endedAt, @JsonKey(name: 'pomodoro_work_minutes') this.pomodoroWorkMinutes, @JsonKey(name: 'pomodoro_short_break_minutes') this.pomodoroShortBreakMinutes, @JsonKey(name: 'pomodoro_long_break_minutes') this.pomodoroLongBreakMinutes, @JsonKey(name: 'pomodoro_cycles') this.pomodoroCycles, @JsonKey(name: 'pomodoro_completed_cycles') this.pomodoroCompletedCycles = 0, this.subject, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _StudySession.fromJson(Map<String, dynamic> json) => _$StudySessionFromJson(json);

@override final  int id;
@override@JsonKey(name: 'user_id') final  int userId;
@override@JsonKey(name: 'study_subject_id') final  int? studySubjectId;
@override final  String name;
@override@JsonKey(name: 'timer_mode') final  TimerMode timerMode;
@override final  StudySessionStatus status;
@override@JsonKey(name: 'planned_duration_seconds') final  int? plannedDurationSeconds;
@override@JsonKey(name: 'actual_duration_seconds') final  int actualDurationSeconds;
@override@JsonKey(name: 'started_at') final  String startedAt;
@override@JsonKey(name: 'ended_at') final  String? endedAt;
@override@JsonKey(name: 'pomodoro_work_minutes') final  int? pomodoroWorkMinutes;
@override@JsonKey(name: 'pomodoro_short_break_minutes') final  int? pomodoroShortBreakMinutes;
@override@JsonKey(name: 'pomodoro_long_break_minutes') final  int? pomodoroLongBreakMinutes;
@override@JsonKey(name: 'pomodoro_cycles') final  int? pomodoroCycles;
@override@JsonKey(name: 'pomodoro_completed_cycles') final  int pomodoroCompletedCycles;
@override final  StudySubject? subject;
@override@JsonKey(name: 'created_at') final  String createdAt;
@override@JsonKey(name: 'updated_at') final  String updatedAt;

/// Create a copy of StudySession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudySessionCopyWith<_StudySession> get copyWith => __$StudySessionCopyWithImpl<_StudySession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudySessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudySession&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.studySubjectId, studySubjectId) || other.studySubjectId == studySubjectId)&&(identical(other.name, name) || other.name == name)&&(identical(other.timerMode, timerMode) || other.timerMode == timerMode)&&(identical(other.status, status) || other.status == status)&&(identical(other.plannedDurationSeconds, plannedDurationSeconds) || other.plannedDurationSeconds == plannedDurationSeconds)&&(identical(other.actualDurationSeconds, actualDurationSeconds) || other.actualDurationSeconds == actualDurationSeconds)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.pomodoroWorkMinutes, pomodoroWorkMinutes) || other.pomodoroWorkMinutes == pomodoroWorkMinutes)&&(identical(other.pomodoroShortBreakMinutes, pomodoroShortBreakMinutes) || other.pomodoroShortBreakMinutes == pomodoroShortBreakMinutes)&&(identical(other.pomodoroLongBreakMinutes, pomodoroLongBreakMinutes) || other.pomodoroLongBreakMinutes == pomodoroLongBreakMinutes)&&(identical(other.pomodoroCycles, pomodoroCycles) || other.pomodoroCycles == pomodoroCycles)&&(identical(other.pomodoroCompletedCycles, pomodoroCompletedCycles) || other.pomodoroCompletedCycles == pomodoroCompletedCycles)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,studySubjectId,name,timerMode,status,plannedDurationSeconds,actualDurationSeconds,startedAt,endedAt,pomodoroWorkMinutes,pomodoroShortBreakMinutes,pomodoroLongBreakMinutes,pomodoroCycles,pomodoroCompletedCycles,subject,createdAt,updatedAt);

@override
String toString() {
  return 'StudySession(id: $id, userId: $userId, studySubjectId: $studySubjectId, name: $name, timerMode: $timerMode, status: $status, plannedDurationSeconds: $plannedDurationSeconds, actualDurationSeconds: $actualDurationSeconds, startedAt: $startedAt, endedAt: $endedAt, pomodoroWorkMinutes: $pomodoroWorkMinutes, pomodoroShortBreakMinutes: $pomodoroShortBreakMinutes, pomodoroLongBreakMinutes: $pomodoroLongBreakMinutes, pomodoroCycles: $pomodoroCycles, pomodoroCompletedCycles: $pomodoroCompletedCycles, subject: $subject, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$StudySessionCopyWith<$Res> implements $StudySessionCopyWith<$Res> {
  factory _$StudySessionCopyWith(_StudySession value, $Res Function(_StudySession) _then) = __$StudySessionCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'user_id') int userId,@JsonKey(name: 'study_subject_id') int? studySubjectId, String name,@JsonKey(name: 'timer_mode') TimerMode timerMode, StudySessionStatus status,@JsonKey(name: 'planned_duration_seconds') int? plannedDurationSeconds,@JsonKey(name: 'actual_duration_seconds') int actualDurationSeconds,@JsonKey(name: 'started_at') String startedAt,@JsonKey(name: 'ended_at') String? endedAt,@JsonKey(name: 'pomodoro_work_minutes') int? pomodoroWorkMinutes,@JsonKey(name: 'pomodoro_short_break_minutes') int? pomodoroShortBreakMinutes,@JsonKey(name: 'pomodoro_long_break_minutes') int? pomodoroLongBreakMinutes,@JsonKey(name: 'pomodoro_cycles') int? pomodoroCycles,@JsonKey(name: 'pomodoro_completed_cycles') int pomodoroCompletedCycles, StudySubject? subject,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt
});


@override $StudySubjectCopyWith<$Res>? get subject;

}
/// @nodoc
class __$StudySessionCopyWithImpl<$Res>
    implements _$StudySessionCopyWith<$Res> {
  __$StudySessionCopyWithImpl(this._self, this._then);

  final _StudySession _self;
  final $Res Function(_StudySession) _then;

/// Create a copy of StudySession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? studySubjectId = freezed,Object? name = null,Object? timerMode = null,Object? status = null,Object? plannedDurationSeconds = freezed,Object? actualDurationSeconds = null,Object? startedAt = null,Object? endedAt = freezed,Object? pomodoroWorkMinutes = freezed,Object? pomodoroShortBreakMinutes = freezed,Object? pomodoroLongBreakMinutes = freezed,Object? pomodoroCycles = freezed,Object? pomodoroCompletedCycles = null,Object? subject = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_StudySession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,studySubjectId: freezed == studySubjectId ? _self.studySubjectId : studySubjectId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,timerMode: null == timerMode ? _self.timerMode : timerMode // ignore: cast_nullable_to_non_nullable
as TimerMode,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StudySessionStatus,plannedDurationSeconds: freezed == plannedDurationSeconds ? _self.plannedDurationSeconds : plannedDurationSeconds // ignore: cast_nullable_to_non_nullable
as int?,actualDurationSeconds: null == actualDurationSeconds ? _self.actualDurationSeconds : actualDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as String?,pomodoroWorkMinutes: freezed == pomodoroWorkMinutes ? _self.pomodoroWorkMinutes : pomodoroWorkMinutes // ignore: cast_nullable_to_non_nullable
as int?,pomodoroShortBreakMinutes: freezed == pomodoroShortBreakMinutes ? _self.pomodoroShortBreakMinutes : pomodoroShortBreakMinutes // ignore: cast_nullable_to_non_nullable
as int?,pomodoroLongBreakMinutes: freezed == pomodoroLongBreakMinutes ? _self.pomodoroLongBreakMinutes : pomodoroLongBreakMinutes // ignore: cast_nullable_to_non_nullable
as int?,pomodoroCycles: freezed == pomodoroCycles ? _self.pomodoroCycles : pomodoroCycles // ignore: cast_nullable_to_non_nullable
as int?,pomodoroCompletedCycles: null == pomodoroCompletedCycles ? _self.pomodoroCompletedCycles : pomodoroCompletedCycles // ignore: cast_nullable_to_non_nullable
as int,subject: freezed == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as StudySubject?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of StudySession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudySubjectCopyWith<$Res>? get subject {
    if (_self.subject == null) {
    return null;
  }

  return $StudySubjectCopyWith<$Res>(_self.subject!, (value) {
    return _then(_self.copyWith(subject: value));
  });
}
}

// dart format on
