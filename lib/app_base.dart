import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobile_app_template/const/theme/theme_date_dark.dart';
import 'package:flutter_mobile_app_template/route_observer/app_route_observer.dart';
import 'package:flutter_mobile_app_template/view/home/home_page.dart';
import 'package:flutter_mobile_app_template/view/signin/signin_page.dart';

import 'common/usecase/dialog_usecase.dart';
import 'common/usecase/firebase_usecase.dart';
import 'const/app_page.dart';
import 'const/theme/theme_date_light.dart';

class AppBase extends StatefulWidget {
  const AppBase({super.key});

  @override
  State<StatefulWidget> createState() => AppBaseState();
}

final navigatorKey = GlobalKey<NavigatorState>();

class AppBaseState extends State<AppBase> {
  @override
  void initState() {
    super.initState();
    // Called when widget build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final firebaseUseCase = FirebaseUseCase();

      // Check maintenance flags
      firebaseUseCase.fetchServiceMaintenanceFlag().then((isMaintenance) {
        if (isMaintenance) {
          final overlayContext = navigatorKey.currentState?.overlay?.context;
          if (overlayContext != null) {
            // Displays a dialog and inhibits operation
            DialogUseCase().showServiceMaintenanceDialog(overlayContext);
          }
        }
      }).catchError((e) {
        firebaseUseCase.recordError(e);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TemplateApp',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: themeDataLight,
      darkTheme: themeDataDark,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
      ],
      navigatorObservers: [
        AppRouteObserver(FirebaseUseCase())
      ], // Log screen transitions
      initialRoute: _getInitialRoutePath(),
      onGenerateInitialRoutes: (String initialRouteName) =>
          _getInitialRoute(initialRouteName),
      routes: {
        // Add more screens as they are added
        AppPage.signIn.screenID: (_) => const SignInPage(),
        AppPage.home.screenID: (_) => const HomePage(),
      },
    );
  }

  String _getInitialRoutePath() {
    // If the initial startup screen changes depending on conditions, describe the conditional branch here.
    return AppPage.signIn.screenID;
  }

  List<MaterialPageRoute> _getInitialRoute(String initialRoutePath) {
    // If the initial startup screen changes depending on conditions, describe the conditional branch here.
    return [
      MaterialPageRoute(
        builder: (_) => const SignInPage(),
        settings: RouteSettings(name: AppPage.signIn.screenID),
      ),
    ];
  }
}
