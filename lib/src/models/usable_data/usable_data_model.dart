import 'package:pfizer/src/models/api_resonse/doctor_call_form_model.dart';
import 'package:pfizer/src/models/api_resonse/my_shedule.dart';
import 'package:pfizer/src/models/api_resonse/tagging_modal.dart';
import 'package:pfizer/src/models/api_resonse/user.dart';

class UsableDataModel {
  DoctorCallFormModelData? doctorCallFormModelData;
  MySchedule? mySchedule;
  PfizerTagging? ptagging;

  UsableDataModel(
      {this.doctorCallFormModelData, this.mySchedule, this.ptagging});

  UsableDataModel.fromJson(Map<String, dynamic> json) {
    doctorCallFormModelData = json['doctor_call_form_model_data'];
    mySchedule = json['my_schedule'];
    ptagging = json['tagging'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor_call_form_model_data'] = this.doctorCallFormModelData;
    data['my_schedule'] = this.mySchedule;
    data['tagging'] = this.ptagging;
    return data;
  }
}
