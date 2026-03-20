// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_latest_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CheckLatestRequest {

 String get platform; String get channel;
/// Create a copy of CheckLatestRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckLatestRequestCopyWith<CheckLatestRequest> get copyWith => _$CheckLatestRequestCopyWithImpl<CheckLatestRequest>(this as CheckLatestRequest, _$identity);

  /// Serializes this CheckLatestRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckLatestRequest&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.channel, channel) || other.channel == channel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,platform,channel);

@override
String toString() {
  return 'CheckLatestRequest(platform: $platform, channel: $channel)';
}


}

/// @nodoc
abstract mixin class $CheckLatestRequestCopyWith<$Res>  {
  factory $CheckLatestRequestCopyWith(CheckLatestRequest value, $Res Function(CheckLatestRequest) _then) = _$CheckLatestRequestCopyWithImpl;
@useResult
$Res call({
 String platform, String channel
});




}
/// @nodoc
class _$CheckLatestRequestCopyWithImpl<$Res>
    implements $CheckLatestRequestCopyWith<$Res> {
  _$CheckLatestRequestCopyWithImpl(this._self, this._then);

  final CheckLatestRequest _self;
  final $Res Function(CheckLatestRequest) _then;

/// Create a copy of CheckLatestRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? platform = null,Object? channel = null,}) {
  return _then(_self.copyWith(
platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckLatestRequest].
extension CheckLatestRequestPatterns on CheckLatestRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckLatestRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckLatestRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckLatestRequest value)  $default,){
final _that = this;
switch (_that) {
case _CheckLatestRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckLatestRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CheckLatestRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String platform,  String channel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckLatestRequest() when $default != null:
return $default(_that.platform,_that.channel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String platform,  String channel)  $default,) {final _that = this;
switch (_that) {
case _CheckLatestRequest():
return $default(_that.platform,_that.channel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String platform,  String channel)?  $default,) {final _that = this;
switch (_that) {
case _CheckLatestRequest() when $default != null:
return $default(_that.platform,_that.channel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckLatestRequest implements CheckLatestRequest {
  const _CheckLatestRequest({required this.platform, required this.channel});
  factory _CheckLatestRequest.fromJson(Map<String, dynamic> json) => _$CheckLatestRequestFromJson(json);

@override final  String platform;
@override final  String channel;

/// Create a copy of CheckLatestRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckLatestRequestCopyWith<_CheckLatestRequest> get copyWith => __$CheckLatestRequestCopyWithImpl<_CheckLatestRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckLatestRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckLatestRequest&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.channel, channel) || other.channel == channel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,platform,channel);

@override
String toString() {
  return 'CheckLatestRequest(platform: $platform, channel: $channel)';
}


}

/// @nodoc
abstract mixin class _$CheckLatestRequestCopyWith<$Res> implements $CheckLatestRequestCopyWith<$Res> {
  factory _$CheckLatestRequestCopyWith(_CheckLatestRequest value, $Res Function(_CheckLatestRequest) _then) = __$CheckLatestRequestCopyWithImpl;
@override @useResult
$Res call({
 String platform, String channel
});




}
/// @nodoc
class __$CheckLatestRequestCopyWithImpl<$Res>
    implements _$CheckLatestRequestCopyWith<$Res> {
  __$CheckLatestRequestCopyWithImpl(this._self, this._then);

  final _CheckLatestRequest _self;
  final $Res Function(_CheckLatestRequest) _then;

/// Create a copy of CheckLatestRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? platform = null,Object? channel = null,}) {
  return _then(_CheckLatestRequest(
platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
