// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upsert_task_category_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpsertTaskCategoryRequest {

 String get name;@JsonKey(name: 'task_folder_id') int get taskFolderId; String? get color;
/// Create a copy of UpsertTaskCategoryRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpsertTaskCategoryRequestCopyWith<UpsertTaskCategoryRequest> get copyWith => _$UpsertTaskCategoryRequestCopyWithImpl<UpsertTaskCategoryRequest>(this as UpsertTaskCategoryRequest, _$identity);

  /// Serializes this UpsertTaskCategoryRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpsertTaskCategoryRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.taskFolderId, taskFolderId) || other.taskFolderId == taskFolderId)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,taskFolderId,color);

@override
String toString() {
  return 'UpsertTaskCategoryRequest(name: $name, taskFolderId: $taskFolderId, color: $color)';
}


}

/// @nodoc
abstract mixin class $UpsertTaskCategoryRequestCopyWith<$Res>  {
  factory $UpsertTaskCategoryRequestCopyWith(UpsertTaskCategoryRequest value, $Res Function(UpsertTaskCategoryRequest) _then) = _$UpsertTaskCategoryRequestCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: 'task_folder_id') int taskFolderId, String? color
});




}
/// @nodoc
class _$UpsertTaskCategoryRequestCopyWithImpl<$Res>
    implements $UpsertTaskCategoryRequestCopyWith<$Res> {
  _$UpsertTaskCategoryRequestCopyWithImpl(this._self, this._then);

  final UpsertTaskCategoryRequest _self;
  final $Res Function(UpsertTaskCategoryRequest) _then;

/// Create a copy of UpsertTaskCategoryRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? taskFolderId = null,Object? color = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,taskFolderId: null == taskFolderId ? _self.taskFolderId : taskFolderId // ignore: cast_nullable_to_non_nullable
as int,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpsertTaskCategoryRequest].
extension UpsertTaskCategoryRequestPatterns on UpsertTaskCategoryRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpsertTaskCategoryRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpsertTaskCategoryRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpsertTaskCategoryRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpsertTaskCategoryRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpsertTaskCategoryRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpsertTaskCategoryRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'task_folder_id')  int taskFolderId,  String? color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpsertTaskCategoryRequest() when $default != null:
return $default(_that.name,_that.taskFolderId,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'task_folder_id')  int taskFolderId,  String? color)  $default,) {final _that = this;
switch (_that) {
case _UpsertTaskCategoryRequest():
return $default(_that.name,_that.taskFolderId,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(name: 'task_folder_id')  int taskFolderId,  String? color)?  $default,) {final _that = this;
switch (_that) {
case _UpsertTaskCategoryRequest() when $default != null:
return $default(_that.name,_that.taskFolderId,_that.color);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _UpsertTaskCategoryRequest implements UpsertTaskCategoryRequest {
  const _UpsertTaskCategoryRequest({required this.name, @JsonKey(name: 'task_folder_id') required this.taskFolderId, this.color});
  factory _UpsertTaskCategoryRequest.fromJson(Map<String, dynamic> json) => _$UpsertTaskCategoryRequestFromJson(json);

@override final  String name;
@override@JsonKey(name: 'task_folder_id') final  int taskFolderId;
@override final  String? color;

/// Create a copy of UpsertTaskCategoryRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpsertTaskCategoryRequestCopyWith<_UpsertTaskCategoryRequest> get copyWith => __$UpsertTaskCategoryRequestCopyWithImpl<_UpsertTaskCategoryRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpsertTaskCategoryRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpsertTaskCategoryRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.taskFolderId, taskFolderId) || other.taskFolderId == taskFolderId)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,taskFolderId,color);

@override
String toString() {
  return 'UpsertTaskCategoryRequest(name: $name, taskFolderId: $taskFolderId, color: $color)';
}


}

/// @nodoc
abstract mixin class _$UpsertTaskCategoryRequestCopyWith<$Res> implements $UpsertTaskCategoryRequestCopyWith<$Res> {
  factory _$UpsertTaskCategoryRequestCopyWith(_UpsertTaskCategoryRequest value, $Res Function(_UpsertTaskCategoryRequest) _then) = __$UpsertTaskCategoryRequestCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: 'task_folder_id') int taskFolderId, String? color
});




}
/// @nodoc
class __$UpsertTaskCategoryRequestCopyWithImpl<$Res>
    implements _$UpsertTaskCategoryRequestCopyWith<$Res> {
  __$UpsertTaskCategoryRequestCopyWithImpl(this._self, this._then);

  final _UpsertTaskCategoryRequest _self;
  final $Res Function(_UpsertTaskCategoryRequest) _then;

/// Create a copy of UpsertTaskCategoryRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? taskFolderId = null,Object? color = freezed,}) {
  return _then(_UpsertTaskCategoryRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,taskFolderId: null == taskFolderId ? _self.taskFolderId : taskFolderId // ignore: cast_nullable_to_non_nullable
as int,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
