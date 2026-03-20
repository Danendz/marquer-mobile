// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_task_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateTaskRequest {

 String get name; String? get date;@JsonKey(name: 'start_time') String? get startTime;@JsonKey(name: 'end_time') String? get endTime;@JsonKey(name: 'task_category_id') int? get taskCategoryId; String? get color;
/// Create a copy of CreateTaskRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateTaskRequestCopyWith<CreateTaskRequest> get copyWith => _$CreateTaskRequestCopyWithImpl<CreateTaskRequest>(this as CreateTaskRequest, _$identity);

  /// Serializes this CreateTaskRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTaskRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.date, date) || other.date == date)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.taskCategoryId, taskCategoryId) || other.taskCategoryId == taskCategoryId)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,date,startTime,endTime,taskCategoryId,color);

@override
String toString() {
  return 'CreateTaskRequest(name: $name, date: $date, startTime: $startTime, endTime: $endTime, taskCategoryId: $taskCategoryId, color: $color)';
}


}

/// @nodoc
abstract mixin class $CreateTaskRequestCopyWith<$Res>  {
  factory $CreateTaskRequestCopyWith(CreateTaskRequest value, $Res Function(CreateTaskRequest) _then) = _$CreateTaskRequestCopyWithImpl;
@useResult
$Res call({
 String name, String? date,@JsonKey(name: 'start_time') String? startTime,@JsonKey(name: 'end_time') String? endTime,@JsonKey(name: 'task_category_id') int? taskCategoryId, String? color
});




}
/// @nodoc
class _$CreateTaskRequestCopyWithImpl<$Res>
    implements $CreateTaskRequestCopyWith<$Res> {
  _$CreateTaskRequestCopyWithImpl(this._self, this._then);

  final CreateTaskRequest _self;
  final $Res Function(CreateTaskRequest) _then;

/// Create a copy of CreateTaskRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? date = freezed,Object? startTime = freezed,Object? endTime = freezed,Object? taskCategoryId = freezed,Object? color = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,taskCategoryId: freezed == taskCategoryId ? _self.taskCategoryId : taskCategoryId // ignore: cast_nullable_to_non_nullable
as int?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateTaskRequest].
extension CreateTaskRequestPatterns on CreateTaskRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateTaskRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateTaskRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateTaskRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateTaskRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateTaskRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateTaskRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? date, @JsonKey(name: 'start_time')  String? startTime, @JsonKey(name: 'end_time')  String? endTime, @JsonKey(name: 'task_category_id')  int? taskCategoryId,  String? color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateTaskRequest() when $default != null:
return $default(_that.name,_that.date,_that.startTime,_that.endTime,_that.taskCategoryId,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? date, @JsonKey(name: 'start_time')  String? startTime, @JsonKey(name: 'end_time')  String? endTime, @JsonKey(name: 'task_category_id')  int? taskCategoryId,  String? color)  $default,) {final _that = this;
switch (_that) {
case _CreateTaskRequest():
return $default(_that.name,_that.date,_that.startTime,_that.endTime,_that.taskCategoryId,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? date, @JsonKey(name: 'start_time')  String? startTime, @JsonKey(name: 'end_time')  String? endTime, @JsonKey(name: 'task_category_id')  int? taskCategoryId,  String? color)?  $default,) {final _that = this;
switch (_that) {
case _CreateTaskRequest() when $default != null:
return $default(_that.name,_that.date,_that.startTime,_that.endTime,_that.taskCategoryId,_that.color);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _CreateTaskRequest implements CreateTaskRequest {
  const _CreateTaskRequest({required this.name, this.date, @JsonKey(name: 'start_time') this.startTime, @JsonKey(name: 'end_time') this.endTime, @JsonKey(name: 'task_category_id') this.taskCategoryId, this.color});
  factory _CreateTaskRequest.fromJson(Map<String, dynamic> json) => _$CreateTaskRequestFromJson(json);

@override final  String name;
@override final  String? date;
@override@JsonKey(name: 'start_time') final  String? startTime;
@override@JsonKey(name: 'end_time') final  String? endTime;
@override@JsonKey(name: 'task_category_id') final  int? taskCategoryId;
@override final  String? color;

/// Create a copy of CreateTaskRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateTaskRequestCopyWith<_CreateTaskRequest> get copyWith => __$CreateTaskRequestCopyWithImpl<_CreateTaskRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateTaskRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateTaskRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.date, date) || other.date == date)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.taskCategoryId, taskCategoryId) || other.taskCategoryId == taskCategoryId)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,date,startTime,endTime,taskCategoryId,color);

@override
String toString() {
  return 'CreateTaskRequest(name: $name, date: $date, startTime: $startTime, endTime: $endTime, taskCategoryId: $taskCategoryId, color: $color)';
}


}

/// @nodoc
abstract mixin class _$CreateTaskRequestCopyWith<$Res> implements $CreateTaskRequestCopyWith<$Res> {
  factory _$CreateTaskRequestCopyWith(_CreateTaskRequest value, $Res Function(_CreateTaskRequest) _then) = __$CreateTaskRequestCopyWithImpl;
@override @useResult
$Res call({
 String name, String? date,@JsonKey(name: 'start_time') String? startTime,@JsonKey(name: 'end_time') String? endTime,@JsonKey(name: 'task_category_id') int? taskCategoryId, String? color
});




}
/// @nodoc
class __$CreateTaskRequestCopyWithImpl<$Res>
    implements _$CreateTaskRequestCopyWith<$Res> {
  __$CreateTaskRequestCopyWithImpl(this._self, this._then);

  final _CreateTaskRequest _self;
  final $Res Function(_CreateTaskRequest) _then;

/// Create a copy of CreateTaskRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? date = freezed,Object? startTime = freezed,Object? endTime = freezed,Object? taskCategoryId = freezed,Object? color = freezed,}) {
  return _then(_CreateTaskRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,taskCategoryId: freezed == taskCategoryId ? _self.taskCategoryId : taskCategoryId // ignore: cast_nullable_to_non_nullable
as int?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
