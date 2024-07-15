// import 'package:flutter/cupertino.dart';
//
// class GeoTagApiService {
//   Future<void> getTaggingList(BuildContext context) async {
//     var newsResponse =
//     await runBusyFuture(apiService.getTaggingHospitalList(context));
//     newsResponse?.when(success: (data) async {
//       usableDataService.usableData.value?.ptagging = data;
//       notifyListeners();
//     }, failure: (error) {
//       usableDataService.usableData.value?.ptagging = null;
//       print(error);
//     });
//   }
