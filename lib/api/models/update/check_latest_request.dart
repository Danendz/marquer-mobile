import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_latest_request.freezed.dart';
part 'check_latest_request.g.dart';

@freezed
abstract class CheckLatestRequest with _$CheckLatestRequest {
  const factory CheckLatestRequest({
    required String platform,
    required String channel,
  }) = _CheckLatestRequest;

  factory CheckLatestRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckLatestRequestFromJson(json);
}
