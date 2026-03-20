// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlanTask {

 int get id; String get name;@JsonKey(name: 'sort_order') int get sortOrder;@JsonKey(name: 'start_time') String? get startTime;@JsonKey(name: 'end_time') String? get endTime;
/// Create a copy of PlanTask
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanTaskCopyWith<PlanTask> get copyWith => _$PlanTaskCopyWithImpl<PlanTask>(this as PlanTask, _$identity);

  /// Serializes this PlanTask to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanTask&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,sortOrder,startTime,endTime);

@override
String toString() {
  return 'PlanTask(id: $id, name: $name, sortOrder: $sortOrder, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class $PlanTaskCopyWith<$Res>  {
  factory $PlanTaskCopyWith(PlanTask value, $Res Function(PlanTask) _then) = _$PlanTaskCopyWithImpl;
@useResult
$Res call({
 int id, String name,@JsonKey(name: 'sort_order') int sortOrder,@JsonKey(name: 'start_time') String? startTime,@JsonKey(name: 'end_time') String? endTime
});




}
/// @nodoc
class _$PlanTaskCopyWithImpl<$Res>
    implements $PlanTaskCopyWith<$Res> {
  _$PlanTaskCopyWithImpl(this._self, this._then);

  final PlanTask _self;
  final $Res Function(PlanTask) _then;

/// Create a copy of PlanTask
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? sortOrder = null,Object? startTime = freezed,Object? endTime = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanTask].
extension PlanTaskPatterns on PlanTask {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanTask value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanTask() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanTask value)  $default,){
final _that = this;
switch (_that) {
case _PlanTask():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanTask value)?  $default,){
final _that = this;
switch (_that) {
case _PlanTask() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'start_time')  String? startTime, @JsonKey(name: 'end_time')  String? endTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanTask() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'start_time')  String? startTime, @JsonKey(name: 'end_time')  String? endTime)  $default,) {final _that = this;
switch (_that) {
case _PlanTask():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'start_time')  String? startTime, @JsonKey(name: 'end_time')  String? endTime)?  $default,) {final _that = this;
switch (_that) {
case _PlanTask() when $default != null:
return $default(_that.id,_that.name,_that.sortOrder,_that.startTime,_that.endTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanTask implements PlanTask {
  const _PlanTask({required this.id, required this.name, @JsonKey(name: 'sort_order') required this.sortOrder, @JsonKey(name: 'start_time') this.startTime, @JsonKey(name: 'end_time') this.endTime});
  factory _PlanTask.fromJson(Map<String, dynamic> json) => _$PlanTaskFromJson(json);

@override final  int id;
@override final  String name;
@override@JsonKey(name: 'sort_order') final  int sortOrder;
@override@JsonKey(name: 'start_time') final  String? startTime;
@override@JsonKey(name: 'end_time') final  String? endTime;

/// Create a copy of PlanTask
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanTaskCopyWith<_PlanTask> get copyWith => __$PlanTaskCopyWithImpl<_PlanTask>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanTaskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanTask&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,sortOrder,startTime,endTime);

@override
String toString() {
  return 'PlanTask(id: $id, name: $name, sortOrder: $sortOrder, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class _$PlanTaskCopyWith<$Res> implements $PlanTaskCopyWith<$Res> {
  factory _$PlanTaskCopyWith(_PlanTask value, $Res Function(_PlanTask) _then) = __$PlanTaskCopyWithImpl;
@override @useResult
$Res call({
 int id, String name,@JsonKey(name: 'sort_order') int sortOrder,@JsonKey(name: 'start_time') String? startTime,@JsonKey(name: 'end_time') String? endTime
});




}
/// @nodoc
class __$PlanTaskCopyWithImpl<$Res>
    implements _$PlanTaskCopyWith<$Res> {
  __$PlanTaskCopyWithImpl(this._self, this._then);

  final _PlanTask _self;
  final $Res Function(_PlanTask) _then;

/// Create a copy of PlanTask
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? sortOrder = null,Object? startTime = freezed,Object? endTime = freezed,}) {
  return _then(_PlanTask(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
