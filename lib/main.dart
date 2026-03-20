import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/components/managers/global_manager.dart';
import 'package:marquer/config/theme.dart';
import 'package:marquer/providers/auth/auth_provider.dart';
import 'package:marquer/router/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:marquer/services/toast_service.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:marquer/services/foreground_timer_service.dart';
import 'package:marquer/utils/register_singletones.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initForegroundService();
  FlutterForegroundTask.initCommunicationPort();
  await dotenv.load(fileName: ".env");

  await SentryFlutter.init(
    (options) {
      options.dsn = dotenv.get('GLITCHTIP_DSN', fallback: '');
      options.tracesSampleRate = 0.01;
      options.enableAutoSessionTracking = false;
      options.beforeSend = (event, hint) {
        final request = event.request;
        if (request == null) return event;
        final rawUrl = request.url ?? '';
        final scrubbedUrl = Uri.tryParse(rawUrl)?.replace(query: '').toString() ?? rawUrl;
        event.request = SentryRequest(
          url: scrubbedUrl,
          method: request.method,
          queryString: null,
          headers: {},
          data: null,
        );
        return event;
      };
    },
    appRunner: () async {
      // Create the Riverpod container so auth callbacks can read/write state.
      final container = ProviderContainer();

      // Wire auth callbacks for API services before registration.
      authGetToken = () => container.read(authProvider).token;
      authSetToken = (token) => container.read(authProvider.notifier).setToken(token);
      authLogout = () => container.read(authProvider.notifier).logout();
      registerSingletons();

      // Load persisted auth state (token + user fetch).
      await container.read(authProvider.notifier).loadFromStorage();

      runApp(
        UncontrolledProviderScope(
          container: container,
          child: const MyApp(),
        ),
      );
    },
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late final _refreshNotifier = AuthRefreshNotifier(ref);
  late final _router = createRouter(ref, _refreshNotifier);

  @override
  void dispose() {
    _router.dispose();
    _refreshNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Marquer',
      theme: buildTheme(themeLight),
      darkTheme: buildTheme(themeDark),
      themeMode: ThemeMode.light,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('fr'), Locale('zh', 'CN')],
      routerConfig: _router,
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
