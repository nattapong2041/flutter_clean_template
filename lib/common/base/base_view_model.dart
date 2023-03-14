import 'package:flutter/material.dart';

import 'base_service.dart';

abstract class BaseViewModel<T> with ChangeNotifier {
  @protected
  ApiState _apiState = ApiState.completed;

  ApiState get apiState => _apiState;

  String _message = "Error";
  String get message => _message;

  @protected
  void loadingState() {
    if (_apiState != ApiState.loading) {
      _apiState = ApiState.loading;
      notifyListeners();
    }
  }

  @protected
  void completedState() {
    if (_apiState != ApiState.completed) {
      _apiState = ApiState.completed;
      notifyListeners();
    }
  }

  @protected
  void errorState({String? message}) {
    if (_apiState != ApiState.error) {
      if (message != null) {
        _message = message;
      }
      _apiState = ApiState.error;
      notifyListeners();
    }
  }
}
