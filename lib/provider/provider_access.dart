import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

mixin ProviderAccess<T> {
  T? getProvider(BuildContext context, bool mounted) {
    // Check for exception thrown when trying to reference Provider after being disposed.
    if (mounted) {
      return Provider.of<T>(context, listen: false);
    } else {
      return null;
    }
  }
}
