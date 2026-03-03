import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alice/alice.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sample/core/routes/go_router.dart';
import 'core/flavor/flavor_config.dart';
import 'core/network/alice_configuration.dart';
import 'features/Movies/presentation/dashboard_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      final crashlytics = FirebaseCrashlytics.instance;
      final alice = Alice(showNotification: true, showInspectorOnShake: true);
      dioProvider.initAlice(alice);
      final container = ProviderContainer();
      container.listen(connectivityProvider, (previous, next) {
        if (previous != next) {
          final message = (next == ConnectivityResult.none)
              ? "No Internet Connection"
              : "Connected to Internet";

          Fluttertoast.showToast(msg: message);
        }
      }, fireImmediately: true);
      FlutterError.onError = (errorDetails) {
        crashlytics.recordFlutterFatalError(errorDetails);
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]).then((_) {
        runApp(ProviderScope(child: OverlaySupport.global(child: MyApp())));
      });
    },
    (error, stackTrace) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
    },
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final networkConnectivity = ref.watch(connectivityProvider);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        routerConfig: appRouter,
        title: FlavorConfig.appFlavor.toString(),
        themeMode: themeMode,
        theme: ThemeData(
          brightness: Brightness.light,
          colorSchemeSeed: Colors.blue,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorSchemeSeed: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
