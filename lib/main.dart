import 'dart:async';
import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay_support/overlay_support.dart';

import 'core/logger/app_logger.dart';
import 'core/flavor/flavor_config.dart';
import 'core/routes/go_router.dart';
import 'features/movies/presentation/dashboard_providers.dart';
import 'themes/app_themes.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp();

      // IMPORTANT: enable Crashlytics in debug
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

      await dotenv.load();

      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      PlatformDispatcher.instance.onError = (error, stack) {
        AppLogger.error(error, stack);
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);

      runApp(const ProviderScope(child: OverlaySupport.global(child: MyApp())));
      // AppLogger.error(
      //   Exception("Crashlytics Test"),
      //   StackTrace.current,
      // );
      },
    (error, stack) {
      AppLogger.error(error, stack);
      // FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    },
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

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
