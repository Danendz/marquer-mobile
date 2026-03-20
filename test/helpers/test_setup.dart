import 'package:get_it/get_it.dart';
import 'package:marquer/api/api.dart';

import 'mock_api_service.dart';

final getIt = GetIt.instance;

/// Resets GetIt and registers mock singletons for API services.
///
/// Returns a record with the mock instances so tests can stub them directly.
Future<({
  MockApiService api,
  MockApiService authApi,
})> setUpTestEnvironment() async {
  await getIt.reset();

  final mockApi = MockApiService();
  final mockAuthApi = MockApiService();
  getIt.registerSingleton<ApiService>(mockApi, instanceName: 'api');
  getIt.registerSingleton<ApiService>(mockAuthApi, instanceName: 'authApi');

  return (
    api: mockApi,
    authApi: mockAuthApi,
  );
}
