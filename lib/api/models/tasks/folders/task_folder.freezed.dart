// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_folder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskFolder {

 int get id; String get name; List<TaskCategory> get categories;@JsonKey(name: 'created_at') String? get createdAt;@JsonKey(name: 'updated_at') String? get updatedAt;
/// Create a copy of TaskFolder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskFolderCopyWith<TaskFolder> get copyWith => _$TaskFolderCopyWithImpl<TaskFolder>(this as TaskFolder, _$identity);

  /// Serializes this TaskFolder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskFolder&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(categories),createdAt,updatedAt);

@override
String toString() {
  return 'TaskFolder(id: $id, name: $name, categories: $categories, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TaskFolderCopyWith<$Res>  {
  factory $TaskFolderCopyWith(TaskFolder value, $Res Function(TaskFolder) _then) = _$TaskFolderCopyWithImpl;
@useResult
$Res call({
 int id, String name, List<TaskCategory> categories,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt
});




}
/// @nodoc
class _$TaskFolderCopyWithImpl<$Res>
    implements $TaskFolderCopyWith<$Res> {
  _$TaskFolderCopyWithImpl(this._self, this._then);

  final TaskFolder _self;
  final $Res Function(TaskFolder) _then;

/// Create a copy of TaskFolder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? categories = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<TaskCategory>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskFolder].
extension TaskFolderPatterns on TaskFolder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskFolder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskFolder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskFolder value)  $default,){
final _that = this;
switch (_that) {
case _TaskFolder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskFolder value)?  $default,){
final _that = this;
switch (_that) {
case _TaskFolder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  List<TaskCategory> categories, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskFolder() when $default != null:
return $default(_that.id,_that.name,_that.categories,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  List<TaskCategory> categories, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _TaskFolder():
return $default(_that.id,_that.name,_that.categories,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  List<TaskCategory> categories, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _TaskFolder() when $default != null:
return $default(_that.id,_that.name,_that.categories,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _TaskFolder implements TaskFolder {
  const _TaskFolder({required this.id, required this.name, final  List<TaskCategory> categories = const [], @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt}): _categories = categories;
  factory _TaskFolder.fromJson(Map<String, dynamic> json) => _$TaskFolderFromJson(json);

@override final  int id;
@override final  String name;
 final  List<TaskCategory> _categories;
@override@JsonKey() List<TaskCategory> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey(name: 'updated_at') final  String? updatedAt;

/// Create a copy of TaskFolder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskFolderCopyWith<_TaskFolder> get copyWith => __$TaskFolderCopyWithImpl<_TaskFolder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskFolderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskFolder&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_categories),createdAt,updatedAt);

@override
String toString() {
  return 'TaskFolder(id: $id, name: $name, categories: $categories, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TaskFolderCopyWith<$Res> implements $TaskFolderCopyWith<$Res> {
  factory _$TaskFolderCopyWith(_TaskFolder value, $Res Function(_TaskFolder) _then) = __$TaskFolderCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, List<TaskCategory> categories,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt
});




}
/// @nodoc
class __$TaskFolderCopyWithImpl<$Res>
    implements _$TaskFolderCopyWith<$Res> {
  __$TaskFolderCopyWithImpl(this._self, this._then);

  final _TaskFolder _self;
  final $Res Function(_TaskFolder) _then;

/// Create a copy of TaskFolder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? categories = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_TaskFolder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<TaskCategory>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
