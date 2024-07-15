import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m;
import 'package:pfizer/src/base/utils/Constants.dart';
import 'package:pfizer/src/configs/app_setup.locator.dart';
import 'package:pfizer/src/models/LocalDB/doctor_call_local_data.dart';
import 'package:pfizer/src/models/api_body/doctor_call_body_data.dart';
import 'package:pfizer/src/services/local/base/auth_view_model.dart';
import 'package:pfizer/src/services/local/base/usable_data_view_model.dart';
import 'package:pfizer/src/services/local/local_db.dart';
import 'package:pfizer/src/services/local/navigation_service.dart';
import 'package:pfizer/src/services/remote/base/api_view_model.dart';
import 'package:stacked/stacked.dart';

class SettingViewModel extends ReactiveViewModel with AuthViewModel, ApiViewModel, UsableDataViewModel {

  init(){

  }


  LocalDatabase db = locator<LocalDatabase>();

  Future<bool> onSync(BuildContext context) async {
    ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult != ConnectivityResult.none) {
      await updateDoctorCall(context);
      return true;
    }else{
      return false;
    }
  }

  Future<void> getDoctorCallData(BuildContext context) async {
    var newsResponse = await runBusyFuture(apiService.getHospitalDoctorList(context));
    newsResponse?.when(success: (data) async {
      usableDataService.usableData.value?.doctorCallFormModelData = data;
      notifyListeners();
    }, failure: (error) {
      print(error);
      Constants.customErrorSnack(context, error.toString());
    });
  }
  Future<void> getMySchedule(BuildContext context) async {
    var newsResponse = await runBusyFuture(apiService.getMySchedule(context));
    newsResponse?.when(success: (data) async {
      usableDataService.usableData.value?.mySchedule = data;
      notifyListeners();
    }, failure: (error) {
      usableDataService.usableData.value?.mySchedule = null;
      print(error);
    });
  }
  Future<void> updateDoctorCall(BuildContext context) async {
    List<DoctorCallLocalDB>? data = await db.getAllDoctorCall(context);
    if ((data?.length ?? 0) > 0) {
      data?.forEach((element) async {
        List<DoctorProducts> dp = [];
        element.products?.forEach((e) {
          dp.add(DoctorProducts(
              productId: e.productId,
              sample: e.sample,
              qty: e.qty
          ));
        });
        DoctorCallBody _data = DoctorCallBody(
          userId: authService.user?.userData?.userId.toString(),
          doctorId: element.doctorId,
          hospitalId: element.hospitalId,
          user1Id: element.user1Id,
          user2Id: element.user2Id,
          dateTime: element.dateTime,
          lat: element.lat,
          lon: element.lon,
          syncLat: element.lat,
          syncLon: element.lon,
          remarks: element.remarks,
          products: dp,
        );
        await addDoctorCall(context, _data, onSuccess: () async {
          bool deleted = await db.deleteDoctorCall(context, element);
          if(deleted){
            Constants.customSuccessSnack(context, "All Calls Successfully Deleted From Local Database");
          }else{
            var respond = await db.addDoctorCall(context, element);
          }
        });
      });
    }
  }

  Future<void> addDoctorCall(BuildContext context, DoctorCallBody data, {Function? onSuccess, Function? onFailed}) async {
    var newsResponse = await runBusyFuture(apiService.addDoctorCall(context, data));
    if(newsResponse != null) {
      newsResponse.when(success: (res) async {
        onSuccess!();
        notifyListeners();
      }, failure: (error) {
        print(error);
        onFailed!();
        Constants.customErrorSnack(context, error.toString());
      });
    }
  }
  onLogout(BuildContext context) async {
    setBusy(true);
    bool value = await onSync(context);
    if(value == true){
      authService.logout();
      NavService.login();
      setBusy(false);
    }else{
      Constants.customWarningSnack(context, "Check Your Internet First");
      setBusy(false);
    }
  }
}
