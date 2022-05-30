import 'package:flutter/cupertino.dart';

class ViewModelBase extends ChangeNotifier {
  // Whether the associated View class is disposed or not
  bool _isDisposed = false;
  bool get isDisposed => _isDisposed;

  @override
  void notifyListeners() {
    if (!_isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
