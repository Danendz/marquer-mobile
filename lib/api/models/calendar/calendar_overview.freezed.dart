// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_overview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalendarOverview {

@JsonKey(name: 'tasks', fromJson: _setFromJson) Set<String> get datesWithIncomplete;@JsonKey(name: 'plan_tasks', fromJson: _setFromJson) Set<String> get datesWithPlans;
/// Create a copy of CalendarOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarOverviewCopyWith<CalendarOverview> get copyWith => _$CalendarOverviewCopyWithImpl<CalendarOverview>(this as CalendarOverview, _$identity);

  /// Serializes this CalendarOverview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarOverview&&const DeepCollectionEquality().equals(other.datesWithIncomplete, datesWithIncomplete)&&const DeepCollectionEquality().equals(other.datesWithPlans, datesWithPlans));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(datesWithIncomplete),const DeepCollectionEquality().hash(datesWithPlans));

@override
String toString() {
  return 'CalendarOverview(datesWithIncomplete: $datesWithIncomplete, datesWithPlans: $datesWithPlans)';
}


}

/// @nodoc
abstract mixin class $CalendarOverviewCopyWith<$Res>  {
  factory $CalendarOverviewCopyWith(CalendarOverview value, $Res Function(CalendarOverview) _then) = _$CalendarOverviewCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'tasks', fromJson: _setFromJson) Set<String> datesWithIncomplete,@JsonKey(name: 'plan_tasks', fromJson: _setFromJson) Set<String> datesWithPlans
});




}
/// @nodoc
class _$CalendarOverviewCopyWithImpl<$Res>
    implements $CalendarOverviewCopyWith<$Res> {
  _$CalendarOverviewCopyWithImpl(this._self, this._then);

  final CalendarOverview _self;
  final $Res Function(CalendarOverview) _then;

/// Create a copy of CalendarOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? datesWithIncomplete = null,Object? datesWithPlans = null,}) {
  return _then(_self.copyWith(
datesWithIncomplete: null == datesWithIncomplete ? _self.datesWithIncomplete : datesWithIncomplete // ignore: cast_nullable_to_non_nullable
as Set<String>,datesWithPlans: null == datesWithPlans ? _self.datesWithPlans : datesWithPlans // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarOverview].
extension CalendarOverviewPatterns on CalendarOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarOverview value)  $default,){
final _that = this;
switch (_that) {
case _CalendarOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarOverview value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'tasks', fromJson: _setFromJson)  Set<String> datesWithIncomplete, @JsonKey(name: 'plan_tasks', fromJson: _setFromJson)  Set<String> datesWithPlans)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarOverview() when $default != null:
return $default(_that.datesWithIncomplete,_that.datesWithPlans);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'tasks', fromJson: _setFromJson)  Set<String> datesWithIncomplete, @JsonKey(name: 'plan_tasks', fromJson: _setFromJson)  Set<String> datesWithPlans)  $default,) {final _that = this;
switch (_that) {
case _CalendarOverview():
return $default(_that.datesWithIncomplete,_that.datesWithPlans);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'tasks', fromJson: _setFromJson)  Set<String> datesWithIncomplete, @JsonKey(name: 'plan_tasks', fromJson: _setFromJson)  Set<String> datesWithPlans)?  $default,) {final _that = this;
switch (_that) {
case _CalendarOverview() when $default != null:
return $default(_that.datesWithIncomplete,_that.datesWithPlans);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalendarOverview implements CalendarOverview {
  const _CalendarOverview({@JsonKey(name: 'tasks', fromJson: _setFromJson) required final  Set<String> datesWithIncomplete, @JsonKey(name: 'plan_tasks', fromJson: _setFromJson) required final  Set<String> datesWithPlans}): _datesWithIncomplete = datesWithIncomplete,_datesWithPlans = datesWithPlans;
  factory _CalendarOverview.fromJson(Map<String, dynamic> json) => _$CalendarOverviewFromJson(json);

 final  Set<String> _datesWithIncomplete;
@override@JsonKey(name: 'tasks', fromJson: _setFromJson) Set<String> get datesWithIncomplete {
  if (_datesWithIncomplete is EqualUnmodifiableSetView) return _datesWithIncomplete;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_datesWithIncomplete);
}

 final  Set<String> _datesWithPlans;
@override@JsonKey(name: 'plan_tasks', fromJson: _setFromJson) Set<String> get datesWithPlans {
  if (_datesWithPlans is EqualUnmodifiableSetView) return _datesWithPlans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_datesWithPlans);
}


/// Create a copy of CalendarOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarOverviewCopyWith<_CalendarOverview> get copyWith => __$CalendarOverviewCopyWithImpl<_CalendarOverview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalendarOverviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarOverview&&const DeepCollectionEquality().equals(other._datesWithIncomplete, _datesWithIncomplete)&&const DeepCollectionEquality().equals(other._datesWithPlans, _datesWithPlans));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_datesWithIncomplete),const DeepCollectionEquality().hash(_datesWithPlans));

@override
String toString() {
  return 'CalendarOverview(datesWithIncomplete: $datesWithIncomplete, datesWithPlans: $datesWithPlans)';
}


}

/// @nodoc
abstract mixin class _$CalendarOverviewCopyWith<$Res> implements $CalendarOverviewCopyWith<$Res> {
  factory _$CalendarOverviewCopyWith(_CalendarOverview value, $Res Function(_CalendarOverview) _then) = __$CalendarOverviewCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'tasks', fromJson: _setFromJson) Set<String> datesWithIncomplete,@JsonKey(name: 'plan_tasks', fromJson: _setFromJson) Set<String> datesWithPlans
});




}
/// @nodoc
class __$CalendarOverviewCopyWithImpl<$Res>
    implements _$CalendarOverviewCopyWith<$Res> {
  __$CalendarOverviewCopyWithImpl(this._self, this._then);

  final _CalendarOverview _self;
  final $Res Function(_CalendarOverview) _then;

/// Create a copy of CalendarOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? datesWithIncomplete = null,Object? datesWithPlans = null,}) {
  return _then(_CalendarOverview(
datesWithIncomplete: null == datesWithIncomplete ? _self._datesWithIncomplete : datesWithIncomplete // ignore: cast_nullable_to_non_nullable
as Set<String>,datesWithPlans: null == datesWithPlans ? _self._datesWithPlans : datesWithPlans // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

// dart format on
