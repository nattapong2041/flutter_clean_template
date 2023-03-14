import 'package:flutter/material.dart';

//*Use this model with Material app in: lib/main.dart

class LocaleViewModel extends ChangeNotifier {
  Locale? _locale;

  LocaleViewModel(this._locale);

  Locale? get locale => _locale;

  void set(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
