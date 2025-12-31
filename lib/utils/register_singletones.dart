import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:marquer/api/api.dart';
import 'package:marquer/stores/auth_store.dart';
import 'package:marquer/stores/user_store.dart';

final getIt = GetIt.instance;

void registerStores() {
  final userStore = UserStore();
  final authStore = AuthStore();

  getIt.registerSingleton<UserStore>(userStore);
  getIt.registerSingleton<AuthStore>(authStore);
}

void registerApi() {
  final auth = getIt<AuthStore>();

  getIt.registerLazySingleton<ApiService>(
        () => ApiService(baseUrl: dotenv.get('AUTH_API_URL'), auth: auth),
    instanceName: 'authApi',
  );
  getIt.registerLazySingleton<ApiService>(
        () => ApiService(baseUrl: dotenv.get('MARQUER_API_URL'), auth: auth),
    instanceName: 'api',
  );
}

GetIt registerSingletones() {
  registerStores();
  registerApi();

  return getIt;
}