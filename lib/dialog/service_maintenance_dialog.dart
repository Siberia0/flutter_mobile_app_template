import 'package:flutter/material.dart';

class ServiceMaintenanceDialog extends StatelessWidget {
  final GlobalKey? globalKey;
  const ServiceMaintenanceDialog({super.key, required this.globalKey});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Suppresses dialog closing
        return false;
      },
      child: AlertDialog(
        key: globalKey,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        title: const Text(
          'Under Maintenance',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Text(
              'The application is currently under maintenance.',
              maxLines: null,
            ),
          ],
        ),
      ),
    );
  }
}
