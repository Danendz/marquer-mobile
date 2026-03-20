// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'countdown.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Countdown {

 int get id; String get name;@JsonKey(name: 'target_date') String get targetDate;@JsonKey(name: 'bg_image') String get bgImage;@JsonKey(name: 'is_pinned') bool get isPinned;@JsonKey(name: 'created_at') String get createdAt;@JsonKey(name: 'updated_at') String get updatedAt;
/// Create a copy of Countdown
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CountdownCopyWith<Countdown> get copyWith => _$CountdownCopyWithImpl<Countdown>(this as Countdown, _$identity);

  /// Serializes this Countdown to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Countdown&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.targetDate, targetDate) || other.targetDate == targetDate)&&(identical(other.bgImage, bgImage) || other.bgImage == bgImage)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,targetDate,bgImage,isPinned,createdAt,updatedAt);

@override
String toString() {
  return 'Countdown(id: $id, name: $name, targetDate: $targetDate, bgImage: $bgImage, isPinned: $isPinned, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CountdownCopyWith<$Res>  {
  factory $CountdownCopyWith(Countdown value, $Res Function(Countdown) _then) = _$CountdownCopyWithImpl;
@useResult
$Res call({
 int id, String name,@JsonKey(name: 'target_date') String targetDate,@JsonKey(name: 'bg_image') String bgImage,@JsonKey(name: 'is_pinned') bool isPinned,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt
});




}
/// @nodoc
class _$CountdownCopyWithImpl<$Res>
    implements $CountdownCopyWith<$Res> {
  _$CountdownCopyWithImpl(this._self, this._then);

  final Countdown _self;
  final $Res Function(Countdown) _then;

/// Create a copy of Countdown
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? targetDate = null,Object? bgImage = null,Object? isPinned = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,targetDate: null == targetDate ? _self.targetDate : targetDate // ignore: cast_nullable_to_non_nullable
as String,bgImage: null == bgImage ? _self.bgImage : bgImage // ignore: cast_nullable_to_non_nullable
as String,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Countdown].
extension CountdownPatterns on Countdown {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Countdown value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Countdown() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Countdown value)  $default,){
final _that = this;
switch (_that) {
case _Countdown():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Countdown value)?  $default,){
final _that = this;
switch (_that) {
case _Countdown() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'target_date')  String targetDate, @JsonKey(name: 'bg_image')  String bgImage, @JsonKey(name: 'is_pinned')  bool isPinned, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Countdown() when $default != null:
return $default(_that.id,_that.name,_that.targetDate,_that.bgImage,_that.isPinned,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'target_date')  String targetDate, @JsonKey(name: 'bg_image')  String bgImage, @JsonKey(name: 'is_pinned')  bool isPinned, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Countdown():
return $default(_that.id,_that.name,_that.targetDate,_that.bgImage,_that.isPinned,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name, @JsonKey(name: 'target_date')  String targetDate, @JsonKey(name: 'bg_image')  String bgImage, @JsonKey(name: 'is_pinned')  bool isPinned, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Countdown() when $default != null:
return $default(_that.id,_that.name,_that.targetDate,_that.bgImage,_that.isPinned,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Countdown implements Countdown {
  const _Countdown({required this.id, required this.name, @JsonKey(name: 'target_date') required this.targetDate, @JsonKey(name: 'bg_image') required this.bgImage, @JsonKey(name: 'is_pinned') required this.isPinned, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _Countdown.fromJson(Map<String, dynamic> json) => _$CountdownFromJson(json);

@override final  int id;
@override final  String name;
@override@JsonKey(name: 'target_date') final  String targetDate;
@override@JsonKey(name: 'bg_image') final  String bgImage;
@override@JsonKey(name: 'is_pinned') final  bool isPinned;
@override@JsonKey(name: 'created_at') final  String createdAt;
@override@JsonKey(name: 'updated_at') final  String updatedAt;

/// Create a copy of Countdown
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CountdownCopyWith<_Countdown> get copyWith => __$CountdownCopyWithImpl<_Countdown>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CountdownToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Countdown&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.targetDate, targetDate) || other.targetDate == targetDate)&&(identical(other.bgImage, bgImage) || other.bgImage == bgImage)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,targetDate,bgImage,isPinned,createdAt,updatedAt);

@override
String toString() {
  return 'Countdown(id: $id, name: $name, targetDate: $targetDate, bgImage: $bgImage, isPinned: $isPinned, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CountdownCopyWith<$Res> implements $CountdownCopyWith<$Res> {
  factory _$CountdownCopyWith(_Countdown value, $Res Function(_Countdown) _then) = __$CountdownCopyWithImpl;
@override @useResult
$Res call({
 int id, String name,@JsonKey(name: 'target_date') String targetDate,@JsonKey(name: 'bg_image') String bgImage,@JsonKey(name: 'is_pinned') bool isPinned,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt
});




}
/// @nodoc
class __$CountdownCopyWithImpl<$Res>
    implements _$CountdownCopyWith<$Res> {
  __$CountdownCopyWithImpl(this._self, this._then);

  final _Countdown _self;
  final $Res Function(_Countdown) _then;

/// Create a copy of Countdown
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? targetDate = null,Object? bgImage = null,Object? isPinned = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Countdown(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,targetDate: null == targetDate ? _self.targetDate : targetDate // ignore: cast_nullable_to_non_nullable
as String,bgImage: null == bgImage ? _self.bgImage : bgImage // ignore: cast_nullable_to_non_nullable
as String,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
