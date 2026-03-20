// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_plan_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreatePlanTaskRequest {

 String get name;@JsonKey(name: 'sort_order') int get sortOrder;@JsonKey(name: 'start_time') String? get startTime;@JsonKey(name: 'end_time') String? get endTime;
/// Create a copy of CreatePlanTaskRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePlanTaskRequestCopyWith<CreatePlanTaskRequest> get copyWith => _$CreatePlanTaskRequestCopyWithImpl<CreatePlanTaskRequest>(this as CreatePlanTaskRequest, _$identity);

  /// Serializes this CreatePlanTaskRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePlanTaskRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,sortOrder,startTime,endTime);

@override
String toString() {
  return 'CreatePlanTaskRequest(name: $name, sortOrder: $sortOrder, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class $CreatePlanTaskRequestCopyWith<$Res>  {
  factory $CreatePlanTaskRequestCopyWith(CreatePlanTaskRequest value, $Res Function(CreatePlanTaskRequest) _then) = _$CreatePlanTaskRequestCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: 'sort_order') int sortOrder,@JsonKey(name: 'start_time') String? startTime,@JsonKey(name: 'end_time') String? endTime
});




}
/// @nodoc
class _$CreatePlanTaskRequestCopyWithImpl<$Res>
    implements $CreatePlanTaskRequestCopyWith<$Res> {
  _$CreatePlanTaskRequestCopyWithImpl(this._self, this._then);

  final CreatePlanTaskRequest _self;
  final $Res Function(CreatePlanTaskRequest) _then;

/// Create a copy of CreatePlanTaskRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? sortOrder = null,Object? startTime = freezed,Object? endTime = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatePlanTaskRequest].
extension CreatePlanTaskRequestPatterns on CreatePlanTaskRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatePlanTaskRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatePlanTaskRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatePlanTaskRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreatePlanTaskRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatePlanTaskRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreatePlanTaskRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'start_time')  String? startTime, @JsonKey(name: 'end_time')  String? endTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePlanTaskRequest() when $default != null:
return $default(_that.name,_that.sortOrder,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'start_time')  String? startTime, @JsonKey(name: 'end_time')  String? endTime)  $default,) {final _that = this;
switch (_that) {
case _CreatePlanTaskRequest():
return $default(_that.name,_that.sortOrder,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'start_time')  String? startTime, @JsonKey(name: 'end_time')  String? endTime)?  $default,) {final _that = this;
switch (_that) {
case _CreatePlanTaskRequest() when $default != null:
return $default(_that.name,_that.sortOrder,_that.startTime,_that.endTime);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _CreatePlanTaskRequest implements CreatePlanTaskRequest {
  const _CreatePlanTaskRequest({required this.name, @JsonKey(name: 'sort_order') required this.sortOrder, @JsonKey(name: 'start_time') this.startTime, @JsonKey(name: 'end_time') this.endTime});
  factory _CreatePlanTaskRequest.fromJson(Map<String, dynamic> json) => _$CreatePlanTaskRequestFromJson(json);

@override final  String name;
@override@JsonKey(name: 'sort_order') final  int sortOrder;
@override@JsonKey(name: 'start_time') final  String? startTime;
@override@JsonKey(name: 'end_time') final  String? endTime;

/// Create a copy of CreatePlanTaskRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePlanTaskRequestCopyWith<_CreatePlanTaskRequest> get copyWith => __$CreatePlanTaskRequestCopyWithImpl<_CreatePlanTaskRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatePlanTaskRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePlanTaskRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,sortOrder,startTime,endTime);

@override
String toString() {
  return 'CreatePlanTaskRequest(name: $name, sortOrder: $sortOrder, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class _$CreatePlanTaskRequestCopyWith<$Res> implements $CreatePlanTaskRequestCopyWith<$Res> {
  factory _$CreatePlanTaskRequestCopyWith(_CreatePlanTaskRequest value, $Res Function(_CreatePlanTaskRequest) _then) = __$CreatePlanTaskRequestCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: 'sort_order') int sortOrder,@JsonKey(name: 'start_time') String? startTime,@JsonKey(name: 'end_time') String? endTime
});




}
/// @nodoc
class __$CreatePlanTaskRequestCopyWithImpl<$Res>
    implements _$CreatePlanTaskRequestCopyWith<$Res> {
  __$CreatePlanTaskRequestCopyWithImpl(this._self, this._then);

  final _CreatePlanTaskRequest _self;
  final $Res Function(_CreatePlanTaskRequest) _then;

/// Create a copy of CreatePlanTaskRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? sortOrder = null,Object? startTime = freezed,Object? endTime = freezed,}) {
  return _then(_CreatePlanTaskRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CreatePlanRequest {

 String get name;@JsonKey(toJson: _scheduleToJson, fromJson: PlanSchedule.fromJson) PlanSchedule get schedule;@JsonKey(name: 'start_date') String get startDate;@JsonKey(name: 'end_date') String? get endDate; String? get color; List<CreatePlanTaskRequest> get tasks;
/// Create a copy of CreatePlanRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePlanRequestCopyWith<CreatePlanRequest> get copyWith => _$CreatePlanRequestCopyWithImpl<CreatePlanRequest>(this as CreatePlanRequest, _$identity);

  /// Serializes this CreatePlanRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePlanRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.schedule, schedule) || other.schedule == schedule)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.color, color) || other.color == color)&&const DeepCollectionEquality().equals(other.tasks, tasks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,schedule,startDate,endDate,color,const DeepCollectionEquality().hash(tasks));

@override
String toString() {
  return 'CreatePlanRequest(name: $name, schedule: $schedule, startDate: $startDate, endDate: $endDate, color: $color, tasks: $tasks)';
}


}

/// @nodoc
abstract mixin class $CreatePlanRequestCopyWith<$Res>  {
  factory $CreatePlanRequestCopyWith(CreatePlanRequest value, $Res Function(CreatePlanRequest) _then) = _$CreatePlanRequestCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(toJson: _scheduleToJson, fromJson: PlanSchedule.fromJson) PlanSchedule schedule,@JsonKey(name: 'start_date') String startDate,@JsonKey(name: 'end_date') String? endDate, String? color, List<CreatePlanTaskRequest> tasks
});




}
/// @nodoc
class _$CreatePlanRequestCopyWithImpl<$Res>
    implements $CreatePlanRequestCopyWith<$Res> {
  _$CreatePlanRequestCopyWithImpl(this._self, this._then);

  final CreatePlanRequest _self;
  final $Res Function(CreatePlanRequest) _then;

/// Create a copy of CreatePlanRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? schedule = null,Object? startDate = null,Object? endDate = freezed,Object? color = freezed,Object? tasks = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,schedule: null == schedule ? _self.schedule : schedule // ignore: cast_nullable_to_non_nullable
as PlanSchedule,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<CreatePlanTaskRequest>,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatePlanRequest].
extension CreatePlanRequestPatterns on CreatePlanRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatePlanRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatePlanRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatePlanRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreatePlanRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatePlanRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreatePlanRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(toJson: _scheduleToJson, fromJson: PlanSchedule.fromJson)  PlanSchedule schedule, @JsonKey(name: 'start_date')  String startDate, @JsonKey(name: 'end_date')  String? endDate,  String? color,  List<CreatePlanTaskRequest> tasks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePlanRequest() when $default != null:
return $default(_that.name,_that.schedule,_that.startDate,_that.endDate,_that.color,_that.tasks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(toJson: _scheduleToJson, fromJson: PlanSchedule.fromJson)  PlanSchedule schedule, @JsonKey(name: 'start_date')  String startDate, @JsonKey(name: 'end_date')  String? endDate,  String? color,  List<CreatePlanTaskRequest> tasks)  $default,) {final _that = this;
switch (_that) {
case _CreatePlanRequest():
return $default(_that.name,_that.schedule,_that.startDate,_that.endDate,_that.color,_that.tasks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(toJson: _scheduleToJson, fromJson: PlanSchedule.fromJson)  PlanSchedule schedule, @JsonKey(name: 'start_date')  String startDate, @JsonKey(name: 'end_date')  String? endDate,  String? color,  List<CreatePlanTaskRequest> tasks)?  $default,) {final _that = this;
switch (_that) {
case _CreatePlanRequest() when $default != null:
return $default(_that.name,_that.schedule,_that.startDate,_that.endDate,_that.color,_that.tasks);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class _CreatePlanRequest implements CreatePlanRequest {
  const _CreatePlanRequest({required this.name, @JsonKey(toJson: _scheduleToJson, fromJson: PlanSchedule.fromJson) required this.schedule, @JsonKey(name: 'start_date') required this.startDate, @JsonKey(name: 'end_date') this.endDate, this.color, required final  List<CreatePlanTaskRequest> tasks}): _tasks = tasks;
  factory _CreatePlanRequest.fromJson(Map<String, dynamic> json) => _$CreatePlanRequestFromJson(json);

@override final  String name;
@override@JsonKey(toJson: _scheduleToJson, fromJson: PlanSchedule.fromJson) final  PlanSchedule schedule;
@override@JsonKey(name: 'start_date') final  String startDate;
@override@JsonKey(name: 'end_date') final  String? endDate;
@override final  String? color;
 final  List<CreatePlanTaskRequest> _tasks;
@override List<CreatePlanTaskRequest> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}


/// Create a copy of CreatePlanRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePlanRequestCopyWith<_CreatePlanRequest> get copyWith => __$CreatePlanRequestCopyWithImpl<_CreatePlanRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatePlanRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePlanRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.schedule, schedule) || other.schedule == schedule)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.color, color) || other.color == color)&&const DeepCollectionEquality().equals(other._tasks, _tasks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,schedule,startDate,endDate,color,const DeepCollectionEquality().hash(_tasks));

@override
String toString() {
  return 'CreatePlanRequest(name: $name, schedule: $schedule, startDate: $startDate, endDate: $endDate, color: $color, tasks: $tasks)';
}


}

/// @nodoc
abstract mixin class _$CreatePlanRequestCopyWith<$Res> implements $CreatePlanRequestCopyWith<$Res> {
  factory _$CreatePlanRequestCopyWith(_CreatePlanRequest value, $Res Function(_CreatePlanRequest) _then) = __$CreatePlanRequestCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(toJson: _scheduleToJson, fromJson: PlanSchedule.fromJson) PlanSchedule schedule,@JsonKey(name: 'start_date') String startDate,@JsonKey(name: 'end_date') String? endDate, String? color, List<CreatePlanTaskRequest> tasks
});




}
/// @nodoc
class __$CreatePlanRequestCopyWithImpl<$Res>
    implements _$CreatePlanRequestCopyWith<$Res> {
  __$CreatePlanRequestCopyWithImpl(this._self, this._then);

  final _CreatePlanRequest _self;
  final $Res Function(_CreatePlanRequest) _then;

/// Create a copy of CreatePlanRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? schedule = null,Object? startDate = null,Object? endDate = freezed,Object? color = freezed,Object? tasks = null,}) {
  return _then(_CreatePlanRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,schedule: null == schedule ? _self.schedule : schedule // ignore: cast_nullable_to_non_nullable
as PlanSchedule,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<CreatePlanTaskRequest>,
  ));
}


}

// dart format on
