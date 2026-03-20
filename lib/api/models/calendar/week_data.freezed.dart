// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'week_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeekPlanTask {

 int get id; String get name;@JsonKey(name: 'sort_order') int get sortOrder;@JsonKey(name: 'start_time') String? get startTime;@JsonKey(name: 'end_time') String? get endTime;@JsonKey(name: 'is_completed') bool get isCompleted;@JsonKey(name: 'plan_id') int get planId;@JsonKey(name: 'plan_name') String get planName;@JsonKey(name: 'plan_color') String? get planColor;
/// Create a copy of WeekPlanTask
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeekPlanTaskCopyWith<WeekPlanTask> get copyWith => _$WeekPlanTaskCopyWithImpl<WeekPlanTask>(this as WeekPlanTask, _$identity);

  /// Serializes this WeekPlanTask to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeekPlanTask&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.planColor, planColor) || other.planColor == planColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,sortOrder,startTime,endTime,isCompleted,planId,planName,planColor);

@override
String toString() {
  return 'WeekPlanTask(id: $id, name: $name, sortOrder: $sortOrder, startTime: $startTime, endTime: $endTime, isCompleted: $isCompleted, planId: $planId, planName: $planName, planColor: $planColor)';
}


}

/// @nodoc
abstract mixin class $WeekPlanTaskCopyWith<$Res>  {
  factory $WeekPlanTaskCopyWith(WeekPlanTask value, $Res Function(WeekPlanTask) _then) = _$WeekPlanTaskCopyWithImpl;
@useResult
$Res call({
 int id, String name,@JsonKey(name: 'sort_order') int sortOrder,@JsonKey(name: 'start_time') String? startTime,@JsonKey(name: 'end_time') String? endTime,@JsonKey(name: 'is_completed') bool isCompleted,@JsonKey(name: 'plan_id') int planId,@JsonKey(name: 'plan_name') String planName,@JsonKey(name: 'plan_color') String? planColor
});




}
/// @nodoc
class _$WeekPlanTaskCopyWithImpl<$Res>
    implements $WeekPlanTaskCopyWith<$Res> {
  _$WeekPlanTaskCopyWithImpl(this._self, this._then);

  final WeekPlanTask _self;
  final $Res Function(WeekPlanTask) _then;

/// Create a copy of WeekPlanTask
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? sortOrder = null,Object? startTime = freezed,Object? endTime = freezed,Object? isCompleted = null,Object? planId = null,Object? planName = null,Object? planColor = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,planColor: freezed == planColor ? _self.planColor : planColor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WeekPlanTask].
extension WeekPlanTaskPatterns on WeekPlanTask {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeekPlanTask value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeekPlanTask() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeekPlanTask value)  $default,){
final _that = this;
switch (_that) {
case _WeekPlanTask():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeekPlanTask value)?  $default,){
final _that = this;
switch (_that) {
case _WeekPlanTask() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'start_time')  String? startTime, @JsonKey(name: 'end_time')  String? endTime, @JsonKey(name: 'is_completed')  bool isCompleted, @JsonKey(name: 'plan_id')  int planId, @JsonKey(name: 'plan_name')  String planName, @JsonKey(name: 'plan_color')  String? planColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeekPlanTask() when $default != null:
return $default(_that.id,_that.name,_that.sortOrder,_that.startTime,_that.endTime,_that.isCompleted,_that.planId,_that.planName,_that.planColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'start_time')  String? startTime, @JsonKey(name: 'end_time')  String? endTime, @JsonKey(name: 'is_completed')  bool isCompleted, @JsonKey(name: 'plan_id')  int planId, @JsonKey(name: 'plan_name')  String planName, @JsonKey(name: 'plan_color')  String? planColor)  $default,) {final _that = this;
switch (_that) {
case _WeekPlanTask():
return $default(_that.id,_that.name,_that.sortOrder,_that.startTime,_that.endTime,_that.isCompleted,_that.planId,_that.planName,_that.planColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'start_time')  String? startTime, @JsonKey(name: 'end_time')  String? endTime, @JsonKey(name: 'is_completed')  bool isCompleted, @JsonKey(name: 'plan_id')  int planId, @JsonKey(name: 'plan_name')  String planName, @JsonKey(name: 'plan_color')  String? planColor)?  $default,) {final _that = this;
switch (_that) {
case _WeekPlanTask() when $default != null:
return $default(_that.id,_that.name,_that.sortOrder,_that.startTime,_that.endTime,_that.isCompleted,_that.planId,_that.planName,_that.planColor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeekPlanTask implements WeekPlanTask {
  const _WeekPlanTask({required this.id, required this.name, @JsonKey(name: 'sort_order') required this.sortOrder, @JsonKey(name: 'start_time') this.startTime, @JsonKey(name: 'end_time') this.endTime, @JsonKey(name: 'is_completed') required this.isCompleted, @JsonKey(name: 'plan_id') required this.planId, @JsonKey(name: 'plan_name') required this.planName, @JsonKey(name: 'plan_color') this.planColor});
  factory _WeekPlanTask.fromJson(Map<String, dynamic> json) => _$WeekPlanTaskFromJson(json);

@override final  int id;
@override final  String name;
@override@JsonKey(name: 'sort_order') final  int sortOrder;
@override@JsonKey(name: 'start_time') final  String? startTime;
@override@JsonKey(name: 'end_time') final  String? endTime;
@override@JsonKey(name: 'is_completed') final  bool isCompleted;
@override@JsonKey(name: 'plan_id') final  int planId;
@override@JsonKey(name: 'plan_name') final  String planName;
@override@JsonKey(name: 'plan_color') final  String? planColor;

/// Create a copy of WeekPlanTask
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeekPlanTaskCopyWith<_WeekPlanTask> get copyWith => __$WeekPlanTaskCopyWithImpl<_WeekPlanTask>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeekPlanTaskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeekPlanTask&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.planColor, planColor) || other.planColor == planColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,sortOrder,startTime,endTime,isCompleted,planId,planName,planColor);

@override
String toString() {
  return 'WeekPlanTask(id: $id, name: $name, sortOrder: $sortOrder, startTime: $startTime, endTime: $endTime, isCompleted: $isCompleted, planId: $planId, planName: $planName, planColor: $planColor)';
}


}

/// @nodoc
abstract mixin class _$WeekPlanTaskCopyWith<$Res> implements $WeekPlanTaskCopyWith<$Res> {
  factory _$WeekPlanTaskCopyWith(_WeekPlanTask value, $Res Function(_WeekPlanTask) _then) = __$WeekPlanTaskCopyWithImpl;
@override @useResult
$Res call({
 int id, String name,@JsonKey(name: 'sort_order') int sortOrder,@JsonKey(name: 'start_time') String? startTime,@JsonKey(name: 'end_time') String? endTime,@JsonKey(name: 'is_completed') bool isCompleted,@JsonKey(name: 'plan_id') int planId,@JsonKey(name: 'plan_name') String planName,@JsonKey(name: 'plan_color') String? planColor
});




}
/// @nodoc
class __$WeekPlanTaskCopyWithImpl<$Res>
    implements _$WeekPlanTaskCopyWith<$Res> {
  __$WeekPlanTaskCopyWithImpl(this._self, this._then);

  final _WeekPlanTask _self;
  final $Res Function(_WeekPlanTask) _then;

/// Create a copy of WeekPlanTask
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? sortOrder = null,Object? startTime = freezed,Object? endTime = freezed,Object? isCompleted = null,Object? planId = null,Object? planName = null,Object? planColor = freezed,}) {
  return _then(_WeekPlanTask(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,planColor: freezed == planColor ? _self.planColor : planColor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$WeekData {

 Map<String, List<Task>> get tasks;@JsonKey(name: 'plan_tasks') Map<String, List<WeekPlanTask>> get planTasks; Map<String, List<Countdown>> get countdowns;
/// Create a copy of WeekData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeekDataCopyWith<WeekData> get copyWith => _$WeekDataCopyWithImpl<WeekData>(this as WeekData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeekData&&const DeepCollectionEquality().equals(other.tasks, tasks)&&const DeepCollectionEquality().equals(other.planTasks, planTasks)&&const DeepCollectionEquality().equals(other.countdowns, countdowns));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(tasks),const DeepCollectionEquality().hash(planTasks),const DeepCollectionEquality().hash(countdowns));

@override
String toString() {
  return 'WeekData(tasks: $tasks, planTasks: $planTasks, countdowns: $countdowns)';
}


}

/// @nodoc
abstract mixin class $WeekDataCopyWith<$Res>  {
  factory $WeekDataCopyWith(WeekData value, $Res Function(WeekData) _then) = _$WeekDataCopyWithImpl;
@useResult
$Res call({
 Map<String, List<Task>> tasks,@JsonKey(name: 'plan_tasks') Map<String, List<WeekPlanTask>> planTasks, Map<String, List<Countdown>> countdowns
});




}
/// @nodoc
class _$WeekDataCopyWithImpl<$Res>
    implements $WeekDataCopyWith<$Res> {
  _$WeekDataCopyWithImpl(this._self, this._then);

  final WeekData _self;
  final $Res Function(WeekData) _then;

/// Create a copy of WeekData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tasks = null,Object? planTasks = null,Object? countdowns = null,}) {
  return _then(_self.copyWith(
tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as Map<String, List<Task>>,planTasks: null == planTasks ? _self.planTasks : planTasks // ignore: cast_nullable_to_non_nullable
as Map<String, List<WeekPlanTask>>,countdowns: null == countdowns ? _self.countdowns : countdowns // ignore: cast_nullable_to_non_nullable
as Map<String, List<Countdown>>,
  ));
}

}


/// Adds pattern-matching-related methods to [WeekData].
extension WeekDataPatterns on WeekData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeekData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeekData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeekData value)  $default,){
final _that = this;
switch (_that) {
case _WeekData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeekData value)?  $default,){
final _that = this;
switch (_that) {
case _WeekData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, List<Task>> tasks, @JsonKey(name: 'plan_tasks')  Map<String, List<WeekPlanTask>> planTasks,  Map<String, List<Countdown>> countdowns)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeekData() when $default != null:
return $default(_that.tasks,_that.planTasks,_that.countdowns);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, List<Task>> tasks, @JsonKey(name: 'plan_tasks')  Map<String, List<WeekPlanTask>> planTasks,  Map<String, List<Countdown>> countdowns)  $default,) {final _that = this;
switch (_that) {
case _WeekData():
return $default(_that.tasks,_that.planTasks,_that.countdowns);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, List<Task>> tasks, @JsonKey(name: 'plan_tasks')  Map<String, List<WeekPlanTask>> planTasks,  Map<String, List<Countdown>> countdowns)?  $default,) {final _that = this;
switch (_that) {
case _WeekData() when $default != null:
return $default(_that.tasks,_that.planTasks,_that.countdowns);case _:
  return null;

}
}

}

/// @nodoc


class _WeekData implements WeekData {
  const _WeekData({required final  Map<String, List<Task>> tasks, @JsonKey(name: 'plan_tasks') required final  Map<String, List<WeekPlanTask>> planTasks, required final  Map<String, List<Countdown>> countdowns}): _tasks = tasks,_planTasks = planTasks,_countdowns = countdowns;
  

 final  Map<String, List<Task>> _tasks;
@override Map<String, List<Task>> get tasks {
  if (_tasks is EqualUnmodifiableMapView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_tasks);
}

 final  Map<String, List<WeekPlanTask>> _planTasks;
@override@JsonKey(name: 'plan_tasks') Map<String, List<WeekPlanTask>> get planTasks {
  if (_planTasks is EqualUnmodifiableMapView) return _planTasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_planTasks);
}

 final  Map<String, List<Countdown>> _countdowns;
@override Map<String, List<Countdown>> get countdowns {
  if (_countdowns is EqualUnmodifiableMapView) return _countdowns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_countdowns);
}


/// Create a copy of WeekData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeekDataCopyWith<_WeekData> get copyWith => __$WeekDataCopyWithImpl<_WeekData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeekData&&const DeepCollectionEquality().equals(other._tasks, _tasks)&&const DeepCollectionEquality().equals(other._planTasks, _planTasks)&&const DeepCollectionEquality().equals(other._countdowns, _countdowns));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tasks),const DeepCollectionEquality().hash(_planTasks),const DeepCollectionEquality().hash(_countdowns));

@override
String toString() {
  return 'WeekData(tasks: $tasks, planTasks: $planTasks, countdowns: $countdowns)';
}


}

/// @nodoc
abstract mixin class _$WeekDataCopyWith<$Res> implements $WeekDataCopyWith<$Res> {
  factory _$WeekDataCopyWith(_WeekData value, $Res Function(_WeekData) _then) = __$WeekDataCopyWithImpl;
@override @useResult
$Res call({
 Map<String, List<Task>> tasks,@JsonKey(name: 'plan_tasks') Map<String, List<WeekPlanTask>> planTasks, Map<String, List<Countdown>> countdowns
});




}
/// @nodoc
class __$WeekDataCopyWithImpl<$Res>
    implements _$WeekDataCopyWith<$Res> {
  __$WeekDataCopyWithImpl(this._self, this._then);

  final _WeekData _self;
  final $Res Function(_WeekData) _then;

/// Create a copy of WeekData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tasks = null,Object? planTasks = null,Object? countdowns = null,}) {
  return _then(_WeekData(
tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as Map<String, List<Task>>,planTasks: null == planTasks ? _self._planTasks : planTasks // ignore: cast_nullable_to_non_nullable
as Map<String, List<WeekPlanTask>>,countdowns: null == countdowns ? _self._countdowns : countdowns // ignore: cast_nullable_to_non_nullable
as Map<String, List<Countdown>>,
  ));
}


}

// dart format on
