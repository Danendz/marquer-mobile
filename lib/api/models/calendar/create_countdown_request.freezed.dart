// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_countdown_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateCountdownRequest {

 String get name;@JsonKey(name: 'target_date') String get targetDate;@JsonKey(name: 'bg_image') String get bgImage;
/// Create a copy of CreateCountdownRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateCountdownRequestCopyWith<CreateCountdownRequest> get copyWith => _$CreateCountdownRequestCopyWithImpl<CreateCountdownRequest>(this as CreateCountdownRequest, _$identity);

  /// Serializes this CreateCountdownRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateCountdownRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.targetDate, targetDate) || other.targetDate == targetDate)&&(identical(other.bgImage, bgImage) || other.bgImage == bgImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,targetDate,bgImage);

@override
String toString() {
  return 'CreateCountdownRequest(name: $name, targetDate: $targetDate, bgImage: $bgImage)';
}


}

/// @nodoc
abstract mixin class $CreateCountdownRequestCopyWith<$Res>  {
  factory $CreateCountdownRequestCopyWith(CreateCountdownRequest value, $Res Function(CreateCountdownRequest) _then) = _$CreateCountdownRequestCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: 'target_date') String targetDate,@JsonKey(name: 'bg_image') String bgImage
});




}
/// @nodoc
class _$CreateCountdownRequestCopyWithImpl<$Res>
    implements $CreateCountdownRequestCopyWith<$Res> {
  _$CreateCountdownRequestCopyWithImpl(this._self, this._then);

  final CreateCountdownRequest _self;
  final $Res Function(CreateCountdownRequest) _then;

/// Create a copy of CreateCountdownRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? targetDate = null,Object? bgImage = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,targetDate: null == targetDate ? _self.targetDate : targetDate // ignore: cast_nullable_to_non_nullable
as String,bgImage: null == bgImage ? _self.bgImage : bgImage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateCountdownRequest].
extension CreateCountdownRequestPatterns on CreateCountdownRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateCountdownRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateCountdownRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateCountdownRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateCountdownRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateCountdownRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateCountdownRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'target_date')  String targetDate, @JsonKey(name: 'bg_image')  String bgImage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateCountdownRequest() when $default != null:
return $default(_that.name,_that.targetDate,_that.bgImage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'target_date')  String targetDate, @JsonKey(name: 'bg_image')  String bgImage)  $default,) {final _that = this;
switch (_that) {
case _CreateCountdownRequest():
return $default(_that.name,_that.targetDate,_that.bgImage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(name: 'target_date')  String targetDate, @JsonKey(name: 'bg_image')  String bgImage)?  $default,) {final _that = this;
switch (_that) {
case _CreateCountdownRequest() when $default != null:
return $default(_that.name,_that.targetDate,_that.bgImage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateCountdownRequest implements CreateCountdownRequest {
  const _CreateCountdownRequest({required this.name, @JsonKey(name: 'target_date') required this.targetDate, @JsonKey(name: 'bg_image') required this.bgImage});
  factory _CreateCountdownRequest.fromJson(Map<String, dynamic> json) => _$CreateCountdownRequestFromJson(json);

@override final  String name;
@override@JsonKey(name: 'target_date') final  String targetDate;
@override@JsonKey(name: 'bg_image') final  String bgImage;

/// Create a copy of CreateCountdownRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateCountdownRequestCopyWith<_CreateCountdownRequest> get copyWith => __$CreateCountdownRequestCopyWithImpl<_CreateCountdownRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateCountdownRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateCountdownRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.targetDate, targetDate) || other.targetDate == targetDate)&&(identical(other.bgImage, bgImage) || other.bgImage == bgImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,targetDate,bgImage);

@override
String toString() {
  return 'CreateCountdownRequest(name: $name, targetDate: $targetDate, bgImage: $bgImage)';
}


}

/// @nodoc
abstract mixin class _$CreateCountdownRequestCopyWith<$Res> implements $CreateCountdownRequestCopyWith<$Res> {
  factory _$CreateCountdownRequestCopyWith(_CreateCountdownRequest value, $Res Function(_CreateCountdownRequest) _then) = __$CreateCountdownRequestCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: 'target_date') String targetDate,@JsonKey(name: 'bg_image') String bgImage
});




}
/// @nodoc
class __$CreateCountdownRequestCopyWithImpl<$Res>
    implements _$CreateCountdownRequestCopyWith<$Res> {
  __$CreateCountdownRequestCopyWithImpl(this._self, this._then);

  final _CreateCountdownRequest _self;
  final $Res Function(_CreateCountdownRequest) _then;

/// Create a copy of CreateCountdownRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? targetDate = null,Object? bgImage = null,}) {
  return _then(_CreateCountdownRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,targetDate: null == targetDate ? _self.targetDate : targetDate // ignore: cast_nullable_to_non_nullable
as String,bgImage: null == bgImage ? _self.bgImage : bgImage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
