import 'dart:convert';
import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m;
import 'package:pfizer/src/base/utils/Constants.dart';
import 'package:pfizer/src/configs/app_setup.locator.dart';
import 'package:pfizer/src/models/LocalDB/doctor_call_local_data.dart';
import 'package:pfizer/src/models/api_body/doctor_call_body_data.dart';
import 'package:pfizer/src/models/api_resonse/doctor_call_form_model.dart';
import 'package:pfizer/src/models/api_resonse/my_shedule.dart';
import 'package:pfizer/src/models/api_resonse/user.dart';
import 'package:pfizer/src/services/local/base/auth_view_model.dart';
import 'package:pfizer/src/services/local/base/usable_data_view_model.dart';
import 'package:pfizer/src/services/local/connectivity_service.dart';
import 'package:pfizer/src/services/local/local_db.dart';
import 'package:pfizer/src/services/remote/base/api_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DoctorCallViewModel extends ReactiveViewModel
    with ApiViewModel, AuthViewModel, UsableDataViewModel {
  BuildContext context;
  MyScheduleData? myScheduleData;
  DoctorCallViewModel(this.context, this.myScheduleData);

  LocalDatabase localdb = locator<LocalDatabase>();
  ConnectivityService connectivity = locator<ConnectivityService>();

  TextEditingController remarks = TextEditingController();
  int hospitalSelectedIndex = -1;
  int userSelectedIndex1 = -1;
  int userSelectedIndex2 = -1;
  int doctorSelectedIndex = -1;
  List<HospitalDoctorData> hospitalDoctorData = [];
  List<AccompaniedUserData> accompaniedUsersData = [];
  List<ProductData> _productsData = [];
  List<ProductData> selectedProductsData = [];
  List<ProductData> restProductsData = [];
  LatLng? currentLatLng;
  LocationPermission? locationPermission;
  init() async {
    setBusy(true);
    determineUserCurrentPosition();
    hospitalDoctorData.clear();
    accompaniedUsersData.clear();
    _productsData.clear();
    restProductsData.clear();
    usableData?.doctorCallFormModelData?.hospitalDoctorData?.forEach((element) {
      hospitalDoctorData.add(element);
    });
    usableData?.doctorCallFormModelData?.accompaniedUserData
        ?.forEach((element) {
      accompaniedUsersData.add(element);
    });
    usableData?.doctorCallFormModelData?.productData?.forEach((element) {
      _productsData.add(element);
      restProductsData.add(element);
    });
    addMoreProductList();
    if (myScheduleData != null) {
      hospitalSelectedIndex = hospitalDoctorData.indexWhere(
          (element) => element.hospitalId == myScheduleData?.hospitalId);
      doctorSelectedIndex = hospitalDoctorData[hospitalSelectedIndex]
              .doctordata
              ?.indexWhere(
                  (element) => element.doctorId == myScheduleData?.doctorId) ??
          0;
    }
    setBusy(false);
  }

  void determineUserCurrentPosition() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      print("user don't enable location permission");
    }
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        determineUserCurrentPosition();
        print("user denied location permission");
      }
      determineUserCurrentPosition();
    }
    if (locationPermission == LocationPermission.deniedForever) {
      Navigator.pop(context);
      print("user denied permission forever");
    }
    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    currentLatLng = LatLng(currentPosition.latitude, currentPosition.longitude);
  }

  addMoreProductList() {
    if (restProductsData.length > 0) {
      ProductData _data = restProductsData[0];
      _data.isSelected = false;
      _data.qty = 1;
      selectedProductsData.add(_data);
      restProductsData.removeWhere((element) => element == _data);
    }
    notifyListeners();
  }

  removeProductList(int index) {
    if (selectedProductsData.length > 1) {
      ProductData _data = selectedProductsData[index];
      restProductsData.add(_data);
      selectedProductsData.removeWhere((element) => element == _data);
      notifyListeners();
    }
  }

  clear() {
    selectedProductsData.clear();
    restProductsData.clear();
    _productsData.forEach((element) {
      restProductsData.add(element);
    });
    hospitalSelectedIndex = -1;
    doctorSelectedIndex = -1;
    userSelectedIndex1 = -1;
    userSelectedIndex2 = -1;
    addMoreProductList();
  }

  submit() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      AppSettings.openAppSettings();
      Constants.customErrorSnack(context, 'Please On Location First');
      print("user don't enable location permission");
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      currentLatLng =
          LatLng(currentPosition.latitude, currentPosition.longitude);
      ConnectivityResult connectivityResult =
          await Connectivity().checkConnectivity();
      switch (connectivityResult != ConnectivityResult.none) {
        case true:
          _submitOnLive();
          break;
        case false:
          _submitOnLocal();
          break;
      }
    }
  }

  _submitOnLocal() async {
    setBusy(true);
    List<DoctorProductsLocalDB> doctorProducts = [];
    selectedProductsData.forEach((element) {
      doctorProducts.add(DoctorProductsLocalDB(
          productId: element.productId,
          sample: element.isSelected,
          qty: (element.isSelected == false) ? "0" : element.qty.toString()));
    });
    DoctorCallLocalDB data = DoctorCallLocalDB(
        hospitalId: hospitalDoctorData[hospitalSelectedIndex].hospitalId,
        doctorId: hospitalDoctorData[hospitalSelectedIndex]
            .doctordata![doctorSelectedIndex]
            .doctorId,
        user1Id: (userSelectedIndex1 == -1)
            ? "0"
            : accompaniedUsersData[userSelectedIndex1].userId,
        user2Id: (userSelectedIndex2 == -1)
            ? "0"
            : accompaniedUsersData[userSelectedIndex2].userId,
        dateTime: DateTime.now().toString(),
        lat: currentLatLng?.latitude.toString(),
        lon: currentLatLng?.longitude.toString(),
        remarks: remarks.text,
        products: doctorProducts);
    var respond = await localdb.addDoctorCall(context, data);
    if (respond != null) {
      if (myScheduleData != null) {
        usableDataService.usableData.value?.mySchedule?.myScheduleData
                ?.firstWhere((element) =>
                    element.scheduleId == myScheduleData?.scheduleId)
                .isApplied ==
            "0";
        usableDataService.updateStatus('${myScheduleData?.detailId}');
        notifyListeners();
      }
      Constants.customSuccessSnack(context, "Your Data Added In LocalStorage");
      clear();
    }

    setBusy(false);
  }

  _submitOnLive() async {
    setBusy(true);
    List<DoctorProducts> doctorProducts = [];
    selectedProductsData.forEach((element) {
      doctorProducts.add(DoctorProducts(
          productId: element.productId,
          sample: element.isSelected,
          qty: (element.isSelected == false) ? "0" : element.qty.toString()));
    });
    DoctorCallBody data = DoctorCallBody(
        userId: authService.user?.userData?.userId.toString(),
        hospitalId: hospitalDoctorData[hospitalSelectedIndex].hospitalId,
        doctorId: hospitalDoctorData[hospitalSelectedIndex]
            .doctordata![doctorSelectedIndex]
            .doctorId,
        user1Id: (userSelectedIndex1 == -1)
            ? "0"
            : accompaniedUsersData[userSelectedIndex1].userId,
        user2Id: (userSelectedIndex2 == -1)
            ? "0"
            : accompaniedUsersData[userSelectedIndex2].userId,
        dateTime: DateTime.now().toString(),
        lat: currentLatLng?.latitude.toString(),
        lon: currentLatLng?.longitude.toString(),
        syncLat: currentLatLng?.latitude.toString(),
        syncLon: currentLatLng?.longitude.toString(),
        remarks: remarks.text,
        products: doctorProducts);
    addDoctorCall(data);
  }

  Future<void> addDoctorCall(DoctorCallBody data,
      {Function? onSuccess, Function? onFailed}) async {
    var newsResponse =
        await runBusyFuture(apiService.addDoctorCall(context, data));
    if (newsResponse != null) {
      newsResponse.when(success: (res) async {
        if (myScheduleData != null) {
          usableDataService.usableData.value?.mySchedule?.myScheduleData
                  ?.firstWhere((element) =>
                      element.scheduleId == myScheduleData?.scheduleId)
                  .isApplied ==
              "1";
          notifyListeners();
        }
        Constants.customSuccessSnack(context, res.toString());
        clear();
        onSuccess!();
        notifyListeners();
        setBusy(false);
      }, failure: (error) {
        print(error);
        onFailed!();
        Constants.customErrorSnack(context, error.toString());
        setBusy(false);
      });
    } else {
      setBusy(false);
    }
  }
}
