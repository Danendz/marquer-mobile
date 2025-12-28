import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marquer/config/theme.dart';
import 'package:marquer/router/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:marquer/services/toast_service.dart';
import 'package:marquer/stores/auth_store.dart';

final auth = AuthStore();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await auth.loadFromStorage();
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
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
        Locale('zh', 'CN'),
      ],
      routerConfig: router,
      scaffoldMessengerKey: ToastService.messengerKey,
    );
  }
}
