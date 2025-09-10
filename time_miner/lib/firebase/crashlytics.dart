import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class Crashlytics {
  final _firebaseCrashlytics = FirebaseCrashlytics.instance;

  static Crashlytics? _instance;

  Crashlytics._();

  static Crashlytics get instance => _instance ??= Crashlytics._();

  Future<void> setCrashlyticsCollectionEnabled() async {
    if (kDebugMode) {
      // Force disable Crashlytics collection while doing every day development.
      // Temporarily toggle this to true if you want to test crash reporting in your app.
      await _firebaseCrashlytics.setCrashlyticsCollectionEnabled(false);
    } else {
      await _firebaseCrashlytics.setCrashlyticsCollectionEnabled(true);
      // Pass all uncaught errors from the framework to Crashlytics.
      FlutterError.onError = _firebaseCrashlytics.recordFlutterError;
    }

    final isEnabled = _firebaseCrashlytics.isCrashlyticsCollectionEnabled;
    Logger.root.info("isCrashlyticsCollectionEnabled: $isEnabled");
  }

  void setFireBaseLog(String message) {
    _firebaseCrashlytics.log(message);
  }

  void forceCrash() {
    _firebaseCrashlytics.crash();
  }
}
