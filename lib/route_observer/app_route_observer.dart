import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';

import '../common/usecase/firebase_usecase.dart';

class AppRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  final FirebaseUseCase _firebaseUseCase;
  final ScreenNameExtractor nameExtractor;
  AppRouteObserver(this._firebaseUseCase,
      {this.nameExtractor = defaultNameExtractor});

  void _sendScreenView(PageRoute<dynamic> route) {
    final String? screenId = nameExtractor(route.settings);
    if (screenId != null) {
      // Logging to Firebase
      _firebaseUseCase.logCurrentScreen(screenId);
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(route);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute);
    }
  }
}
