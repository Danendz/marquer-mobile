// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_study_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserStudySettings {

@JsonKey(name: 'default_work_minutes') int get defaultWorkMinutes;@JsonKey(name: 'default_short_break_minutes') int get defaultShortBreakMinutes;@JsonKey(name: 'default_long_break_minutes') int get defaultLongBreakMinutes;@JsonKey(name: 'default_cycles') int get defaultCycles;
/// Create a copy of UserStudySettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserStudySettingsCopyWith<UserStudySettings> get copyWith => _$UserStudySettingsCopyWithImpl<UserStudySettings>(this as UserStudySettings, _$identity);

  /// Serializes this UserStudySettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserStudySettings&&(identical(other.defaultWorkMinutes, defaultWorkMinutes) || other.defaultWorkMinutes == defaultWorkMinutes)&&(identical(other.defaultShortBreakMinutes, defaultShortBreakMinutes) || other.defaultShortBreakMinutes == defaultShortBreakMinutes)&&(identical(other.defaultLongBreakMinutes, defaultLongBreakMinutes) || other.defaultLongBreakMinutes == defaultLongBreakMinutes)&&(identical(other.defaultCycles, defaultCycles) || other.defaultCycles == defaultCycles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,defaultWorkMinutes,defaultShortBreakMinutes,defaultLongBreakMinutes,defaultCycles);

@override
String toString() {
  return 'UserStudySettings(defaultWorkMinutes: $defaultWorkMinutes, defaultShortBreakMinutes: $defaultShortBreakMinutes, defaultLongBreakMinutes: $defaultLongBreakMinutes, defaultCycles: $defaultCycles)';
}


}

/// @nodoc
abstract mixin class $UserStudySettingsCopyWith<$Res>  {
  factory $UserStudySettingsCopyWith(UserStudySettings value, $Res Function(UserStudySettings) _then) = _$UserStudySettingsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'default_work_minutes') int defaultWorkMinutes,@JsonKey(name: 'default_short_break_minutes') int defaultShortBreakMinutes,@JsonKey(name: 'default_long_break_minutes') int defaultLongBreakMinutes,@JsonKey(name: 'default_cycles') int defaultCycles
});




}
/// @nodoc
class _$UserStudySettingsCopyWithImpl<$Res>
    implements $UserStudySettingsCopyWith<$Res> {
  _$UserStudySettingsCopyWithImpl(this._self, this._then);

  final UserStudySettings _self;
  final $Res Function(UserStudySettings) _then;

/// Create a copy of UserStudySettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? defaultWorkMinutes = null,Object? defaultShortBreakMinutes = null,Object? defaultLongBreakMinutes = null,Object? defaultCycles = null,}) {
  return _then(_self.copyWith(
defaultWorkMinutes: null == defaultWorkMinutes ? _self.defaultWorkMinutes : defaultWorkMinutes // ignore: cast_nullable_to_non_nullable
as int,defaultShortBreakMinutes: null == defaultShortBreakMinutes ? _self.defaultShortBreakMinutes : defaultShortBreakMinutes // ignore: cast_nullable_to_non_nullable
as int,defaultLongBreakMinutes: null == defaultLongBreakMinutes ? _self.defaultLongBreakMinutes : defaultLongBreakMinutes // ignore: cast_nullable_to_non_nullable
as int,defaultCycles: null == defaultCycles ? _self.defaultCycles : defaultCycles // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserStudySettings].
extension UserStudySettingsPatterns on UserStudySettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserStudySettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserStudySettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserStudySettings value)  $default,){
final _that = this;
switch (_that) {
case _UserStudySettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserStudySettings value)?  $default,){
final _that = this;
switch (_that) {
case _UserStudySettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'default_work_minutes')  int defaultWorkMinutes, @JsonKey(name: 'default_short_break_minutes')  int defaultShortBreakMinutes, @JsonKey(name: 'default_long_break_minutes')  int defaultLongBreakMinutes, @JsonKey(name: 'default_cycles')  int defaultCycles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserStudySettings() when $default != null:
return $default(_that.defaultWorkMinutes,_that.defaultShortBreakMinutes,_that.defaultLongBreakMinutes,_that.defaultCycles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'default_work_minutes')  int defaultWorkMinutes, @JsonKey(name: 'default_short_break_minutes')  int defaultShortBreakMinutes, @JsonKey(name: 'default_long_break_minutes')  int defaultLongBreakMinutes, @JsonKey(name: 'default_cycles')  int defaultCycles)  $default,) {final _that = this;
switch (_that) {
case _UserStudySettings():
return $default(_that.defaultWorkMinutes,_that.defaultShortBreakMinutes,_that.defaultLongBreakMinutes,_that.defaultCycles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'default_work_minutes')  int defaultWorkMinutes, @JsonKey(name: 'default_short_break_minutes')  int defaultShortBreakMinutes, @JsonKey(name: 'default_long_break_minutes')  int defaultLongBreakMinutes, @JsonKey(name: 'default_cycles')  int defaultCycles)?  $default,) {final _that = this;
switch (_that) {
case _UserStudySettings() when $default != null:
return $default(_that.defaultWorkMinutes,_that.defaultShortBreakMinutes,_that.defaultLongBreakMinutes,_that.defaultCycles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserStudySettings implements UserStudySettings {
  const _UserStudySettings({@JsonKey(name: 'default_work_minutes') this.defaultWorkMinutes = 25, @JsonKey(name: 'default_short_break_minutes') this.defaultShortBreakMinutes = 5, @JsonKey(name: 'default_long_break_minutes') this.defaultLongBreakMinutes = 15, @JsonKey(name: 'default_cycles') this.defaultCycles = 4});
  factory _UserStudySettings.fromJson(Map<String, dynamic> json) => _$UserStudySettingsFromJson(json);

@override@JsonKey(name: 'default_work_minutes') final  int defaultWorkMinutes;
@override@JsonKey(name: 'default_short_break_minutes') final  int defaultShortBreakMinutes;
@override@JsonKey(name: 'default_long_break_minutes') final  int defaultLongBreakMinutes;
@override@JsonKey(name: 'default_cycles') final  int defaultCycles;

/// Create a copy of UserStudySettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserStudySettingsCopyWith<_UserStudySettings> get copyWith => __$UserStudySettingsCopyWithImpl<_UserStudySettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserStudySettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserStudySettings&&(identical(other.defaultWorkMinutes, defaultWorkMinutes) || other.defaultWorkMinutes == defaultWorkMinutes)&&(identical(other.defaultShortBreakMinutes, defaultShortBreakMinutes) || other.defaultShortBreakMinutes == defaultShortBreakMinutes)&&(identical(other.defaultLongBreakMinutes, defaultLongBreakMinutes) || other.defaultLongBreakMinutes == defaultLongBreakMinutes)&&(identical(other.defaultCycles, defaultCycles) || other.defaultCycles == defaultCycles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,defaultWorkMinutes,defaultShortBreakMinutes,defaultLongBreakMinutes,defaultCycles);

@override
String toString() {
  return 'UserStudySettings(defaultWorkMinutes: $defaultWorkMinutes, defaultShortBreakMinutes: $defaultShortBreakMinutes, defaultLongBreakMinutes: $defaultLongBreakMinutes, defaultCycles: $defaultCycles)';
}


}

/// @nodoc
abstract mixin class _$UserStudySettingsCopyWith<$Res> implements $UserStudySettingsCopyWith<$Res> {
  factory _$UserStudySettingsCopyWith(_UserStudySettings value, $Res Function(_UserStudySettings) _then) = __$UserStudySettingsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'default_work_minutes') int defaultWorkMinutes,@JsonKey(name: 'default_short_break_minutes') int defaultShortBreakMinutes,@JsonKey(name: 'default_long_break_minutes') int defaultLongBreakMinutes,@JsonKey(name: 'default_cycles') int defaultCycles
});




}
/// @nodoc
class __$UserStudySettingsCopyWithImpl<$Res>
    implements _$UserStudySettingsCopyWith<$Res> {
  __$UserStudySettingsCopyWithImpl(this._self, this._then);

  final _UserStudySettings _self;
  final $Res Function(_UserStudySettings) _then;

/// Create a copy of UserStudySettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? defaultWorkMinutes = null,Object? defaultShortBreakMinutes = null,Object? defaultLongBreakMinutes = null,Object? defaultCycles = null,}) {
  return _then(_UserStudySettings(
defaultWorkMinutes: null == defaultWorkMinutes ? _self.defaultWorkMinutes : defaultWorkMinutes // ignore: cast_nullable_to_non_nullable
as int,defaultShortBreakMinutes: null == defaultShortBreakMinutes ? _self.defaultShortBreakMinutes : defaultShortBreakMinutes // ignore: cast_nullable_to_non_nullable
as int,defaultLongBreakMinutes: null == defaultLongBreakMinutes ? _self.defaultLongBreakMinutes : defaultLongBreakMinutes // ignore: cast_nullable_to_non_nullable
as int,defaultCycles: null == defaultCycles ? _self.defaultCycles : defaultCycles // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
