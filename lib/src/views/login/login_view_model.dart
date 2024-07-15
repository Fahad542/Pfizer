import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m;
import 'package:pfizer/src/base/utils/Constants.dart';
import 'package:pfizer/src/configs/app_setup.locator.dart';
import 'package:pfizer/src/services/local/base/auth_view_model.dart';
import 'package:pfizer/src/services/local/base/usable_data_view_model.dart';
import 'package:pfizer/src/services/local/local_db.dart';
import 'package:pfizer/src/services/local/navigation_service.dart';
import 'package:pfizer/src/services/remote/base/api_view_model.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends ReactiveViewModel with ApiViewModel, AuthViewModel, UsableDataViewModel {

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isShowPassword = false;

  init(){
    if(authService.user != null){
      Future.delayed(Duration.zero, (){
        NavService.dashboard();
      });
    }
  }

  onLogin(BuildContext context){
    setBusy(true);
    if(m.Form.of(context).validate()){
      login(context, (){
        NavService.dashboard();
        Constants.customSuccessSnack(context, "Welcome ${authService.user?.userData?.userName}");
        setBusy(false);
      });
    }else{
      setBusy(false);
    }
  }


  Future<void> login(BuildContext context, Function callBack) async {
    var newsResponse = await runBusyFuture(apiService.login(context, username.value.text.trim(), password.value.text.trim()));
    newsResponse?.when(success: (data) async {
      authService.user = data;
      authService.datetime = DateTime.now();
      callBack();
    }, failure: (error) {
      Constants.customErrorSnack(context, error.toString());
      setBusy(false);
    });
  }
}
