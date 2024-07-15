import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pfizer/src/models/api_resonse/my_shedule.dart';
import 'package:pfizer/src/models/api_resonse/tagging_modal.dart';
import 'package:pfizer/src/services/local/base/auth_view_model.dart';
import 'package:pfizer/src/services/local/base/usable_data_view_model.dart';
import 'package:pfizer/src/services/remote/base/api_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../base/utils/Constants.dart';

class TaggingViewModel extends ReactiveViewModel
    with ApiViewModel, AuthViewModel, UsableDataViewModel {
  BuildContext context;
  TaggingViewModel(this.context);



  TextEditingController search = TextEditingController();
  DateTime selectedDateTime = DateTime.now();
  DateTime max = DateTime.now();
  List<Tagging> searchResults = [];
  List<Tagging> deleteindex=[];

  List<Tagging> tagging = [];
  init() async {
    tagging.clear();
    setBusy(true);
    notifyListeners();
    usableDataService.usableData.value?.ptagging?.tagging?.forEach((element) {
      tagging.add(element);
    });
    setBusy(false);
  }

  void updateSearchResults() {
    setBusy(true);
    List<Tagging> filteredResults = tagging.where((data) {
      return data.hospitalName
          .toLowerCase()
          .contains(search.text.toLowerCase());
    }).toList();
    searchResults.clear();

    searchResults.addAll(filteredResults);

    print(filteredResults);
    notifyListeners();
    setBusy(false);
  }

  Future<void> deleteItemFromList(int index) async {
    if (index >= 0 && index < tagging.length) {
      tagging.removeAt(index);
      notifyListeners();
    }

  }

  @override
  bool get reactive => true;
}
