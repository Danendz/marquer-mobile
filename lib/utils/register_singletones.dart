import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:marquer/api/api.dart';

final getIt = GetIt.instance;

/// Callbacks that connect API services to the auth provider.
/// Set these in main() before registering singletons.
late String? Function() authGetToken;
late Future<void> Function(String token) authSetToken;
late Future<void> Function() authLogout;

void registerApi() {
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(
      baseUrl: dotenv.get('AUTH_API_URL'),
      getToken: authGetToken,
      setToken: authSetToken,
      logout: authLogout,
    ),
    instanceName: 'authApi',
  );
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(
      baseUrl: dotenv.get('MARQUER_API_URL'),
      getToken: authGetToken,
      setToken: authSetToken,
      logout: authLogout,
    ),
    instanceName: 'api',
  );
}

GetIt registerSingletons() {
  registerApi();
  return getIt;
}
