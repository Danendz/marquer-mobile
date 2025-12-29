import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:marquer/api/api.dart';
import 'package:marquer/components/managers/global_manager.dart';
import 'package:marquer/config/theme.dart';
import 'package:marquer/router/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:marquer/services/toast_service.dart';
import 'package:marquer/stores/auth_store.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final auth = AuthStore();
  await auth.loadFromStorage();

  getIt.registerSingleton<AuthStore>(auth);
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(baseUrl: dotenv.get('AUTH_API_URL'), auth: auth),
    instanceName: 'authApi',
  );
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(baseUrl: dotenv.get('MARQUER_API_URL'), auth: auth),
    instanceName: 'api',
  );

  runApp(MyApp(auth: auth));
}

class MyApp extends StatelessWidget {
  final AuthStore auth;

  const MyApp({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    final router = createRouter(auth);
    return MaterialApp.router(
      title: 'Marquer',
      theme: buildTheme(themeLight),
      darkTheme: buildTheme(themeDark),
      themeMode: ThemeMode.dark,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('fr'), Locale('zh', 'CN')],
      routerConfig: router,
      scaffoldMessengerKey: ToastService.messengerKey,
      builder: (context, child) {
        return GlobalManager(
          rootNavKey: rootNavKey,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
