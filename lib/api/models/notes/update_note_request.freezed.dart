// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_note_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateNoteRequest {

 String get content;
/// Create a copy of UpdateNoteRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateNoteRequestCopyWith<UpdateNoteRequest> get copyWith => _$UpdateNoteRequestCopyWithImpl<UpdateNoteRequest>(this as UpdateNoteRequest, _$identity);

  /// Serializes this UpdateNoteRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateNoteRequest&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content);

@override
String toString() {
  return 'UpdateNoteRequest(content: $content)';
}


}

/// @nodoc
abstract mixin class $UpdateNoteRequestCopyWith<$Res>  {
  factory $UpdateNoteRequestCopyWith(UpdateNoteRequest value, $Res Function(UpdateNoteRequest) _then) = _$UpdateNoteRequestCopyWithImpl;
@useResult
$Res call({
 String content
});




}
/// @nodoc
class _$UpdateNoteRequestCopyWithImpl<$Res>
    implements $UpdateNoteRequestCopyWith<$Res> {
  _$UpdateNoteRequestCopyWithImpl(this._self, this._then);

  final UpdateNoteRequest _self;
  final $Res Function(UpdateNoteRequest) _then;

/// Create a copy of UpdateNoteRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,}) {
  return _then(_self.copyWith(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateNoteRequest].
extension UpdateNoteRequestPatterns on UpdateNoteRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateNoteRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateNoteRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateNoteRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateNoteRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateNoteRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateNoteRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateNoteRequest() when $default != null:
return $default(_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String content)  $default,) {final _that = this;
switch (_that) {
case _UpdateNoteRequest():
return $default(_that.content);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String content)?  $default,) {final _that = this;
switch (_that) {
case _UpdateNoteRequest() when $default != null:
return $default(_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateNoteRequest implements UpdateNoteRequest {
  const _UpdateNoteRequest({required this.content});
  factory _UpdateNoteRequest.fromJson(Map<String, dynamic> json) => _$UpdateNoteRequestFromJson(json);

@override final  String content;

/// Create a copy of UpdateNoteRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateNoteRequestCopyWith<_UpdateNoteRequest> get copyWith => __$UpdateNoteRequestCopyWithImpl<_UpdateNoteRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateNoteRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateNoteRequest&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content);

@override
String toString() {
  return 'UpdateNoteRequest(content: $content)';
}


}

/// @nodoc
abstract mixin class _$UpdateNoteRequestCopyWith<$Res> implements $UpdateNoteRequestCopyWith<$Res> {
  factory _$UpdateNoteRequestCopyWith(_UpdateNoteRequest value, $Res Function(_UpdateNoteRequest) _then) = __$UpdateNoteRequestCopyWithImpl;
@override @useResult
$Res call({
 String content
});




}
/// @nodoc
class __$UpdateNoteRequestCopyWithImpl<$Res>
    implements _$UpdateNoteRequestCopyWith<$Res> {
  __$UpdateNoteRequestCopyWithImpl(this._self, this._then);

  final _UpdateNoteRequest _self;
  final $Res Function(_UpdateNoteRequest) _then;

/// Create a copy of UpdateNoteRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,}) {
  return _then(_UpdateNoteRequest(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
