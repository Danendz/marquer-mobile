// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'complete_study_session_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompleteStudySessionRequest {

@JsonKey(name: 'actual_duration_seconds') int get actualDurationSeconds;@JsonKey(name: 'pomodoro_completed_cycles') int? get pomodoroCompletedCycles;
/// Create a copy of CompleteStudySessionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompleteStudySessionRequestCopyWith<CompleteStudySessionRequest> get copyWith => _$CompleteStudySessionRequestCopyWithImpl<CompleteStudySessionRequest>(this as CompleteStudySessionRequest, _$identity);

  /// Serializes this CompleteStudySessionRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompleteStudySessionRequest&&(identical(other.actualDurationSeconds, actualDurationSeconds) || other.actualDurationSeconds == actualDurationSeconds)&&(identical(other.pomodoroCompletedCycles, pomodoroCompletedCycles) || other.pomodoroCompletedCycles == pomodoroCompletedCycles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,actualDurationSeconds,pomodoroCompletedCycles);

@override
String toString() {
  return 'CompleteStudySessionRequest(actualDurationSeconds: $actualDurationSeconds, pomodoroCompletedCycles: $pomodoroCompletedCycles)';
}


}

/// @nodoc
abstract mixin class $CompleteStudySessionRequestCopyWith<$Res>  {
  factory $CompleteStudySessionRequestCopyWith(CompleteStudySessionRequest value, $Res Function(CompleteStudySessionRequest) _then) = _$CompleteStudySessionRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'actual_duration_seconds') int actualDurationSeconds,@JsonKey(name: 'pomodoro_completed_cycles') int? pomodoroCompletedCycles
});




}
/// @nodoc
class _$CompleteStudySessionRequestCopyWithImpl<$Res>
    implements $CompleteStudySessionRequestCopyWith<$Res> {
  _$CompleteStudySessionRequestCopyWithImpl(this._self, this._then);

  final CompleteStudySessionRequest _self;
  final $Res Function(CompleteStudySessionRequest) _then;

/// Create a copy of CompleteStudySessionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? actualDurationSeconds = null,Object? pomodoroCompletedCycles = freezed,}) {
  return _then(_self.copyWith(
actualDurationSeconds: null == actualDurationSeconds ? _self.actualDurationSeconds : actualDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,pomodoroCompletedCycles: freezed == pomodoroCompletedCycles ? _self.pomodoroCompletedCycles : pomodoroCompletedCycles // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CompleteStudySessionRequest].
extension CompleteStudySessionRequestPatterns on CompleteStudySessionRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompleteStudySessionRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompleteStudySessionRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompleteStudySessionRequest value)  $default,){
final _that = this;
switch (_that) {
case _CompleteStudySessionRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompleteStudySessionRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CompleteStudySessionRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'actual_duration_seconds')  int actualDurationSeconds, @JsonKey(name: 'pomodoro_completed_cycles')  int? pomodoroCompletedCycles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompleteStudySessionRequest() when $default != null:
return $default(_that.actualDurationSeconds,_that.pomodoroCompletedCycles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'actual_duration_seconds')  int actualDurationSeconds, @JsonKey(name: 'pomodoro_completed_cycles')  int? pomodoroCompletedCycles)  $default,) {final _that = this;
switch (_that) {
case _CompleteStudySessionRequest():
return $default(_that.actualDurationSeconds,_that.pomodoroCompletedCycles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'actual_duration_seconds')  int actualDurationSeconds, @JsonKey(name: 'pomodoro_completed_cycles')  int? pomodoroCompletedCycles)?  $default,) {final _that = this;
switch (_that) {
case _CompleteStudySessionRequest() when $default != null:
return $default(_that.actualDurationSeconds,_that.pomodoroCompletedCycles);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _CompleteStudySessionRequest implements CompleteStudySessionRequest {
  const _CompleteStudySessionRequest({@JsonKey(name: 'actual_duration_seconds') required this.actualDurationSeconds, @JsonKey(name: 'pomodoro_completed_cycles') this.pomodoroCompletedCycles});
  factory _CompleteStudySessionRequest.fromJson(Map<String, dynamic> json) => _$CompleteStudySessionRequestFromJson(json);

@override@JsonKey(name: 'actual_duration_seconds') final  int actualDurationSeconds;
@override@JsonKey(name: 'pomodoro_completed_cycles') final  int? pomodoroCompletedCycles;

/// Create a copy of CompleteStudySessionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompleteStudySessionRequestCopyWith<_CompleteStudySessionRequest> get copyWith => __$CompleteStudySessionRequestCopyWithImpl<_CompleteStudySessionRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompleteStudySessionRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompleteStudySessionRequest&&(identical(other.actualDurationSeconds, actualDurationSeconds) || other.actualDurationSeconds == actualDurationSeconds)&&(identical(other.pomodoroCompletedCycles, pomodoroCompletedCycles) || other.pomodoroCompletedCycles == pomodoroCompletedCycles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,actualDurationSeconds,pomodoroCompletedCycles);

@override
String toString() {
  return 'CompleteStudySessionRequest(actualDurationSeconds: $actualDurationSeconds, pomodoroCompletedCycles: $pomodoroCompletedCycles)';
}


}

/// @nodoc
abstract mixin class _$CompleteStudySessionRequestCopyWith<$Res> implements $CompleteStudySessionRequestCopyWith<$Res> {
  factory _$CompleteStudySessionRequestCopyWith(_CompleteStudySessionRequest value, $Res Function(_CompleteStudySessionRequest) _then) = __$CompleteStudySessionRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'actual_duration_seconds') int actualDurationSeconds,@JsonKey(name: 'pomodoro_completed_cycles') int? pomodoroCompletedCycles
});




}
/// @nodoc
class __$CompleteStudySessionRequestCopyWithImpl<$Res>
    implements _$CompleteStudySessionRequestCopyWith<$Res> {
  __$CompleteStudySessionRequestCopyWithImpl(this._self, this._then);

  final _CompleteStudySessionRequest _self;
  final $Res Function(_CompleteStudySessionRequest) _then;

/// Create a copy of CompleteStudySessionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? actualDurationSeconds = null,Object? pomodoroCompletedCycles = freezed,}) {
  return _then(_CompleteStudySessionRequest(
actualDurationSeconds: null == actualDurationSeconds ? _self.actualDurationSeconds : actualDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,pomodoroCompletedCycles: freezed == pomodoroCompletedCycles ? _self.pomodoroCompletedCycles : pomodoroCompletedCycles // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
