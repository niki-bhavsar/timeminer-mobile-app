import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class Analytics {
  final _firebaseAnalytics = FirebaseAnalytics.instance;

  static Analytics? _instance;

  Analytics._();

  static Analytics get instance => _instance ??= Analytics._();

  Future<void> setAnalyticsCollectionEnabled() async {
    await _firebaseAnalytics.setAnalyticsCollectionEnabled(!kDebugMode);
    Logger.root.info("isAnalyticsCollectionEnabled: ${!kDebugMode}");
  }

  Future<void> logScreenView(String name, String route) async {
    await _firebaseAnalytics.logScreenView(screenName: name, screenClass: route);
    Logger.root.info("Logged screen view: $name");
  }

  Future<void> logEvent(String name) async {
    await _firebaseAnalytics.logEvent(name: name);
    Logger.root.info("Logged event: $name");
  }
}

enum AnalyticsScreen {
  // Authentication
  distributorCode("DistributorCode", "DistributorCodeScreen"),
  login("Login", "LoginScreen");

  final String name;
  final String screen;

  const AnalyticsScreen(this.name, this.screen);

  /// Logs a screen view
  Future<void> logScreenView() async {
    await FirebaseAnalytics.instance.logScreenView(screenName: name, screenClass: screen);
  }
}

enum AnalyticsEvent {
  login("login"),
  logout("logout");

  final String name;

  const AnalyticsEvent(this.name);

  Future<void> logEvent() async {
    await Analytics.instance.logEvent(name);
  }
}
