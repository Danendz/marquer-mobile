// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_note_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateNoteRequest {

 String get title; String get content;
/// Create a copy of CreateNoteRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateNoteRequestCopyWith<CreateNoteRequest> get copyWith => _$CreateNoteRequestCopyWithImpl<CreateNoteRequest>(this as CreateNoteRequest, _$identity);

  /// Serializes this CreateNoteRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateNoteRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,content);

@override
String toString() {
  return 'CreateNoteRequest(title: $title, content: $content)';
}


}

/// @nodoc
abstract mixin class $CreateNoteRequestCopyWith<$Res>  {
  factory $CreateNoteRequestCopyWith(CreateNoteRequest value, $Res Function(CreateNoteRequest) _then) = _$CreateNoteRequestCopyWithImpl;
@useResult
$Res call({
 String title, String content
});




}
/// @nodoc
class _$CreateNoteRequestCopyWithImpl<$Res>
    implements $CreateNoteRequestCopyWith<$Res> {
  _$CreateNoteRequestCopyWithImpl(this._self, this._then);

  final CreateNoteRequest _self;
  final $Res Function(CreateNoteRequest) _then;

/// Create a copy of CreateNoteRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? content = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateNoteRequest].
extension CreateNoteRequestPatterns on CreateNoteRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateNoteRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateNoteRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateNoteRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateNoteRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateNoteRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateNoteRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateNoteRequest() when $default != null:
return $default(_that.title,_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String content)  $default,) {final _that = this;
switch (_that) {
case _CreateNoteRequest():
return $default(_that.title,_that.content);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String content)?  $default,) {final _that = this;
switch (_that) {
case _CreateNoteRequest() when $default != null:
return $default(_that.title,_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateNoteRequest implements CreateNoteRequest {
  const _CreateNoteRequest({required this.title, required this.content});
  factory _CreateNoteRequest.fromJson(Map<String, dynamic> json) => _$CreateNoteRequestFromJson(json);

@override final  String title;
@override final  String content;

/// Create a copy of CreateNoteRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateNoteRequestCopyWith<_CreateNoteRequest> get copyWith => __$CreateNoteRequestCopyWithImpl<_CreateNoteRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateNoteRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateNoteRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,content);

@override
String toString() {
  return 'CreateNoteRequest(title: $title, content: $content)';
}


}

/// @nodoc
abstract mixin class _$CreateNoteRequestCopyWith<$Res> implements $CreateNoteRequestCopyWith<$Res> {
  factory _$CreateNoteRequestCopyWith(_CreateNoteRequest value, $Res Function(_CreateNoteRequest) _then) = __$CreateNoteRequestCopyWithImpl;
@override @useResult
$Res call({
 String title, String content
});




}
/// @nodoc
class __$CreateNoteRequestCopyWithImpl<$Res>
    implements _$CreateNoteRequestCopyWith<$Res> {
  __$CreateNoteRequestCopyWithImpl(this._self, this._then);

  final _CreateNoteRequest _self;
  final $Res Function(_CreateNoteRequest) _then;

/// Create a copy of CreateNoteRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? content = null,}) {
  return _then(_CreateNoteRequest(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
