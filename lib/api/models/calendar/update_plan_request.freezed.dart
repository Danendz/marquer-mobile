// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_plan_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdatePlanTaskRequest {

 int? get id; String get name;@JsonKey(name: 'sort_order') int get sortOrder;@JsonKey(name: 'start_time') String? get startTime;@JsonKey(name: 'end_time') String? get endTime;
/// Create a copy of UpdatePlanTaskRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdatePlanTaskRequestCopyWith<UpdatePlanTaskRequest> get copyWith => _$UpdatePlanTaskRequestCopyWithImpl<UpdatePlanTaskRequest>(this as UpdatePlanTaskRequest, _$identity);

  /// Serializes this UpdatePlanTaskRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdatePlanTaskRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,sortOrder,startTime,endTime);

@override
String toString() {
  return 'UpdatePlanTaskRequest(id: $id, name: $name, sortOrder: $sortOrder, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class $UpdatePlanTaskRequestCopyWith<$Res>  {
  factory $UpdatePlanTaskRequestCopyWith(UpdatePlanTaskRequest value, $Res Function(UpdatePlanTaskRequest) _then) = _$UpdatePlanTaskRequestCopyWithImpl;
@useResult
$Res call({
 int? id, String name,@JsonKey(name: 'sort_order') int sortOrder,@JsonKey(name: 'start_time') String? startTime,@JsonKey(name: 'end_time') String? endTime
});




}
/// @nodoc
class _$UpdatePlanTaskRequestCopyWithImpl<$Res>
    implements $UpdatePlanTaskRequestCopyWith<$Res> {
  _$UpdatePlanTaskRequestCopyWithImpl(this._self, this._then);

  final UpdatePlanTaskRequest _self;
  final $Res Function(UpdatePlanTaskRequest) _then;

/// Create a copy of UpdatePlanTaskRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? sortOrder = null,Object? startTime = freezed,Object? endTime = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdatePlanTaskRequest].
extension UpdatePlanTaskRequestPatterns on UpdatePlanTaskRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdatePlanTaskRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdatePlanTaskRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdatePlanTaskRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdatePlanTaskRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdatePlanTaskRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdatePlanTaskRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String name, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'start_time')  String? startTime, @JsonKey(name: 'end_time')  String? endTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdatePlanTaskRequest() when $default != null:
return $default(_that.id,_that.name,_that.sortOrder,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String name, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'start_time')  String? startTime, @JsonKey(name: 'end_time')  String? endTime)  $default,) {final _that = this;
switch (_that) {
case _UpdatePlanTaskRequest():
return $default(_that.id,_that.name,_that.sortOrder,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String name, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'start_time')  String? startTime, @JsonKey(name: 'end_time')  String? endTime)?  $default,) {final _that = this;
switch (_that) {
case _UpdatePlanTaskRequest() when $default != null:
return $default(_that.id,_that.name,_that.sortOrder,_that.startTime,_that.endTime);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _UpdatePlanTaskRequest implements UpdatePlanTaskRequest {
  const _UpdatePlanTaskRequest({this.id, required this.name, @JsonKey(name: 'sort_order') required this.sortOrder, @JsonKey(name: 'start_time') this.startTime, @JsonKey(name: 'end_time') this.endTime});
  factory _UpdatePlanTaskRequest.fromJson(Map<String, dynamic> json) => _$UpdatePlanTaskRequestFromJson(json);

@override final  int? id;
@override final  String name;
@override@JsonKey(name: 'sort_order') final  int sortOrder;
@override@JsonKey(name: 'start_time') final  String? startTime;
@override@JsonKey(name: 'end_time') final  String? endTime;

/// Create a copy of UpdatePlanTaskRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdatePlanTaskRequestCopyWith<_UpdatePlanTaskRequest> get copyWith => __$UpdatePlanTaskRequestCopyWithImpl<_UpdatePlanTaskRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdatePlanTaskRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdatePlanTaskRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,sortOrder,startTime,endTime);

@override
String toString() {
  return 'UpdatePlanTaskRequest(id: $id, name: $name, sortOrder: $sortOrder, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class _$UpdatePlanTaskRequestCopyWith<$Res> implements $UpdatePlanTaskRequestCopyWith<$Res> {
  factory _$UpdatePlanTaskRequestCopyWith(_UpdatePlanTaskRequest value, $Res Function(_UpdatePlanTaskRequest) _then) = __$UpdatePlanTaskRequestCopyWithImpl;
@override @useResult
$Res call({
 int? id, String name,@JsonKey(name: 'sort_order') int sortOrder,@JsonKey(name: 'start_time') String? startTime,@JsonKey(name: 'end_time') String? endTime
});




}
/// @nodoc
class __$UpdatePlanTaskRequestCopyWithImpl<$Res>
    implements _$UpdatePlanTaskRequestCopyWith<$Res> {
  __$UpdatePlanTaskRequestCopyWithImpl(this._self, this._then);

  final _UpdatePlanTaskRequest _self;
  final $Res Function(_UpdatePlanTaskRequest) _then;

/// Create a copy of UpdatePlanTaskRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? sortOrder = null,Object? startTime = freezed,Object? endTime = freezed,}) {
  return _then(_UpdatePlanTaskRequest(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UpdatePlanRequest {

 String get name;@JsonKey(toJson: _scheduleToJson, fromJson: PlanSchedule.fromJson) PlanSchedule get schedule;@JsonKey(name: 'start_date') String get startDate;@JsonKey(name: 'end_date') String? get endDate;@JsonKey(name: 'is_active') bool? get isActive; String? get color; List<UpdatePlanTaskRequest> get tasks;
/// Create a copy of UpdatePlanRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdatePlanRequestCopyWith<UpdatePlanRequest> get copyWith => _$UpdatePlanRequestCopyWithImpl<UpdatePlanRequest>(this as UpdatePlanRequest, _$identity);

  /// Serializes this UpdatePlanRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdatePlanRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.schedule, schedule) || other.schedule == schedule)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.color, color) || other.color == color)&&const DeepCollectionEquality().equals(other.tasks, tasks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,schedule,startDate,endDate,isActive,color,const DeepCollectionEquality().hash(tasks));

@override
String toString() {
  return 'UpdatePlanRequest(name: $name, schedule: $schedule, startDate: $startDate, endDate: $endDate, isActive: $isActive, color: $color, tasks: $tasks)';
}


}

/// @nodoc
abstract mixin class $UpdatePlanRequestCopyWith<$Res>  {
  factory $UpdatePlanRequestCopyWith(UpdatePlanRequest value, $Res Function(UpdatePlanRequest) _then) = _$UpdatePlanRequestCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(toJson: _scheduleToJson, fromJson: PlanSchedule.fromJson) PlanSchedule schedule,@JsonKey(name: 'start_date') String startDate,@JsonKey(name: 'end_date') String? endDate,@JsonKey(name: 'is_active') bool? isActive, String? color, List<UpdatePlanTaskRequest> tasks
});




}
/// @nodoc
class _$UpdatePlanRequestCopyWithImpl<$Res>
    implements $UpdatePlanRequestCopyWith<$Res> {
  _$UpdatePlanRequestCopyWithImpl(this._self, this._then);

  final UpdatePlanRequest _self;
  final $Res Function(UpdatePlanRequest) _then;

/// Create a copy of UpdatePlanRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? schedule = null,Object? startDate = null,Object? endDate = freezed,Object? isActive = freezed,Object? color = freezed,Object? tasks = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,schedule: null == schedule ? _self.schedule : schedule // ignore: cast_nullable_to_non_nullable
as PlanSchedule,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<UpdatePlanTaskRequest>,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdatePlanRequest].
extension UpdatePlanRequestPatterns on UpdatePlanRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdatePlanRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdatePlanRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdatePlanRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdatePlanRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdatePlanRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdatePlanRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(toJson: _scheduleToJson, fromJson: PlanSchedule.fromJson)  PlanSchedule schedule, @JsonKey(name: 'start_date')  String startDate, @JsonKey(name: 'end_date')  String? endDate, @JsonKey(name: 'is_active')  bool? isActive,  String? color,  List<UpdatePlanTaskRequest> tasks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdatePlanRequest() when $default != null:
return $default(_that.name,_that.schedule,_that.startDate,_that.endDate,_that.isActive,_that.color,_that.tasks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(toJson: _scheduleToJson, fromJson: PlanSchedule.fromJson)  PlanSchedule schedule, @JsonKey(name: 'start_date')  String startDate, @JsonKey(name: 'end_date')  String? endDate, @JsonKey(name: 'is_active')  bool? isActive,  String? color,  List<UpdatePlanTaskRequest> tasks)  $default,) {final _that = this;
switch (_that) {
case _UpdatePlanRequest():
return $default(_that.name,_that.schedule,_that.startDate,_that.endDate,_that.isActive,_that.color,_that.tasks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(toJson: _scheduleToJson, fromJson: PlanSchedule.fromJson)  PlanSchedule schedule, @JsonKey(name: 'start_date')  String startDate, @JsonKey(name: 'end_date')  String? endDate, @JsonKey(name: 'is_active')  bool? isActive,  String? color,  List<UpdatePlanTaskRequest> tasks)?  $default,) {final _that = this;
switch (_that) {
case _UpdatePlanRequest() when $default != null:
return $default(_that.name,_that.schedule,_that.startDate,_that.endDate,_that.isActive,_that.color,_that.tasks);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class _UpdatePlanRequest implements UpdatePlanRequest {
  const _UpdatePlanRequest({required this.name, @JsonKey(toJson: _scheduleToJson, fromJson: PlanSchedule.fromJson) required this.schedule, @JsonKey(name: 'start_date') required this.startDate, @JsonKey(name: 'end_date') this.endDate, @JsonKey(name: 'is_active') this.isActive, this.color, required final  List<UpdatePlanTaskRequest> tasks}): _tasks = tasks;
  factory _UpdatePlanRequest.fromJson(Map<String, dynamic> json) => _$UpdatePlanRequestFromJson(json);

@override final  String name;
@override@JsonKey(toJson: _scheduleToJson, fromJson: PlanSchedule.fromJson) final  PlanSchedule schedule;
@override@JsonKey(name: 'start_date') final  String startDate;
@override@JsonKey(name: 'end_date') final  String? endDate;
@override@JsonKey(name: 'is_active') final  bool? isActive;
@override final  String? color;
 final  List<UpdatePlanTaskRequest> _tasks;
@override List<UpdatePlanTaskRequest> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}


/// Create a copy of UpdatePlanRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdatePlanRequestCopyWith<_UpdatePlanRequest> get copyWith => __$UpdatePlanRequestCopyWithImpl<_UpdatePlanRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdatePlanRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdatePlanRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.schedule, schedule) || other.schedule == schedule)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.color, color) || other.color == color)&&const DeepCollectionEquality().equals(other._tasks, _tasks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,schedule,startDate,endDate,isActive,color,const DeepCollectionEquality().hash(_tasks));

@override
String toString() {
  return 'UpdatePlanRequest(name: $name, schedule: $schedule, startDate: $startDate, endDate: $endDate, isActive: $isActive, color: $color, tasks: $tasks)';
}


}

/// @nodoc
abstract mixin class _$UpdatePlanRequestCopyWith<$Res> implements $UpdatePlanRequestCopyWith<$Res> {
  factory _$UpdatePlanRequestCopyWith(_UpdatePlanRequest value, $Res Function(_UpdatePlanRequest) _then) = __$UpdatePlanRequestCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(toJson: _scheduleToJson, fromJson: PlanSchedule.fromJson) PlanSchedule schedule,@JsonKey(name: 'start_date') String startDate,@JsonKey(name: 'end_date') String? endDate,@JsonKey(name: 'is_active') bool? isActive, String? color, List<UpdatePlanTaskRequest> tasks
});




}
/// @nodoc
class __$UpdatePlanRequestCopyWithImpl<$Res>
    implements _$UpdatePlanRequestCopyWith<$Res> {
  __$UpdatePlanRequestCopyWithImpl(this._self, this._then);

  final _UpdatePlanRequest _self;
  final $Res Function(_UpdatePlanRequest) _then;

/// Create a copy of UpdatePlanRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? schedule = null,Object? startDate = null,Object? endDate = freezed,Object? isActive = freezed,Object? color = freezed,Object? tasks = null,}) {
  return _then(_UpdatePlanRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,schedule: null == schedule ? _self.schedule : schedule // ignore: cast_nullable_to_non_nullable
as PlanSchedule,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<UpdatePlanTaskRequest>,
  ));
}


}

// dart format on
