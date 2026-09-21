import 'package:flutter/foundation.dart';

mixin SafeNotify on ChangeNotifier {
  bool isDisbos = false;

  void safeNotify() {
    if (!isDisbos) notifyListeners();
  }

  @override
  void dispose() {
    isDisbos = true;
    super.dispose();
  }
}
