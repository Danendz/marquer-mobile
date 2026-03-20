import 'package:get_it/get_it.dart';
import 'package:marquer/api/api.dart';
import 'package:marquer/stores/auth_store.dart';
import 'package:marquer/stores/user_store.dart';

import 'mock_api_service.dart';
import 'mock_stores.dart';

final getIt = GetIt.instance;

/// Resets GetIt and registers mock singletons for all core dependencies.
///
/// Returns a record with the mock instances so tests can stub them directly.
({
  MockAuthStore authStore,
  MockUserStore userStore,
  MockApiService api,
  MockApiService authApi,
}) setUpTestEnvironment() {
  getIt.reset();

  final mockAuthStore = MockAuthStore();
  final mockUserStore = MockUserStore();
  getIt.registerSingleton<AuthStore>(mockAuthStore);
  getIt.registerSingleton<UserStore>(mockUserStore);

  final mockApi = MockApiService();
  final mockAuthApi = MockApiService();
  getIt.registerSingleton<ApiService>(mockApi, instanceName: 'api');
  getIt.registerSingleton<ApiService>(mockAuthApi, instanceName: 'authApi');

  return (
    authStore: mockAuthStore,
    userStore: mockUserStore,
    api: mockApi,
    authApi: mockAuthApi,
  );
}
