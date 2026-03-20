// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_countdown_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateCountdownRequest {

 String? get name;@JsonKey(name: 'target_date') String? get targetDate;@JsonKey(name: 'is_pinned') bool? get isPinned;@JsonKey(name: 'bg_image') String? get bgImage;
/// Create a copy of UpdateCountdownRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateCountdownRequestCopyWith<UpdateCountdownRequest> get copyWith => _$UpdateCountdownRequestCopyWithImpl<UpdateCountdownRequest>(this as UpdateCountdownRequest, _$identity);

  /// Serializes this UpdateCountdownRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateCountdownRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.targetDate, targetDate) || other.targetDate == targetDate)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.bgImage, bgImage) || other.bgImage == bgImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,targetDate,isPinned,bgImage);

@override
String toString() {
  return 'UpdateCountdownRequest(name: $name, targetDate: $targetDate, isPinned: $isPinned, bgImage: $bgImage)';
}


}

/// @nodoc
abstract mixin class $UpdateCountdownRequestCopyWith<$Res>  {
  factory $UpdateCountdownRequestCopyWith(UpdateCountdownRequest value, $Res Function(UpdateCountdownRequest) _then) = _$UpdateCountdownRequestCopyWithImpl;
@useResult
$Res call({
 String? name,@JsonKey(name: 'target_date') String? targetDate,@JsonKey(name: 'is_pinned') bool? isPinned,@JsonKey(name: 'bg_image') String? bgImage
});




}
/// @nodoc
class _$UpdateCountdownRequestCopyWithImpl<$Res>
    implements $UpdateCountdownRequestCopyWith<$Res> {
  _$UpdateCountdownRequestCopyWithImpl(this._self, this._then);

  final UpdateCountdownRequest _self;
  final $Res Function(UpdateCountdownRequest) _then;

/// Create a copy of UpdateCountdownRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? targetDate = freezed,Object? isPinned = freezed,Object? bgImage = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,targetDate: freezed == targetDate ? _self.targetDate : targetDate // ignore: cast_nullable_to_non_nullable
as String?,isPinned: freezed == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool?,bgImage: freezed == bgImage ? _self.bgImage : bgImage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateCountdownRequest].
extension UpdateCountdownRequestPatterns on UpdateCountdownRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateCountdownRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateCountdownRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateCountdownRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateCountdownRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateCountdownRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateCountdownRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name, @JsonKey(name: 'target_date')  String? targetDate, @JsonKey(name: 'is_pinned')  bool? isPinned, @JsonKey(name: 'bg_image')  String? bgImage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateCountdownRequest() when $default != null:
return $default(_that.name,_that.targetDate,_that.isPinned,_that.bgImage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name, @JsonKey(name: 'target_date')  String? targetDate, @JsonKey(name: 'is_pinned')  bool? isPinned, @JsonKey(name: 'bg_image')  String? bgImage)  $default,) {final _that = this;
switch (_that) {
case _UpdateCountdownRequest():
return $default(_that.name,_that.targetDate,_that.isPinned,_that.bgImage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name, @JsonKey(name: 'target_date')  String? targetDate, @JsonKey(name: 'is_pinned')  bool? isPinned, @JsonKey(name: 'bg_image')  String? bgImage)?  $default,) {final _that = this;
switch (_that) {
case _UpdateCountdownRequest() when $default != null:
return $default(_that.name,_that.targetDate,_that.isPinned,_that.bgImage);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _UpdateCountdownRequest implements UpdateCountdownRequest {
  const _UpdateCountdownRequest({this.name, @JsonKey(name: 'target_date') this.targetDate, @JsonKey(name: 'is_pinned') this.isPinned, @JsonKey(name: 'bg_image') this.bgImage});
  factory _UpdateCountdownRequest.fromJson(Map<String, dynamic> json) => _$UpdateCountdownRequestFromJson(json);

@override final  String? name;
@override@JsonKey(name: 'target_date') final  String? targetDate;
@override@JsonKey(name: 'is_pinned') final  bool? isPinned;
@override@JsonKey(name: 'bg_image') final  String? bgImage;

/// Create a copy of UpdateCountdownRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateCountdownRequestCopyWith<_UpdateCountdownRequest> get copyWith => __$UpdateCountdownRequestCopyWithImpl<_UpdateCountdownRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateCountdownRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateCountdownRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.targetDate, targetDate) || other.targetDate == targetDate)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.bgImage, bgImage) || other.bgImage == bgImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,targetDate,isPinned,bgImage);

@override
String toString() {
  return 'UpdateCountdownRequest(name: $name, targetDate: $targetDate, isPinned: $isPinned, bgImage: $bgImage)';
}


}

/// @nodoc
abstract mixin class _$UpdateCountdownRequestCopyWith<$Res> implements $UpdateCountdownRequestCopyWith<$Res> {
  factory _$UpdateCountdownRequestCopyWith(_UpdateCountdownRequest value, $Res Function(_UpdateCountdownRequest) _then) = __$UpdateCountdownRequestCopyWithImpl;
@override @useResult
$Res call({
 String? name,@JsonKey(name: 'target_date') String? targetDate,@JsonKey(name: 'is_pinned') bool? isPinned,@JsonKey(name: 'bg_image') String? bgImage
});




}
/// @nodoc
class __$UpdateCountdownRequestCopyWithImpl<$Res>
    implements _$UpdateCountdownRequestCopyWith<$Res> {
  __$UpdateCountdownRequestCopyWithImpl(this._self, this._then);

  final _UpdateCountdownRequest _self;
  final $Res Function(_UpdateCountdownRequest) _then;

/// Create a copy of UpdateCountdownRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? targetDate = freezed,Object? isPinned = freezed,Object? bgImage = freezed,}) {
  return _then(_UpdateCountdownRequest(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,targetDate: freezed == targetDate ? _self.targetDate : targetDate // ignore: cast_nullable_to_non_nullable
as String?,isPinned: freezed == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool?,bgImage: freezed == bgImage ? _self.bgImage : bgImage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
