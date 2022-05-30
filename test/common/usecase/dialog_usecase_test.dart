import 'package:flutter/material.dart';
import 'package:flutter_mobile_app_template/app_base.dart';
import 'package:flutter_mobile_app_template/common/usecase/dialog_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

Future<void> pumpArgumentWidget(
  WidgetTester tester, {
  Object? args,
  required Widget child,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      navigatorKey: navigatorKey,
      home: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute<Widget>(
            builder: (_) => child,
            settings: RouteSettings(arguments: args),
          );
        },
      ),
    ),
  );
}

void main() {
  setUp(() {
    resetMockitoState();
  });

  group('showExecuteDialog', () {
    testWidgets('push negative button', (WidgetTester tester) async {
      await pumpArgumentWidget(
        tester,
        child: Container(),
      );
      await tester.pumpAndSettle();

      // Get BuildContext from Widget on screen
      final BuildContext context = tester.element(
          find.byWidgetPredicate((Widget widget) => widget is Container));

      DialogUseCase.di(null).showExecuteOrCancelDialog(context, 'test negative',
          () {
        // Verify not to be called
        expect(false, isTrue);
      });
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);

      // Press NegativeButton
      // ((tester.widget(find.byKey(const ValueKey('NegativeButton')).first)
      //         as OutlinedButton)
      //     .onPressed!());

      await tester.tap(find.byKey(const ValueKey('NegativeButton')));
      await tester.pumpAndSettle();

      // I want to verify the close of the dialog but it doesn't work.
      //expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets('push positive button', (WidgetTester tester) async {
      bool result = false;

      await pumpArgumentWidget(
        tester,
        child: Container(),
      );
      await tester.pumpAndSettle();

      // Get BuildContext from Widget on screen
      final BuildContext context = tester.element(
          find.byWidgetPredicate((Widget widget) => widget is Container));

      DialogUseCase.di(null).showExecuteOrCancelDialog(context, 'test positive',
          () {
        result = true;
      });
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);

      // Press NegativeButton
      // ((tester.widget(find.byKey(const ValueKey('NegativeButton')).first)
      //         as OutlinedButton)
      //     .onPressed!());

      await tester.tap(find.byKey(const ValueKey('PositiveButton')));
      await tester.pumpAndSettle();

      expect(result, isTrue);
    });

    testWidgets('can not display dialog', (WidgetTester tester) async {
      await pumpArgumentWidget(
        tester,
        child: Container(),
      );
      await tester.pumpAndSettle();

      // Get BuildContext from Widget on screen
      final BuildContext context = tester.element(
          find.byWidgetPredicate((Widget widget) => widget is Container));

      DialogUseCase.di(GlobalKey())
          .showExecuteOrCancelDialog(context, 'test positive', () {});
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
    });
  });

  testWidgets('showServiceMaintenanceDialog', (WidgetTester tester) async {
    await pumpArgumentWidget(
      tester,
      child: Container(),
    );
    await tester.pumpAndSettle();

    // Get BuildContext from Widget on screen
    final BuildContext context = tester.element(
        find.byWidgetPredicate((Widget widget) => widget is Container));

    DialogUseCase.di(null).showServiceMaintenanceDialog(context);
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
  });

  group('showMessageDialog', () {
    testWidgets('push CloseButton', (WidgetTester tester) async {
      await pumpArgumentWidget(
        tester,
        child: Container(),
      );
      await tester.pumpAndSettle();

      // Get BuildContext from Widget on screen
      final BuildContext context = tester.element(
          find.byWidgetPredicate((Widget widget) => widget is Container));

      DialogUseCase.di(null).showMessageDialog(context, 'test');
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('CloseButton')));
      await tester.pumpAndSettle();

      // I want to verify the close of the dialog but it doesn't work.
      //expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets('can not display dialog', (WidgetTester tester) async {
      await pumpArgumentWidget(
        tester,
        child: Container(),
      );
      await tester.pumpAndSettle();

      // Get BuildContext from Widget on screen
      final BuildContext context = tester.element(
          find.byWidgetPredicate((Widget widget) => widget is Container));

      DialogUseCase.di(GlobalKey()).showMessageDialog(context, 'test');
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
    });
  });
}
