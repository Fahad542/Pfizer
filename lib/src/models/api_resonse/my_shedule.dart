class MySchedule {
  List<MyScheduleData>? myScheduleData;

  MySchedule({this.myScheduleData});

  MySchedule.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      myScheduleData = <MyScheduleData>[];
      json['data'].forEach((v) {
        myScheduleData!.add(new MyScheduleData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myScheduleData != null) {
      data['data'] = this.myScheduleData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyScheduleData {
  String? scheduleId;
  String? detailId;
  String? brickCode;
  String? brickName;
  String? hospitalName;
  String? doctorName;
  String? doctorId;
  String? hospitalId;
  String? scheduleDate;
  String? isApplied;

  MyScheduleData(
      {this.scheduleId,
        this.detailId,
        this.brickCode,
        this.brickName,
        this.hospitalName,
        this.doctorName,
        this.doctorId,
        this.hospitalId,
        this.isApplied,
        this.scheduleDate});

  MyScheduleData.fromJson(Map<String, dynamic> json) {
    scheduleId = json['schedule_id'];
    detailId = json['detail_id'];
    brickCode = json['brick_code'];
    brickName = json['brick_name'];
    hospitalName = json['hospital_name'];
    doctorName = json['doctor_name'];
    doctorId = json['doctor_id'];
    hospitalId = json['hospital_id'];
    scheduleDate = json['schedule_date'];
    isApplied = json['status'];
  }

  static List<MyScheduleData> fromJsonList(List<Map<String, dynamic>> jsonList) {
    List<MyScheduleData> _productData = [];
    for (var v in jsonList) {
      _productData.add(MyScheduleData.fromJson(v));
    }
    return _productData;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schedule_id'] = this.scheduleId;
    data['detail_id'] = this.detailId;
    data['brick_code'] = this.brickCode;
    data['brick_name'] = this.brickName;
    data['hospital_name'] = this.hospitalName;
    data['doctor_name'] = this.doctorName;
    data['doctor_id'] = this.doctorId;
    data['hospital_id'] = this.hospitalId;
    data['schedule_date'] = this.scheduleDate;
    data['status'] = this.isApplied;
    return data;
  }
}
