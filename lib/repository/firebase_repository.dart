import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';

typedef FirebaseInitFunction = Future<FirebaseApp> Function({
  String? name,
  FirebaseOptions? options,
});

typedef AnalyticsCurrentScreenLogEventFunction = Future<void> Function({
  required String? screenName,
  String screenClassOverride,
  AnalyticsCallOptions? callOptions,
});

typedef AnalyticsLogEventFunction = Future<void> Function({
  required String name,
  Map<String, Object?>? parameters,
  AnalyticsCallOptions? callOptions,
});

typedef RecordErrorFunction = Future<void> Function(
    dynamic exception, StackTrace? stack,
    {dynamic reason,
    Iterable<DiagnosticsNode> information,
    bool? printDetails,
    bool fatal});

typedef RecordFlutterErrorFunction = Future<void>
    Function(FlutterErrorDetails flutterErrorDetails, {bool fatal});

typedef SetAnalyticsUserIdFunction = Future<void> Function({
  String? id,
  AnalyticsCallOptions? callOptions,
});

typedef SetCrashlyticsIdFunction = Future<void> Function(String identifier);

/// singleton
class FirebaseRepository {
  static FirebaseRepository? _instance;
  factory FirebaseRepository() => _instance ??= FirebaseRepository._internal(
        Firebase.initializeApp,
      );
  FirebaseRepository._internal(this._initFunction);

  @visibleForTesting
  FirebaseRepository.di(
    this._initFunction,
    this._analyticsCurrentScreenLogEventFunction,
    this._analyticsLogEventFunction,
    this._recordErrorFunction,
    this._recordFlutterErrorFunction,
    this._analyticsUserIdFunction,
    this._crashlyticsIdFunction,
    this._remoteConfig,
  );

  // Allows for replacement
  final FirebaseInitFunction _initFunction;
  AnalyticsCurrentScreenLogEventFunction?
      _analyticsCurrentScreenLogEventFunction;
  AnalyticsLogEventFunction? _analyticsLogEventFunction;
  RecordErrorFunction? _recordErrorFunction;
  RecordFlutterErrorFunction? _recordFlutterErrorFunction;
  SetAnalyticsUserIdFunction? _analyticsUserIdFunction;
  SetCrashlyticsIdFunction? _crashlyticsIdFunction;
  FirebaseRemoteConfig? _remoteConfig;

  static const String _configNameServiceMaintenance = 'service_maintenance';

  /// initialization process
  Future<void> init() async {
    await _initFunction();

    _analyticsCurrentScreenLogEventFunction ??=
        FirebaseAnalytics.instance.setCurrentScreen;
    _analyticsLogEventFunction ??= FirebaseAnalytics.instance.logEvent;
    _recordErrorFunction ??= FirebaseCrashlytics.instance.recordError;
    _recordFlutterErrorFunction ??=
        FirebaseCrashlytics.instance.recordFlutterError;
    _analyticsUserIdFunction ??= FirebaseAnalytics.instance.setUserId;
    _crashlyticsIdFunction ??= FirebaseCrashlytics.instance.setUserIdentifier;
    _remoteConfig ??= FirebaseRemoteConfig.instance;
  }

  /// ID Settings
  Future<void> setUserId(String id) async {
    await _analyticsUserIdFunction!(id: id);
    await _crashlyticsIdFunction!(id);
  }

  /// Screen transition logging to Analytics
  Future<void> logCurrentScreen(String screenName) async {
    await _analyticsCurrentScreenLogEventFunction!(screenName: screenName);
  }

  /// App error logging to Analytics
  /// - Do not include sensitive information!
  Future<void> logAppError(String errorLog) async {
    await _analyticsLogEventFunction!(
        name: 'app_error', parameters: {'log': errorLog});
  }

  /// Error Reporting to CrashLytics
  Future<void> recordError(Object exception, {StackTrace? stackTrace}) async {
    await _recordErrorFunction!(exception, stackTrace);
  }

  /// Error Reporting to CrashLytics(Errors caught by the Flutter framework)
  Future<void> recordFlutterError(Object exception,
      {StackTrace? stackTrace}) async {
    await _recordFlutterErrorFunction!(
        FlutterErrorDetails(exception: exception, stack: stackTrace));
  }

  /// Get maintenance flags from RemoteConfig
  Future<bool> fetchServiceMaintenanceFlag(
      Duration fetchTimeout, Duration minimumFetchInterval) async {
    await _remoteConfig?.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: fetchTimeout,
      minimumFetchInterval: minimumFetchInterval,
    ));
    await _remoteConfig?.fetch();
    await _remoteConfig?.activate();

    return _remoteConfig?.getBool(_configNameServiceMaintenance) ?? false;
  }
}
