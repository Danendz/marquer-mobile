// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StudyStats {

@JsonKey(name: 'today_total_seconds') int get todayTotalSeconds; List<StudySession> get sessions;
/// Create a copy of StudyStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyStatsCopyWith<StudyStats> get copyWith => _$StudyStatsCopyWithImpl<StudyStats>(this as StudyStats, _$identity);

  /// Serializes this StudyStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyStats&&(identical(other.todayTotalSeconds, todayTotalSeconds) || other.todayTotalSeconds == todayTotalSeconds)&&const DeepCollectionEquality().equals(other.sessions, sessions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,todayTotalSeconds,const DeepCollectionEquality().hash(sessions));

@override
String toString() {
  return 'StudyStats(todayTotalSeconds: $todayTotalSeconds, sessions: $sessions)';
}


}

/// @nodoc
abstract mixin class $StudyStatsCopyWith<$Res>  {
  factory $StudyStatsCopyWith(StudyStats value, $Res Function(StudyStats) _then) = _$StudyStatsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'today_total_seconds') int todayTotalSeconds, List<StudySession> sessions
});




}
/// @nodoc
class _$StudyStatsCopyWithImpl<$Res>
    implements $StudyStatsCopyWith<$Res> {
  _$StudyStatsCopyWithImpl(this._self, this._then);

  final StudyStats _self;
  final $Res Function(StudyStats) _then;

/// Create a copy of StudyStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? todayTotalSeconds = null,Object? sessions = null,}) {
  return _then(_self.copyWith(
todayTotalSeconds: null == todayTotalSeconds ? _self.todayTotalSeconds : todayTotalSeconds // ignore: cast_nullable_to_non_nullable
as int,sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<StudySession>,
  ));
}

}


/// Adds pattern-matching-related methods to [StudyStats].
extension StudyStatsPatterns on StudyStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyStats value)  $default,){
final _that = this;
switch (_that) {
case _StudyStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyStats value)?  $default,){
final _that = this;
switch (_that) {
case _StudyStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'today_total_seconds')  int todayTotalSeconds,  List<StudySession> sessions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyStats() when $default != null:
return $default(_that.todayTotalSeconds,_that.sessions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'today_total_seconds')  int todayTotalSeconds,  List<StudySession> sessions)  $default,) {final _that = this;
switch (_that) {
case _StudyStats():
return $default(_that.todayTotalSeconds,_that.sessions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'today_total_seconds')  int todayTotalSeconds,  List<StudySession> sessions)?  $default,) {final _that = this;
switch (_that) {
case _StudyStats() when $default != null:
return $default(_that.todayTotalSeconds,_that.sessions);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _StudyStats implements StudyStats {
  const _StudyStats({@JsonKey(name: 'today_total_seconds') this.todayTotalSeconds = 0, required final  List<StudySession> sessions}): _sessions = sessions;
  factory _StudyStats.fromJson(Map<String, dynamic> json) => _$StudyStatsFromJson(json);

@override@JsonKey(name: 'today_total_seconds') final  int todayTotalSeconds;
 final  List<StudySession> _sessions;
@override List<StudySession> get sessions {
  if (_sessions is EqualUnmodifiableListView) return _sessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sessions);
}


/// Create a copy of StudyStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyStatsCopyWith<_StudyStats> get copyWith => __$StudyStatsCopyWithImpl<_StudyStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudyStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyStats&&(identical(other.todayTotalSeconds, todayTotalSeconds) || other.todayTotalSeconds == todayTotalSeconds)&&const DeepCollectionEquality().equals(other._sessions, _sessions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,todayTotalSeconds,const DeepCollectionEquality().hash(_sessions));

@override
String toString() {
  return 'StudyStats(todayTotalSeconds: $todayTotalSeconds, sessions: $sessions)';
}


}

/// @nodoc
abstract mixin class _$StudyStatsCopyWith<$Res> implements $StudyStatsCopyWith<$Res> {
  factory _$StudyStatsCopyWith(_StudyStats value, $Res Function(_StudyStats) _then) = __$StudyStatsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'today_total_seconds') int todayTotalSeconds, List<StudySession> sessions
});




}
/// @nodoc
class __$StudyStatsCopyWithImpl<$Res>
    implements _$StudyStatsCopyWith<$Res> {
  __$StudyStatsCopyWithImpl(this._self, this._then);

  final _StudyStats _self;
  final $Res Function(_StudyStats) _then;

/// Create a copy of StudyStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? todayTotalSeconds = null,Object? sessions = null,}) {
  return _then(_StudyStats(
todayTotalSeconds: null == todayTotalSeconds ? _self.todayTotalSeconds : todayTotalSeconds // ignore: cast_nullable_to_non_nullable
as int,sessions: null == sessions ? _self._sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<StudySession>,
  ));
}


}

// dart format on
