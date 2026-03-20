// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_latest_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CheckLatestResponse {

 String get version;@JsonKey(name: 'version_full') String? get versionFull;@JsonKey(name: 'download_url') String get downloadUrl; String? get changelog;
/// Create a copy of CheckLatestResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckLatestResponseCopyWith<CheckLatestResponse> get copyWith => _$CheckLatestResponseCopyWithImpl<CheckLatestResponse>(this as CheckLatestResponse, _$identity);

  /// Serializes this CheckLatestResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckLatestResponse&&(identical(other.version, version) || other.version == version)&&(identical(other.versionFull, versionFull) || other.versionFull == versionFull)&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl)&&(identical(other.changelog, changelog) || other.changelog == changelog));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,versionFull,downloadUrl,changelog);

@override
String toString() {
  return 'CheckLatestResponse(version: $version, versionFull: $versionFull, downloadUrl: $downloadUrl, changelog: $changelog)';
}


}

/// @nodoc
abstract mixin class $CheckLatestResponseCopyWith<$Res>  {
  factory $CheckLatestResponseCopyWith(CheckLatestResponse value, $Res Function(CheckLatestResponse) _then) = _$CheckLatestResponseCopyWithImpl;
@useResult
$Res call({
 String version,@JsonKey(name: 'version_full') String? versionFull,@JsonKey(name: 'download_url') String downloadUrl, String? changelog
});




}
/// @nodoc
class _$CheckLatestResponseCopyWithImpl<$Res>
    implements $CheckLatestResponseCopyWith<$Res> {
  _$CheckLatestResponseCopyWithImpl(this._self, this._then);

  final CheckLatestResponse _self;
  final $Res Function(CheckLatestResponse) _then;

/// Create a copy of CheckLatestResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? versionFull = freezed,Object? downloadUrl = null,Object? changelog = freezed,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,versionFull: freezed == versionFull ? _self.versionFull : versionFull // ignore: cast_nullable_to_non_nullable
as String?,downloadUrl: null == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String,changelog: freezed == changelog ? _self.changelog : changelog // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckLatestResponse].
extension CheckLatestResponsePatterns on CheckLatestResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckLatestResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckLatestResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckLatestResponse value)  $default,){
final _that = this;
switch (_that) {
case _CheckLatestResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckLatestResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CheckLatestResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String version, @JsonKey(name: 'version_full')  String? versionFull, @JsonKey(name: 'download_url')  String downloadUrl,  String? changelog)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckLatestResponse() when $default != null:
return $default(_that.version,_that.versionFull,_that.downloadUrl,_that.changelog);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String version, @JsonKey(name: 'version_full')  String? versionFull, @JsonKey(name: 'download_url')  String downloadUrl,  String? changelog)  $default,) {final _that = this;
switch (_that) {
case _CheckLatestResponse():
return $default(_that.version,_that.versionFull,_that.downloadUrl,_that.changelog);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String version, @JsonKey(name: 'version_full')  String? versionFull, @JsonKey(name: 'download_url')  String downloadUrl,  String? changelog)?  $default,) {final _that = this;
switch (_that) {
case _CheckLatestResponse() when $default != null:
return $default(_that.version,_that.versionFull,_that.downloadUrl,_that.changelog);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckLatestResponse implements CheckLatestResponse {
  const _CheckLatestResponse({required this.version, @JsonKey(name: 'version_full') this.versionFull, @JsonKey(name: 'download_url') required this.downloadUrl, this.changelog});
  factory _CheckLatestResponse.fromJson(Map<String, dynamic> json) => _$CheckLatestResponseFromJson(json);

@override final  String version;
@override@JsonKey(name: 'version_full') final  String? versionFull;
@override@JsonKey(name: 'download_url') final  String downloadUrl;
@override final  String? changelog;

/// Create a copy of CheckLatestResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckLatestResponseCopyWith<_CheckLatestResponse> get copyWith => __$CheckLatestResponseCopyWithImpl<_CheckLatestResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckLatestResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckLatestResponse&&(identical(other.version, version) || other.version == version)&&(identical(other.versionFull, versionFull) || other.versionFull == versionFull)&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl)&&(identical(other.changelog, changelog) || other.changelog == changelog));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,versionFull,downloadUrl,changelog);

@override
String toString() {
  return 'CheckLatestResponse(version: $version, versionFull: $versionFull, downloadUrl: $downloadUrl, changelog: $changelog)';
}


}

/// @nodoc
abstract mixin class _$CheckLatestResponseCopyWith<$Res> implements $CheckLatestResponseCopyWith<$Res> {
  factory _$CheckLatestResponseCopyWith(_CheckLatestResponse value, $Res Function(_CheckLatestResponse) _then) = __$CheckLatestResponseCopyWithImpl;
@override @useResult
$Res call({
 String version,@JsonKey(name: 'version_full') String? versionFull,@JsonKey(name: 'download_url') String downloadUrl, String? changelog
});




}
/// @nodoc
class __$CheckLatestResponseCopyWithImpl<$Res>
    implements _$CheckLatestResponseCopyWith<$Res> {
  __$CheckLatestResponseCopyWithImpl(this._self, this._then);

  final _CheckLatestResponse _self;
  final $Res Function(_CheckLatestResponse) _then;

/// Create a copy of CheckLatestResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? versionFull = freezed,Object? downloadUrl = null,Object? changelog = freezed,}) {
  return _then(_CheckLatestResponse(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,versionFull: freezed == versionFull ? _self.versionFull : versionFull // ignore: cast_nullable_to_non_nullable
as String?,downloadUrl: null == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String,changelog: freezed == changelog ? _self.changelog : changelog // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
