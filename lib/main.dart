import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_app_template/app_base.dart';

import 'common/usecase/firebase_usecase.dart';
import 'common/usecase/hive_usecase.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Initialize Hive
    await HiveUseCase().init();
    // Initialize Firebase
    await FirebaseUseCase().init();

    // Suppress screen landscape display
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    // Suppress translucency of the status bar
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    runApp(const AppBase());
  }, (error, stackTrace) {
    FirebaseUseCase().recordError(error, stackTrace: stackTrace);
  });
}
