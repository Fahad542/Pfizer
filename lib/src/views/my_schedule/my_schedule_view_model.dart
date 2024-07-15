import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pfizer/src/models/api_resonse/my_shedule.dart';
import 'package:pfizer/src/services/local/base/auth_view_model.dart';
import 'package:pfizer/src/services/local/base/usable_data_view_model.dart';
import 'package:pfizer/src/services/remote/base/api_view_model.dart';
import 'package:stacked/stacked.dart';

class MyScheduleViewModel extends ReactiveViewModel
    with ApiViewModel, AuthViewModel, UsableDataViewModel {
  BuildContext context;
  MyScheduleViewModel(this.context);

  TextEditingController date = TextEditingController();
  DateTime selectedDateTime = DateTime.now();
  DateTime max = DateTime.now();

  List<MyScheduleData> myScheduleData = [];

  init() async {
    setBusy(true);
    notifyListeners();
    myScheduleData.clear();
    date.text = DateFormat("dd/MM/yyyy").format(selectedDateTime).toString();
    usableDataService.usableData.value?.mySchedule?.myScheduleData
        ?.where((element) =>
            element.scheduleDate ==
                DateFormat("yyyy-MM-dd").format(selectedDateTime).toString() &&
            element.isApplied == "0")
        .forEach((element) {
      myScheduleData.add(element);
    });
    setBusy(false);
  }

  @override
  bool get reactive => true;
}
