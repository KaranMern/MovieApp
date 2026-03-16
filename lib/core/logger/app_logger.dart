import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'talker_crashlytics_observer.dart';

class AppLogger {

  static final talker = TalkerFlutter.init(
    observer: TalkerCrashlyticsObserver(
      FirebaseCrashlytics.instance,
    ),
  );

  static void debug(String message) {
    talker.debug(message);
  }

  static void info(String message) {
    talker.info(message);
  }

  static void error(Object error, StackTrace stack) {
    talker.handle(error, stack);
  }
}