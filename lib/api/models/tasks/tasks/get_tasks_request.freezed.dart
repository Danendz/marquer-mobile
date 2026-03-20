// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_tasks_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetTasksRequest {

@JsonKey(name: 'task_category_id') int? get taskCategoryId;@JsonKey(name: 'task_folder_id') int? get taskFolderId; TaskStatus? get status; String? get date;
/// Create a copy of GetTasksRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetTasksRequestCopyWith<GetTasksRequest> get copyWith => _$GetTasksRequestCopyWithImpl<GetTasksRequest>(this as GetTasksRequest, _$identity);

  /// Serializes this GetTasksRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetTasksRequest&&(identical(other.taskCategoryId, taskCategoryId) || other.taskCategoryId == taskCategoryId)&&(identical(other.taskFolderId, taskFolderId) || other.taskFolderId == taskFolderId)&&(identical(other.status, status) || other.status == status)&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,taskCategoryId,taskFolderId,status,date);

@override
String toString() {
  return 'GetTasksRequest(taskCategoryId: $taskCategoryId, taskFolderId: $taskFolderId, status: $status, date: $date)';
}


}

/// @nodoc
abstract mixin class $GetTasksRequestCopyWith<$Res>  {
  factory $GetTasksRequestCopyWith(GetTasksRequest value, $Res Function(GetTasksRequest) _then) = _$GetTasksRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'task_category_id') int? taskCategoryId,@JsonKey(name: 'task_folder_id') int? taskFolderId, TaskStatus? status, String? date
});




}
/// @nodoc
class _$GetTasksRequestCopyWithImpl<$Res>
    implements $GetTasksRequestCopyWith<$Res> {
  _$GetTasksRequestCopyWithImpl(this._self, this._then);

  final GetTasksRequest _self;
  final $Res Function(GetTasksRequest) _then;

/// Create a copy of GetTasksRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? taskCategoryId = freezed,Object? taskFolderId = freezed,Object? status = freezed,Object? date = freezed,}) {
  return _then(_self.copyWith(
taskCategoryId: freezed == taskCategoryId ? _self.taskCategoryId : taskCategoryId // ignore: cast_nullable_to_non_nullable
as int?,taskFolderId: freezed == taskFolderId ? _self.taskFolderId : taskFolderId // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GetTasksRequest].
extension GetTasksRequestPatterns on GetTasksRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetTasksRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetTasksRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetTasksRequest value)  $default,){
final _that = this;
switch (_that) {
case _GetTasksRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetTasksRequest value)?  $default,){
final _that = this;
switch (_that) {
case _GetTasksRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'task_category_id')  int? taskCategoryId, @JsonKey(name: 'task_folder_id')  int? taskFolderId,  TaskStatus? status,  String? date)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetTasksRequest() when $default != null:
return $default(_that.taskCategoryId,_that.taskFolderId,_that.status,_that.date);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'task_category_id')  int? taskCategoryId, @JsonKey(name: 'task_folder_id')  int? taskFolderId,  TaskStatus? status,  String? date)  $default,) {final _that = this;
switch (_that) {
case _GetTasksRequest():
return $default(_that.taskCategoryId,_that.taskFolderId,_that.status,_that.date);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'task_category_id')  int? taskCategoryId, @JsonKey(name: 'task_folder_id')  int? taskFolderId,  TaskStatus? status,  String? date)?  $default,) {final _that = this;
switch (_that) {
case _GetTasksRequest() when $default != null:
return $default(_that.taskCategoryId,_that.taskFolderId,_that.status,_that.date);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _GetTasksRequest implements GetTasksRequest {
  const _GetTasksRequest({@JsonKey(name: 'task_category_id') this.taskCategoryId, @JsonKey(name: 'task_folder_id') this.taskFolderId, this.status, this.date});
  factory _GetTasksRequest.fromJson(Map<String, dynamic> json) => _$GetTasksRequestFromJson(json);

@override@JsonKey(name: 'task_category_id') final  int? taskCategoryId;
@override@JsonKey(name: 'task_folder_id') final  int? taskFolderId;
@override final  TaskStatus? status;
@override final  String? date;

/// Create a copy of GetTasksRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetTasksRequestCopyWith<_GetTasksRequest> get copyWith => __$GetTasksRequestCopyWithImpl<_GetTasksRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetTasksRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetTasksRequest&&(identical(other.taskCategoryId, taskCategoryId) || other.taskCategoryId == taskCategoryId)&&(identical(other.taskFolderId, taskFolderId) || other.taskFolderId == taskFolderId)&&(identical(other.status, status) || other.status == status)&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,taskCategoryId,taskFolderId,status,date);

@override
String toString() {
  return 'GetTasksRequest(taskCategoryId: $taskCategoryId, taskFolderId: $taskFolderId, status: $status, date: $date)';
}


}

/// @nodoc
abstract mixin class _$GetTasksRequestCopyWith<$Res> implements $GetTasksRequestCopyWith<$Res> {
  factory _$GetTasksRequestCopyWith(_GetTasksRequest value, $Res Function(_GetTasksRequest) _then) = __$GetTasksRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'task_category_id') int? taskCategoryId,@JsonKey(name: 'task_folder_id') int? taskFolderId, TaskStatus? status, String? date
});




}
/// @nodoc
class __$GetTasksRequestCopyWithImpl<$Res>
    implements _$GetTasksRequestCopyWith<$Res> {
  __$GetTasksRequestCopyWithImpl(this._self, this._then);

  final _GetTasksRequest _self;
  final $Res Function(_GetTasksRequest) _then;

/// Create a copy of GetTasksRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? taskCategoryId = freezed,Object? taskFolderId = freezed,Object? status = freezed,Object? date = freezed,}) {
  return _then(_GetTasksRequest(
taskCategoryId: freezed == taskCategoryId ? _self.taskCategoryId : taskCategoryId // ignore: cast_nullable_to_non_nullable
as int?,taskFolderId: freezed == taskFolderId ? _self.taskFolderId : taskFolderId // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
