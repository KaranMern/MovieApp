import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sample/core/flavor/flavor_config.dart';
import 'package:sample/core/routes/go_router.dart';
import 'package:sample/features/movies/presentation/dashboard_providers.dart';
import 'package:sample/themes/app_themes.dart';

/// Application entry point. Initializes Firebase, env, crash reporting,
/// device orientation, and runs the app inside a guarded zone for uncaught errors.
Future<void> main() async {
  runZonedGuarded(
    () async {
      // Ensures Flutter bindings are initialized before any framework use.
      WidgetsFlutterBinding.ensureInitialized();
      // Initialize Firebase (Crashlytics, etc.).
      await Firebase.initializeApp();
      // Load environment variables from .env file.
      await dotenv.load();
      final crashlytics = FirebaseCrashlytics.instance;
      // Route Flutter framework errors to Crashlytics.
      FlutterError.onError = crashlytics.recordFlutterFatalError;

      // Catch async errors (e.g. from isolates) and report to Crashlytics.
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
      // Allow all orientations (portrait and landscape).
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]).then((_) {
        runApp(
          const ProviderScope(child: OverlaySupport.global(child: MyApp())),
        );
      });
    },
    // Zone error handler: report any uncaught error to Crashlytics.
    (error, stackTrace) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
    },
  );
}

/// Root widget. Wraps the app with Riverpod, watches theme and connectivity,
/// and configures MaterialApp with router and themes.
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // React to theme changes (light/dark).
    final theme = ref.watch(themeProvider);
    // Show toast when connectivity changes (connected / no internet).
    ref.listen(connectivityProvider, (previous, next) {
      if (previous != next) {
        final message = (next == ConnectivityResult.none)
            ? 'No Internet Connection'
            : 'Connected to Internet';

        Fluttertoast.showToast(msg: message);
      }
    });
    return MaterialApp.router(
      routerConfig: ref.read(appRouterProvider),
      title: FlavorConfig.appFlavor.toString(),
      themeMode: theme,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) => child!,
        );
      },
    );
  }
}
