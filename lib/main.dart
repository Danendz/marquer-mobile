import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/components/managers/global_manager.dart';
import 'package:marquer/config/theme.dart';
import 'package:marquer/router/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:marquer/services/toast_service.dart';
import 'package:marquer/stores/auth_store.dart';
import 'package:marquer/stores/user_store.dart';
import 'package:marquer/utils/register_singletones.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final getIt = registerSingletons();

  await getIt<AuthStore>().loadFromStorage();

  runApp(
    ProviderScope(
      child: MultiProvider(
        providers: [ChangeNotifierProvider.value(value: getIt<UserStore>())],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = createRouter();
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
