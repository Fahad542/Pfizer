import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfizer/src/services/local/base/auth_view_model.dart';
import 'package:pfizer/src/services/remote/base/api_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../../models/api_resonse/Itinerary_model.dart';
import '../../../models/api_resonse/my_litnerary.dart';


class ItineraydetailViewModel extends ReactiveViewModel
    with ApiViewModel, AuthViewModel {
  BuildContext context;
   My_Itineraray? data;
  ItineraydetailViewModel(this.context, this.data);

  TextEditingController date = TextEditingController();
  DateTime selectedDateTime = DateTime.now();
  DateTime max = DateTime.now();

  List<Itineraray> Data = [];

  init() async {
    // setBusy(true);

    await ExpenseList(context);
    notifyListeners();


    // setBusy(false);
  }

  Future<void> ExpenseList(BuildContext context) async {
    var newsResponse =
    await runBusyFuture(apiService.itinerarayList(context,data?.plan_id.toString()));
    newsResponse?.when(success: (data) async {
      Data = data.tagging!;
      notifyListeners();
    }, failure: (error) {
      print(error);
    });
  }}
