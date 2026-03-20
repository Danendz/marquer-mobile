// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_for_date.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlanTaskForDate {

 int get id; String get name;@JsonKey(name: 'sort_order') int get sortOrder;@JsonKey(name: 'start_time') String? get startTime;@JsonKey(name: 'end_time') String? get endTime;@JsonKey(name: 'is_completed') bool get isCompleted;
/// Create a copy of PlanTaskForDate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanTaskForDateCopyWith<PlanTaskForDate> get copyWith => _$PlanTaskForDateCopyWithImpl<PlanTaskForDate>(this as PlanTaskForDate, _$identity);

  /// Serializes this PlanTaskForDate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanTaskForDate&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,sortOrder,startTime,endTime,isCompleted);

@override
String toString() {
  return 'PlanTaskForDate(id: $id, name: $name, sortOrder: $sortOrder, startTime: $startTime, endTime: $endTime, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class $PlanTaskForDateCopyWith<$Res>  {
  factory $PlanTaskForDateCopyWith(PlanTaskForDate value, $Res Function(PlanTaskForDate) _then) = _$PlanTaskForDateCopyWithImpl;
@useResult
$Res call({
 int id, String name,@JsonKey(name: 'sort_order') int sortOrder,@JsonKey(name: 'start_time') String? startTime,@JsonKey(name: 'end_time') String? endTime,@JsonKey(name: 'is_completed') bool isCompleted
});




}
/// @nodoc
class _$PlanTaskForDateCopyWithImpl<$Res>
    implements $PlanTaskForDateCopyWith<$Res> {
  _$PlanTaskForDateCopyWithImpl(this._self, this._then);

  final PlanTaskForDate _self;
  final $Res Function(PlanTaskForDate) _then;

/// Create a copy of PlanTaskForDate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? sortOrder = null,Object? startTime = freezed,Object? endTime = freezed,Object? isCompleted = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanTaskForDate].
extension PlanTaskForDatePatterns on PlanTaskForDate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanTaskForDate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanTaskForDate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanTaskForDate value)  $default,){
final _that = this;
switch (_that) {
case _PlanTaskForDate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanTaskForDate value)?  $default,){
final _that = this;
switch (_that) {
case _PlanTaskForDate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'start_time')  String? startTime, @JsonKey(name: 'end_time')  String? endTime, @JsonKey(name: 'is_completed')  bool isCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanTaskForDate() when $default != null:
return $default(_that.id,_that.name,_that.sortOrder,_that.startTime,_that.endTime,_that.isCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'start_time')  String? startTime, @JsonKey(name: 'end_time')  String? endTime, @JsonKey(name: 'is_completed')  bool isCompleted)  $default,) {final _that = this;
switch (_that) {
case _PlanTaskForDate():
return $default(_that.id,_that.name,_that.sortOrder,_that.startTime,_that.endTime,_that.isCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'start_time')  String? startTime, @JsonKey(name: 'end_time')  String? endTime, @JsonKey(name: 'is_completed')  bool isCompleted)?  $default,) {final _that = this;
switch (_that) {
case _PlanTaskForDate() when $default != null:
return $default(_that.id,_that.name,_that.sortOrder,_that.startTime,_that.endTime,_that.isCompleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanTaskForDate implements PlanTaskForDate {
  const _PlanTaskForDate({required this.id, required this.name, @JsonKey(name: 'sort_order') required this.sortOrder, @JsonKey(name: 'start_time') this.startTime, @JsonKey(name: 'end_time') this.endTime, @JsonKey(name: 'is_completed') required this.isCompleted});
  factory _PlanTaskForDate.fromJson(Map<String, dynamic> json) => _$PlanTaskForDateFromJson(json);

@override final  int id;
@override final  String name;
@override@JsonKey(name: 'sort_order') final  int sortOrder;
@override@JsonKey(name: 'start_time') final  String? startTime;
@override@JsonKey(name: 'end_time') final  String? endTime;
@override@JsonKey(name: 'is_completed') final  bool isCompleted;

/// Create a copy of PlanTaskForDate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanTaskForDateCopyWith<_PlanTaskForDate> get copyWith => __$PlanTaskForDateCopyWithImpl<_PlanTaskForDate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanTaskForDateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanTaskForDate&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,sortOrder,startTime,endTime,isCompleted);

@override
String toString() {
  return 'PlanTaskForDate(id: $id, name: $name, sortOrder: $sortOrder, startTime: $startTime, endTime: $endTime, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class _$PlanTaskForDateCopyWith<$Res> implements $PlanTaskForDateCopyWith<$Res> {
  factory _$PlanTaskForDateCopyWith(_PlanTaskForDate value, $Res Function(_PlanTaskForDate) _then) = __$PlanTaskForDateCopyWithImpl;
@override @useResult
$Res call({
 int id, String name,@JsonKey(name: 'sort_order') int sortOrder,@JsonKey(name: 'start_time') String? startTime,@JsonKey(name: 'end_time') String? endTime,@JsonKey(name: 'is_completed') bool isCompleted
});




}
/// @nodoc
class __$PlanTaskForDateCopyWithImpl<$Res>
    implements _$PlanTaskForDateCopyWith<$Res> {
  __$PlanTaskForDateCopyWithImpl(this._self, this._then);

  final _PlanTaskForDate _self;
  final $Res Function(_PlanTaskForDate) _then;

/// Create a copy of PlanTaskForDate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? sortOrder = null,Object? startTime = freezed,Object? endTime = freezed,Object? isCompleted = null,}) {
  return _then(_PlanTaskForDate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PlanForDate {

 int get id; String get name; String? get color; List<PlanTaskForDate> get tasks;
/// Create a copy of PlanForDate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanForDateCopyWith<PlanForDate> get copyWith => _$PlanForDateCopyWithImpl<PlanForDate>(this as PlanForDate, _$identity);

  /// Serializes this PlanForDate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanForDate&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&const DeepCollectionEquality().equals(other.tasks, tasks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,color,const DeepCollectionEquality().hash(tasks));

@override
String toString() {
  return 'PlanForDate(id: $id, name: $name, color: $color, tasks: $tasks)';
}


}

/// @nodoc
abstract mixin class $PlanForDateCopyWith<$Res>  {
  factory $PlanForDateCopyWith(PlanForDate value, $Res Function(PlanForDate) _then) = _$PlanForDateCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? color, List<PlanTaskForDate> tasks
});




}
/// @nodoc
class _$PlanForDateCopyWithImpl<$Res>
    implements $PlanForDateCopyWith<$Res> {
  _$PlanForDateCopyWithImpl(this._self, this._then);

  final PlanForDate _self;
  final $Res Function(PlanForDate) _then;

/// Create a copy of PlanForDate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? color = freezed,Object? tasks = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<PlanTaskForDate>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanForDate].
extension PlanForDatePatterns on PlanForDate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanForDate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanForDate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanForDate value)  $default,){
final _that = this;
switch (_that) {
case _PlanForDate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanForDate value)?  $default,){
final _that = this;
switch (_that) {
case _PlanForDate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? color,  List<PlanTaskForDate> tasks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanForDate() when $default != null:
return $default(_that.id,_that.name,_that.color,_that.tasks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? color,  List<PlanTaskForDate> tasks)  $default,) {final _that = this;
switch (_that) {
case _PlanForDate():
return $default(_that.id,_that.name,_that.color,_that.tasks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? color,  List<PlanTaskForDate> tasks)?  $default,) {final _that = this;
switch (_that) {
case _PlanForDate() when $default != null:
return $default(_that.id,_that.name,_that.color,_that.tasks);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _PlanForDate implements PlanForDate {
  const _PlanForDate({required this.id, required this.name, this.color, required final  List<PlanTaskForDate> tasks}): _tasks = tasks;
  factory _PlanForDate.fromJson(Map<String, dynamic> json) => _$PlanForDateFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? color;
 final  List<PlanTaskForDate> _tasks;
@override List<PlanTaskForDate> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}


/// Create a copy of PlanForDate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanForDateCopyWith<_PlanForDate> get copyWith => __$PlanForDateCopyWithImpl<_PlanForDate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanForDateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanForDate&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&const DeepCollectionEquality().equals(other._tasks, _tasks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,color,const DeepCollectionEquality().hash(_tasks));

@override
String toString() {
  return 'PlanForDate(id: $id, name: $name, color: $color, tasks: $tasks)';
}


}

/// @nodoc
abstract mixin class _$PlanForDateCopyWith<$Res> implements $PlanForDateCopyWith<$Res> {
  factory _$PlanForDateCopyWith(_PlanForDate value, $Res Function(_PlanForDate) _then) = __$PlanForDateCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? color, List<PlanTaskForDate> tasks
});




}
/// @nodoc
class __$PlanForDateCopyWithImpl<$Res>
    implements _$PlanForDateCopyWith<$Res> {
  __$PlanForDateCopyWithImpl(this._self, this._then);

  final _PlanForDate _self;
  final $Res Function(_PlanForDate) _then;

/// Create a copy of PlanForDate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? color = freezed,Object? tasks = null,}) {
  return _then(_PlanForDate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<PlanTaskForDate>,
  ));
}


}

// dart format on
