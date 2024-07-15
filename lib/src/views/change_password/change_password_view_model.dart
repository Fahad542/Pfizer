import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m;
import 'package:pfizer/src/base/utils/Constants.dart';
import 'package:pfizer/src/services/local/base/auth_view_model.dart';
import 'package:pfizer/src/services/local/navigation_service.dart';
import 'package:pfizer/src/services/remote/base/api_view_model.dart';
import 'package:stacked/stacked.dart';

class ChangePasswordViewModel extends ReactiveViewModel with AuthViewModel, ApiViewModel {

  bool isShowPassword = false;
  bool isShowRePassword = false;
  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();
  init(){

  }
  onChangePassword(BuildContext context, BuildContext ctx) async {
    if(m.Form.of(ctx).validate() && (password.text == rePassword.text)){
      setBusy(true);
      await changePassword(context);
      setBusy(false);
    }
  }
  Future<void> changePassword(BuildContext context) async {
    ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult != ConnectivityResult.none) {
      var newsResponse = await runBusyFuture(apiService.changePassword(context, password.value.text.trim()));
      newsResponse.when(success: (data) async {
        if (data) {
          password.clear();
          rePassword.clear();
          Navigator.pop(context);
        }
      }, failure: (error) {
        Constants.customErrorSnack(context, error.toString());
      });
    }else{
      Constants.customWarningSnack(context, "Check Your Connection before sync");
    }
  }

}
