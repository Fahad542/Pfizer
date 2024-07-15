import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:pfizer/src/base/utils/Constants.dart';
import 'package:pfizer/src/views/doctor_call/doctor_call_view_model.dart';
import 'package:stacked/stacked.dart';

class ConnectivityService with ReactiveServiceMixin {
  ReactiveValue<bool> _isInternetConnected = ReactiveValue<bool>(true);
  bool get isInternetConnected => _isInternetConnected.value;

  ConnectivityService() {
    listenToReactiveValues([_isInternetConnected]);
    Connectivity().onConnectivityChanged.listen((result) {
      _isInternetConnected.value = result != ConnectivityResult.none;
      notifyListeners();
    });
  }
}
