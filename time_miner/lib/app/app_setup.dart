import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:time_miner/di/di_modules.dart';
import 'package:time_miner/firebase/analytics.dart';
import 'package:time_miner/firebase/crashlytics.dart';
import 'package:time_miner/firebase/performance.dart';

final appSetup = AppSetup();

class AppSetup {
  Future preLaunchSetup() async {
    _setupLogging();

    await registerGetItModules();

    await dotenv.load(fileName: ".env");

    _setOrientations();

    // await _setupFirebase(); // will setup later once firebase project setup done
  }

  Future postLaunchSetup() async {
    await _postSetupDeviceLocaleConfig();
  }

  // Set portrait mode only
  void _setOrientations() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void _setupLogging() {
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      if (kDebugMode) {
        print('${record.level.name}: ${record.time}: ${record.message}');
      }
    });
  }

  /// Setup Firebase and Crashlytics
  Future<void> _setupFirebase() async {
    await Firebase.initializeApp();
    await Crashlytics.instance.setCrashlyticsCollectionEnabled();
    await Performance.instance.setPerformanceCollectionEnabled();
    await Analytics.instance.setAnalyticsCollectionEnabled();
  }

  /// Set device locale for date-time formatting
  Future<void> _postSetupDeviceLocaleConfig() async {
    Intl.defaultLocale = "en";
    await initializeDateFormatting("en");
  }
}
