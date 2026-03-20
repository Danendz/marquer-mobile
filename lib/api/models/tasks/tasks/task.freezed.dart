// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Task {

 int get id; String get name; TaskStatus get status; String? get date;@JsonKey(name: 'start_time') String? get startTime;@JsonKey(name: 'end_time') String? get endTime;@JsonKey(name: 'task_category_id') int? get taskCategoryId; String? get color;@JsonKey(name: 'created_at') String get createdAt;@JsonKey(name: 'updated_at') String get updatedAt;
/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskCopyWith<Task> get copyWith => _$TaskCopyWithImpl<Task>(this as Task, _$identity);

  /// Serializes this Task to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Task&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.date, date) || other.date == date)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.taskCategoryId, taskCategoryId) || other.taskCategoryId == taskCategoryId)&&(identical(other.color, color) || other.color == color)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,status,date,startTime,endTime,taskCategoryId,color,createdAt,updatedAt);

@override
String toString() {
  return 'Task(id: $id, name: $name, status: $status, date: $date, startTime: $startTime, endTime: $endTime, taskCategoryId: $taskCategoryId, color: $color, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TaskCopyWith<$Res>  {
  factory $TaskCopyWith(Task value, $Res Function(Task) _then) = _$TaskCopyWithImpl;
@useResult
$Res call({
 int id, String name, TaskStatus status, String? date,@JsonKey(name: 'start_time') String? startTime,@JsonKey(name: 'end_time') String? endTime,@JsonKey(name: 'task_category_id') int? taskCategoryId, String? color,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt
});




}
/// @nodoc
class _$TaskCopyWithImpl<$Res>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._self, this._then);

  final Task _self;
  final $Res Function(Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? status = null,Object? date = freezed,Object? startTime = freezed,Object? endTime = freezed,Object? taskCategoryId = freezed,Object? color = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,taskCategoryId: freezed == taskCategoryId ? _self.taskCategoryId : taskCategoryId // ignore: cast_nullable_to_non_nullable
as int?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Task].
extension TaskPatterns on Task {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Task value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Task() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Task value)  $default,){
final _that = this;
switch (_that) {
case _Task():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Task value)?  $default,){
final _that = this;
switch (_that) {
case _Task() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  TaskStatus status,  String? date, @JsonKey(name: 'start_time')  String? startTime, @JsonKey(name: 'end_time')  String? endTime, @JsonKey(name: 'task_category_id')  int? taskCategoryId,  String? color, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.id,_that.name,_that.status,_that.date,_that.startTime,_that.endTime,_that.taskCategoryId,_that.color,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  TaskStatus status,  String? date, @JsonKey(name: 'start_time')  String? startTime, @JsonKey(name: 'end_time')  String? endTime, @JsonKey(name: 'task_category_id')  int? taskCategoryId,  String? color, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Task():
return $default(_that.id,_that.name,_that.status,_that.date,_that.startTime,_that.endTime,_that.taskCategoryId,_that.color,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  TaskStatus status,  String? date, @JsonKey(name: 'start_time')  String? startTime, @JsonKey(name: 'end_time')  String? endTime, @JsonKey(name: 'task_category_id')  int? taskCategoryId,  String? color, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.id,_that.name,_that.status,_that.date,_that.startTime,_that.endTime,_that.taskCategoryId,_that.color,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Task implements Task {
  const _Task({required this.id, required this.name, required this.status, this.date, @JsonKey(name: 'start_time') this.startTime, @JsonKey(name: 'end_time') this.endTime, @JsonKey(name: 'task_category_id') this.taskCategoryId, this.color, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

@override final  int id;
@override final  String name;
@override final  TaskStatus status;
@override final  String? date;
@override@JsonKey(name: 'start_time') final  String? startTime;
@override@JsonKey(name: 'end_time') final  String? endTime;
@override@JsonKey(name: 'task_category_id') final  int? taskCategoryId;
@override final  String? color;
@override@JsonKey(name: 'created_at') final  String createdAt;
@override@JsonKey(name: 'updated_at') final  String updatedAt;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskCopyWith<_Task> get copyWith => __$TaskCopyWithImpl<_Task>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Task&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.date, date) || other.date == date)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.taskCategoryId, taskCategoryId) || other.taskCategoryId == taskCategoryId)&&(identical(other.color, color) || other.color == color)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,status,date,startTime,endTime,taskCategoryId,color,createdAt,updatedAt);

@override
String toString() {
  return 'Task(id: $id, name: $name, status: $status, date: $date, startTime: $startTime, endTime: $endTime, taskCategoryId: $taskCategoryId, color: $color, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$TaskCopyWith(_Task value, $Res Function(_Task) _then) = __$TaskCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, TaskStatus status, String? date,@JsonKey(name: 'start_time') String? startTime,@JsonKey(name: 'end_time') String? endTime,@JsonKey(name: 'task_category_id') int? taskCategoryId, String? color,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt
});




}
/// @nodoc
class __$TaskCopyWithImpl<$Res>
    implements _$TaskCopyWith<$Res> {
  __$TaskCopyWithImpl(this._self, this._then);

  final _Task _self;
  final $Res Function(_Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? status = null,Object? date = freezed,Object? startTime = freezed,Object? endTime = freezed,Object? taskCategoryId = freezed,Object? color = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Task(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,taskCategoryId: freezed == taskCategoryId ? _self.taskCategoryId : taskCategoryId // ignore: cast_nullable_to_non_nullable
as int?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
