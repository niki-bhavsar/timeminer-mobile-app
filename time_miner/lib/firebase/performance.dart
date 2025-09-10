import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class Performance {
  final _firebasePerformance = FirebasePerformance.instance;

  static Performance? _instance;

  Performance._();

  static Performance get instance => _instance ??= Performance._();

  Future<void> setPerformanceCollectionEnabled() async {
    await _firebasePerformance.setPerformanceCollectionEnabled(!kDebugMode);
    final isEnabled = await _firebasePerformance.isPerformanceCollectionEnabled();
    Logger.root.info("isPerformanceCollectionEnabled: $isEnabled");
  }
}
