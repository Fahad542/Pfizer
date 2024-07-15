import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfizer/src/services/local/base/auth_view_model.dart';
import 'package:pfizer/src/services/remote/base/api_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../models/api_resonse/My_expense.dart';
import '../../models/api_resonse/my_shedule.dart';

class MyExpenseViewModel extends ReactiveViewModel
    with ApiViewModel, AuthViewModel {
  BuildContext context;
  MyExpenseViewModel(this.context);

  TextEditingController date = TextEditingController();
  DateTime selectedDateTime = DateTime.now();
  DateTime max = DateTime.now();

  List<Tagging> Data = [];

  init() async {
   // setBusy(true);
    await ExpenseList(context);
    notifyListeners();


   // setBusy(false);
  }

  Future<void> ExpenseList(BuildContext context) async {

    var newsResponse =
    await runBusyFuture(apiService.myexpenseList(context));
    newsResponse?.when(success: (data) async {
      Data = data.tagging!;
      notifyListeners();
    }, failure: (error) {
      print(error);


    });
  }


  Color getColorForStatus(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green; // Replace with AppColors.green if defined
      case 'Reject':
        return Colors.red; // Replace with AppColors.red if defined
      case 'Pending':
        return Colors.blue; // Replace with AppColors.blue if defined
      default:
        return Colors.black; // Default color if status is unknown
    }
  }
  @override
  bool get reactive => true;
}
