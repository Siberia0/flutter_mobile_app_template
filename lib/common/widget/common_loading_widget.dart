import 'package:flutter/material.dart';

class CommonLoadingWidget {
  BuildContext _context;

  void _hide() {
    Navigator.of(_context).pop();
  }

  void _show() {
    showGeneralDialog(
      context: _context,
      barrierDismissible: false,
      pageBuilder: (_, __, ___) {
        return WillPopScope(
          child: _FullScreenLoader(),
          onWillPop: () async => false,
        );
      },
    );
  }

  Future<T> during<T>(Future<T> future) {
    _show();
    return future.whenComplete(() => _hide());
  }

  CommonLoadingWidget._create(this._context);

  factory CommonLoadingWidget.of(BuildContext context) {
    return CommonLoadingWidget._create(context);
  }
}

class _FullScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.1),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
