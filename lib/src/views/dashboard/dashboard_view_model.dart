import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:pfizer/src/base/utils/Constants.dart';
import 'package:pfizer/src/configs/app_setup.locator.dart';
import 'package:pfizer/src/models/LocalDB/doctor_call_local_data.dart';
import 'package:pfizer/src/models/api_body/doctor_call_body_data.dart';
import 'package:pfizer/src/models/api_resonse/doctor_call_form_model.dart';
import 'package:pfizer/src/services/local/base/auth_view_model.dart';
import 'package:pfizer/src/services/local/base/local_db_view_model.dart';
import 'package:pfizer/src/services/local/base/usable_data_view_model.dart';
import 'package:pfizer/src/services/local/local_db.dart';
import 'package:pfizer/src/services/local/navigation_service.dart';
import 'package:pfizer/src/services/remote/base/api_view_model.dart';
import 'package:stacked/stacked.dart';

class ItemCard {
  final String name;
  final String icon;

  ItemCard({required this.name, required this.icon});
}

class DashboardViewModel extends ReactiveViewModel
    with AuthViewModel, ApiViewModel, UsableDataViewModel, LocalDbViewModel {
  List<ItemCard> activeItems = [];
  List<ItemCard> unActiveItems = [];
  LatLng? currentLatLng;

  init(BuildContext context) async {
    checkForUpdate();
    setBusy(true);
    authService.user?.menuData
        ?.where((element) => element.status == "Yes")
        .forEach((element) {
      activeItems.add(ItemCard(
          name: element.name.toString(), icon: element.icon.toString()));
    });
    authService.user?.menuData
        ?.where((element) => element.status == "No")
        .forEach((element) {
      unActiveItems.add(ItemCard(
          name: element.name.toString(), icon: element.icon.toString()));
    });
    determineUserCurrentPosition(context);
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      await getDoctorCallData(context);
      await getTaggingList(context);
      await getMySchedule(context);
      await usableDataService.update();
      notifyListeners();
    } else if (connectivityResult == ConnectivityResult.none) {
      await usableDataService.get();
      notifyListeners();
    }
    setBusy(false);
  }

  Future<void> getDoctorCallData(BuildContext context) async {
    var newsResponse =
        await runBusyFuture(apiService.getHospitalDoctorList(context));
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





  Future<void> getTaggingList(BuildContext context) async {

    var newsResponse =
        await runBusyFuture(apiService.getTaggingHospitalList(context));
    newsResponse?.when(success: (data) async {
      usableDataService.usableData.value?.ptagging = data;
      notifyListeners();
      print("apihit");
    }, failure: (error) {
      usableDataService.usableData.value?.ptagging = null;
      print(error);

    });
  }
  void determineUserCurrentPosition(BuildContext context) async {
    LocationPermission locationPermission;
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      print("user don't enable location permission");
    }
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        determineUserCurrentPosition(context);
        print("user denied location permission");
      }
      determineUserCurrentPosition(context);
    }
    if (locationPermission == LocationPermission.deniedForever) {
      Navigator.pop(context);
      print("user denied permission forever");
    }
    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    currentLatLng = LatLng(currentPosition.latitude, currentPosition.longitude);
  }

  onSetting(BuildContext context) {
    NavService.setting();
  }

  NavService? getNavigatorByItem(String item) {
    switch (item) {
      case "Calls":
        {
          NavService.doctorCall();
        }
        break;
      case "Schedule":
        {

          NavService.mySchedule();
        }
        break;
      case "Tagging":  {
  NavService.tagging();

        }
      break;
      case "Expenses":  {
        NavService.expenses();

      }

        break;
      case "Itinerary":  {
        NavService.Itinerary();

      }

      break;
    }
  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        InAppUpdate.performImmediateUpdate().then((value) {
          if (value != AppUpdateResult.success) {
            checkForUpdate();
          }
        });
      }
    }).catchError((e) {
      print(e.toString());
    });
  }

  onSync(BuildContext context) async {
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none && isBusy == false) {
      setBusy(true);
      await updateDoctorCall(context);
      await getDoctorCallData(context);
      await getMySchedule(context);
      await usableDataService.update();
      notifyListeners();
      setBusy(false);
    } else {
      Constants.customWarningSnack(context, "Please Check Your Internet");
    }
  }

  updateDoctorCall(BuildContext context) async {
    List<DoctorCallLocalDB>? data = await db.getAllDoctorCall(context);
    if ((data?.length ?? 0) > 0) {
      data?.forEach((element) async {
        List<DoctorProducts> dp = [];
        element.products?.forEach((e) {
          dp.add(DoctorProducts(
              productId: e.productId, sample: e.sample, qty: e.qty));
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
          syncLat: currentLatLng?.latitude.toString(),
          syncLon: currentLatLng?.longitude.toString(),
          remarks: element.remarks,
          products: dp,
        );
        await addDoctorCall(context, _data, onSuccess: () async {
          bool deleted = await db.deleteDoctorCall(context, element);
          if (deleted) {
            db.countCalls.value = 0;
            notifyListeners();
            Constants.customSuccessSnack(
                context, "All Calls Successfully Deleted From Local Database");
          } else {
            var respond = await db.addDoctorCall(context, element);
          }
        });
      });
    }
  }

  Future<void> addDoctorCall(BuildContext context, DoctorCallBody data,
      {Function? onSuccess, Function? onFailed}) async {
    var newsResponse =
        await runBusyFuture(apiService.addDoctorCall(context, data));
    if (newsResponse != null) {
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
}
