// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Plan {

 int get id; String get name;@JsonKey(fromJson: PlanSchedule.fromJson, toJson: _scheduleToJson) PlanSchedule get schedule;@JsonKey(name: 'start_date') String get startDate;@JsonKey(name: 'end_date') String? get endDate;@JsonKey(name: 'is_active') bool get isActive; String? get color; List<PlanTask> get tasks;@JsonKey(name: 'created_at') String get createdAt;@JsonKey(name: 'updated_at') String get updatedAt;
/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanCopyWith<Plan> get copyWith => _$PlanCopyWithImpl<Plan>(this as Plan, _$identity);

  /// Serializes this Plan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Plan&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.schedule, schedule) || other.schedule == schedule)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.color, color) || other.color == color)&&const DeepCollectionEquality().equals(other.tasks, tasks)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,schedule,startDate,endDate,isActive,color,const DeepCollectionEquality().hash(tasks),createdAt,updatedAt);

@override
String toString() {
  return 'Plan(id: $id, name: $name, schedule: $schedule, startDate: $startDate, endDate: $endDate, isActive: $isActive, color: $color, tasks: $tasks, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PlanCopyWith<$Res>  {
  factory $PlanCopyWith(Plan value, $Res Function(Plan) _then) = _$PlanCopyWithImpl;
@useResult
$Res call({
 int id, String name,@JsonKey(fromJson: PlanSchedule.fromJson, toJson: _scheduleToJson) PlanSchedule schedule,@JsonKey(name: 'start_date') String startDate,@JsonKey(name: 'end_date') String? endDate,@JsonKey(name: 'is_active') bool isActive, String? color, List<PlanTask> tasks,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt
});




}
/// @nodoc
class _$PlanCopyWithImpl<$Res>
    implements $PlanCopyWith<$Res> {
  _$PlanCopyWithImpl(this._self, this._then);

  final Plan _self;
  final $Res Function(Plan) _then;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? schedule = null,Object? startDate = null,Object? endDate = freezed,Object? isActive = null,Object? color = freezed,Object? tasks = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,schedule: null == schedule ? _self.schedule : schedule // ignore: cast_nullable_to_non_nullable
as PlanSchedule,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<PlanTask>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Plan].
extension PlanPatterns on Plan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Plan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Plan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Plan value)  $default,){
final _that = this;
switch (_that) {
case _Plan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Plan value)?  $default,){
final _that = this;
switch (_that) {
case _Plan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(fromJson: PlanSchedule.fromJson, toJson: _scheduleToJson)  PlanSchedule schedule, @JsonKey(name: 'start_date')  String startDate, @JsonKey(name: 'end_date')  String? endDate, @JsonKey(name: 'is_active')  bool isActive,  String? color,  List<PlanTask> tasks, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Plan() when $default != null:
return $default(_that.id,_that.name,_that.schedule,_that.startDate,_that.endDate,_that.isActive,_that.color,_that.tasks,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(fromJson: PlanSchedule.fromJson, toJson: _scheduleToJson)  PlanSchedule schedule, @JsonKey(name: 'start_date')  String startDate, @JsonKey(name: 'end_date')  String? endDate, @JsonKey(name: 'is_active')  bool isActive,  String? color,  List<PlanTask> tasks, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Plan():
return $default(_that.id,_that.name,_that.schedule,_that.startDate,_that.endDate,_that.isActive,_that.color,_that.tasks,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name, @JsonKey(fromJson: PlanSchedule.fromJson, toJson: _scheduleToJson)  PlanSchedule schedule, @JsonKey(name: 'start_date')  String startDate, @JsonKey(name: 'end_date')  String? endDate, @JsonKey(name: 'is_active')  bool isActive,  String? color,  List<PlanTask> tasks, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Plan() when $default != null:
return $default(_that.id,_that.name,_that.schedule,_that.startDate,_that.endDate,_that.isActive,_that.color,_that.tasks,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _Plan implements Plan {
  const _Plan({required this.id, required this.name, @JsonKey(fromJson: PlanSchedule.fromJson, toJson: _scheduleToJson) required this.schedule, @JsonKey(name: 'start_date') required this.startDate, @JsonKey(name: 'end_date') this.endDate, @JsonKey(name: 'is_active') required this.isActive, this.color, required final  List<PlanTask> tasks, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt}): _tasks = tasks;
  factory _Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

@override final  int id;
@override final  String name;
@override@JsonKey(fromJson: PlanSchedule.fromJson, toJson: _scheduleToJson) final  PlanSchedule schedule;
@override@JsonKey(name: 'start_date') final  String startDate;
@override@JsonKey(name: 'end_date') final  String? endDate;
@override@JsonKey(name: 'is_active') final  bool isActive;
@override final  String? color;
 final  List<PlanTask> _tasks;
@override List<PlanTask> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}

@override@JsonKey(name: 'created_at') final  String createdAt;
@override@JsonKey(name: 'updated_at') final  String updatedAt;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanCopyWith<_Plan> get copyWith => __$PlanCopyWithImpl<_Plan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Plan&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.schedule, schedule) || other.schedule == schedule)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.color, color) || other.color == color)&&const DeepCollectionEquality().equals(other._tasks, _tasks)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,schedule,startDate,endDate,isActive,color,const DeepCollectionEquality().hash(_tasks),createdAt,updatedAt);

@override
String toString() {
  return 'Plan(id: $id, name: $name, schedule: $schedule, startDate: $startDate, endDate: $endDate, isActive: $isActive, color: $color, tasks: $tasks, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PlanCopyWith<$Res> implements $PlanCopyWith<$Res> {
  factory _$PlanCopyWith(_Plan value, $Res Function(_Plan) _then) = __$PlanCopyWithImpl;
@override @useResult
$Res call({
 int id, String name,@JsonKey(fromJson: PlanSchedule.fromJson, toJson: _scheduleToJson) PlanSchedule schedule,@JsonKey(name: 'start_date') String startDate,@JsonKey(name: 'end_date') String? endDate,@JsonKey(name: 'is_active') bool isActive, String? color, List<PlanTask> tasks,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt
});




}
/// @nodoc
class __$PlanCopyWithImpl<$Res>
    implements _$PlanCopyWith<$Res> {
  __$PlanCopyWithImpl(this._self, this._then);

  final _Plan _self;
  final $Res Function(_Plan) _then;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? schedule = null,Object? startDate = null,Object? endDate = freezed,Object? isActive = null,Object? color = freezed,Object? tasks = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Plan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,schedule: null == schedule ? _self.schedule : schedule // ignore: cast_nullable_to_non_nullable
as PlanSchedule,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<PlanTask>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
