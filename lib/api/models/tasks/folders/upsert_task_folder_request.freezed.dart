// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upsert_task_folder_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpsertTaskFolderRequest {

 String get name;
/// Create a copy of UpsertTaskFolderRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpsertTaskFolderRequestCopyWith<UpsertTaskFolderRequest> get copyWith => _$UpsertTaskFolderRequestCopyWithImpl<UpsertTaskFolderRequest>(this as UpsertTaskFolderRequest, _$identity);

  /// Serializes this UpsertTaskFolderRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpsertTaskFolderRequest&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'UpsertTaskFolderRequest(name: $name)';
}


}

/// @nodoc
abstract mixin class $UpsertTaskFolderRequestCopyWith<$Res>  {
  factory $UpsertTaskFolderRequestCopyWith(UpsertTaskFolderRequest value, $Res Function(UpsertTaskFolderRequest) _then) = _$UpsertTaskFolderRequestCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$UpsertTaskFolderRequestCopyWithImpl<$Res>
    implements $UpsertTaskFolderRequestCopyWith<$Res> {
  _$UpsertTaskFolderRequestCopyWithImpl(this._self, this._then);

  final UpsertTaskFolderRequest _self;
  final $Res Function(UpsertTaskFolderRequest) _then;

/// Create a copy of UpsertTaskFolderRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UpsertTaskFolderRequest].
extension UpsertTaskFolderRequestPatterns on UpsertTaskFolderRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpsertTaskFolderRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpsertTaskFolderRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpsertTaskFolderRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpsertTaskFolderRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpsertTaskFolderRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpsertTaskFolderRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpsertTaskFolderRequest() when $default != null:
return $default(_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name)  $default,) {final _that = this;
switch (_that) {
case _UpsertTaskFolderRequest():
return $default(_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name)?  $default,) {final _that = this;
switch (_that) {
case _UpsertTaskFolderRequest() when $default != null:
return $default(_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpsertTaskFolderRequest implements UpsertTaskFolderRequest {
  const _UpsertTaskFolderRequest({required this.name});
  factory _UpsertTaskFolderRequest.fromJson(Map<String, dynamic> json) => _$UpsertTaskFolderRequestFromJson(json);

@override final  String name;

/// Create a copy of UpsertTaskFolderRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpsertTaskFolderRequestCopyWith<_UpsertTaskFolderRequest> get copyWith => __$UpsertTaskFolderRequestCopyWithImpl<_UpsertTaskFolderRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpsertTaskFolderRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpsertTaskFolderRequest&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'UpsertTaskFolderRequest(name: $name)';
}


}

/// @nodoc
abstract mixin class _$UpsertTaskFolderRequestCopyWith<$Res> implements $UpsertTaskFolderRequestCopyWith<$Res> {
  factory _$UpsertTaskFolderRequestCopyWith(_UpsertTaskFolderRequest value, $Res Function(_UpsertTaskFolderRequest) _then) = __$UpsertTaskFolderRequestCopyWithImpl;
@override @useResult
$Res call({
 String name
});




}
/// @nodoc
class __$UpsertTaskFolderRequestCopyWithImpl<$Res>
    implements _$UpsertTaskFolderRequestCopyWith<$Res> {
  __$UpsertTaskFolderRequestCopyWithImpl(this._self, this._then);

  final _UpsertTaskFolderRequest _self;
  final $Res Function(_UpsertTaskFolderRequest) _then;

/// Create a copy of UpsertTaskFolderRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(_UpsertTaskFolderRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
