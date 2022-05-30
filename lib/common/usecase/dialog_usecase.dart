import 'package:flutter/material.dart';

import '../../app_base.dart';
import '../../dialog/service_maintenance_dialog.dart';

/// singleton
class DialogUseCase {
  static DialogUseCase? _instance;
  factory DialogUseCase() => _instance ??= DialogUseCase._internal();
  DialogUseCase._internal();

  @visibleForTesting
  DialogUseCase.di(this._serviceMaintenanceDialogGlobalKey);

  GlobalKey? _serviceMaintenanceDialogGlobalKey;
  // No other dialogs are displayed when the Maintenance in Progress dialog is displayed.
  bool _canShowDialog() => _serviceMaintenanceDialogGlobalKey == null;

  /// Displays a dialog with two buttons: "Execute" and "Cancel
  Future<void> showExecuteOrCancelDialog(
      BuildContext context, String message, Function onPressPositive,
      {String positiveButtonText = 'Execute'}) async {
    if (!_canShowDialog()) {
      return;
    }

    // Device Screen Height
    final double screenHeight = MediaQuery.of(context).size.height;

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          content: Container(
            // Do not make the dialog larger than half of the device screen
            constraints: BoxConstraints(maxHeight: screenHeight / 2.0),
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 14.0,
                    height: 1.8,
                  ),
                ),
              ),
            ),
          ),
          actions: [
            OutlinedButton(
              key: const ValueKey('NegativeButton'),
              style: OutlinedButton.styleFrom(
                primary: Colors.black,
                side: const BorderSide(color: Colors.grey),
              ),
              onPressed: () => Navigator.pop(navigatorKey.currentContext!),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            OutlinedButton(
              key: const ValueKey('PositiveButton'),
              style: OutlinedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                side: const BorderSide(color: Colors.grey),
              ),
              onPressed: () async {
                await onPressPositive();
              },
              child: Text(
                positiveButtonText,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Display message display dialog with one "Close" button
  Future<void> showMessageDialog(BuildContext context, String message,
      {String closeButtonText = 'Close'}) async {
    if (!_canShowDialog()) {
      return;
    }

    // Device Screen Height
    final double screenHeight = MediaQuery.of(context).size.height;

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          content: Container(
            // Do not make the dialog larger than half of the device screen
            constraints: BoxConstraints(maxHeight: screenHeight / 2.0),
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 14.0,
                    height: 1.8,
                  ),
                ),
              ),
            ),
          ),
          actions: [
            OutlinedButton(
              key: const ValueKey('CloseButton'),
              style: OutlinedButton.styleFrom(
                primary: Colors.black,
                side: const BorderSide(color: Colors.grey),
              ),
              onPressed: () async {
                Navigator.pop(navigatorKey.currentContext!);
              },
              child: Text(
                closeButtonText,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Displays a non-exitable dialog indicating that maintenance is in progress
  Future<void> showServiceMaintenanceDialog(BuildContext context) async {
    // Suppresses display of other dialogs
    _serviceMaintenanceDialogGlobalKey = GlobalKey();

    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return ServiceMaintenanceDialog(
          globalKey: _serviceMaintenanceDialogGlobalKey,
        );
      },
    );
  }
}
