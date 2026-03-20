import 'package:get_it/get_it.dart';
import 'package:marquer/api/api.dart';
import 'package:marquer/api/models/update/check_latest_request.dart';
import 'package:marquer/api/models/update/check_latest_response.dart';

import '../models/model_parser.dart';

final getIt = GetIt.instance;

class UpdateService {
  final api = getIt<ApiService>(instanceName: 'api');

  Future<CheckLatestResponse> checkLatest(CheckLatestRequest request) async {
    final resp = await api.get<CheckLatestResponse>(
      '/app/latest',
      fromJsonT: (json) => ModelParser.objectFromJson(json, CheckLatestResponse.fromJson),
    );

    return resp.data;
  }
}
