// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskCategory {

 int? get id; String get name; String get color;@JsonKey(name: 'tasks_count') int get tasksCount;@JsonKey(name: 'created_at') String? get createdAt;@JsonKey(name: 'updated_at') String? get updatedAt;@JsonKey(includeFromJson: false, includeToJson: false) String? get tempNewUUID;
/// Create a copy of TaskCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskCategoryCopyWith<TaskCategory> get copyWith => _$TaskCategoryCopyWithImpl<TaskCategory>(this as TaskCategory, _$identity);

  /// Serializes this TaskCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.tasksCount, tasksCount) || other.tasksCount == tasksCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.tempNewUUID, tempNewUUID) || other.tempNewUUID == tempNewUUID));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,color,tasksCount,createdAt,updatedAt,tempNewUUID);

@override
String toString() {
  return 'TaskCategory(id: $id, name: $name, color: $color, tasksCount: $tasksCount, createdAt: $createdAt, updatedAt: $updatedAt, tempNewUUID: $tempNewUUID)';
}


}

/// @nodoc
abstract mixin class $TaskCategoryCopyWith<$Res>  {
  factory $TaskCategoryCopyWith(TaskCategory value, $Res Function(TaskCategory) _then) = _$TaskCategoryCopyWithImpl;
@useResult
$Res call({
 int? id, String name, String color,@JsonKey(name: 'tasks_count') int tasksCount,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt,@JsonKey(includeFromJson: false, includeToJson: false) String? tempNewUUID
});




}
/// @nodoc
class _$TaskCategoryCopyWithImpl<$Res>
    implements $TaskCategoryCopyWith<$Res> {
  _$TaskCategoryCopyWithImpl(this._self, this._then);

  final TaskCategory _self;
  final $Res Function(TaskCategory) _then;

/// Create a copy of TaskCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? color = null,Object? tasksCount = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? tempNewUUID = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,tasksCount: null == tasksCount ? _self.tasksCount : tasksCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,tempNewUUID: freezed == tempNewUUID ? _self.tempNewUUID : tempNewUUID // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskCategory].
extension TaskCategoryPatterns on TaskCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskCategory value)  $default,){
final _that = this;
switch (_that) {
case _TaskCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskCategory value)?  $default,){
final _that = this;
switch (_that) {
case _TaskCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String name,  String color, @JsonKey(name: 'tasks_count')  int tasksCount, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(includeFromJson: false, includeToJson: false)  String? tempNewUUID)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskCategory() when $default != null:
return $default(_that.id,_that.name,_that.color,_that.tasksCount,_that.createdAt,_that.updatedAt,_that.tempNewUUID);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String name,  String color, @JsonKey(name: 'tasks_count')  int tasksCount, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(includeFromJson: false, includeToJson: false)  String? tempNewUUID)  $default,) {final _that = this;
switch (_that) {
case _TaskCategory():
return $default(_that.id,_that.name,_that.color,_that.tasksCount,_that.createdAt,_that.updatedAt,_that.tempNewUUID);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String name,  String color, @JsonKey(name: 'tasks_count')  int tasksCount, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(includeFromJson: false, includeToJson: false)  String? tempNewUUID)?  $default,) {final _that = this;
switch (_that) {
case _TaskCategory() when $default != null:
return $default(_that.id,_that.name,_that.color,_that.tasksCount,_that.createdAt,_that.updatedAt,_that.tempNewUUID);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskCategory implements TaskCategory {
  const _TaskCategory({this.id, required this.name, required this.color, @JsonKey(name: 'tasks_count') this.tasksCount = 0, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, @JsonKey(includeFromJson: false, includeToJson: false) this.tempNewUUID});
  factory _TaskCategory.fromJson(Map<String, dynamic> json) => _$TaskCategoryFromJson(json);

@override final  int? id;
@override final  String name;
@override final  String color;
@override@JsonKey(name: 'tasks_count') final  int tasksCount;
@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey(name: 'updated_at') final  String? updatedAt;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  String? tempNewUUID;

/// Create a copy of TaskCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskCategoryCopyWith<_TaskCategory> get copyWith => __$TaskCategoryCopyWithImpl<_TaskCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.tasksCount, tasksCount) || other.tasksCount == tasksCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.tempNewUUID, tempNewUUID) || other.tempNewUUID == tempNewUUID));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,color,tasksCount,createdAt,updatedAt,tempNewUUID);

@override
String toString() {
  return 'TaskCategory(id: $id, name: $name, color: $color, tasksCount: $tasksCount, createdAt: $createdAt, updatedAt: $updatedAt, tempNewUUID: $tempNewUUID)';
}


}

/// @nodoc
abstract mixin class _$TaskCategoryCopyWith<$Res> implements $TaskCategoryCopyWith<$Res> {
  factory _$TaskCategoryCopyWith(_TaskCategory value, $Res Function(_TaskCategory) _then) = __$TaskCategoryCopyWithImpl;
@override @useResult
$Res call({
 int? id, String name, String color,@JsonKey(name: 'tasks_count') int tasksCount,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt,@JsonKey(includeFromJson: false, includeToJson: false) String? tempNewUUID
});




}
/// @nodoc
class __$TaskCategoryCopyWithImpl<$Res>
    implements _$TaskCategoryCopyWith<$Res> {
  __$TaskCategoryCopyWithImpl(this._self, this._then);

  final _TaskCategory _self;
  final $Res Function(_TaskCategory) _then;

/// Create a copy of TaskCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? color = null,Object? tasksCount = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? tempNewUUID = freezed,}) {
  return _then(_TaskCategory(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,tasksCount: null == tasksCount ? _self.tasksCount : tasksCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,tempNewUUID: freezed == tempNewUUID ? _self.tempNewUUID : tempNewUUID // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
