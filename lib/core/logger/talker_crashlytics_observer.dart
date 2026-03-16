import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerCrashlyticsObserver extends TalkerObserver {
  final FirebaseCrashlytics crashlytics;

  TalkerCrashlyticsObserver(this.crashlytics);

  @override
  void onError(TalkerError err) {
    crashlytics.recordError(
      err.error ?? err,           // TalkerError wraps Dart Errors
      err.stackTrace ?? StackTrace.current,
      reason: err.message,
      fatal: false,
    );
    crashlytics.sendUnsentReports();
  }

  @override
  void onException(TalkerException err) {
    print('🔥 Crashlytics recording: ${err.exception}'); // ← add this
    crashlytics.recordError(
      err.exception ?? err,
      err.stackTrace ?? StackTrace.current,
      reason: err.message,
      fatal: true,
    );
    crashlytics.sendUnsentReports();
  }

  @override
  void onLog(TalkerData log) {
    crashlytics.log(log.generateTextMessage());
  }
}