class DoctorCallFormModelData {
  List<ProductData>? productData;
  List<AccompaniedUserData>? accompaniedUserData;
  List<HospitalDoctorData>? hospitalDoctorData;

  DoctorCallFormModelData({this.productData, this.accompaniedUserData, this.hospitalDoctorData});

  DoctorCallFormModelData.fromJson(Map<String, dynamic> json) {
    if (json['product'] != null) {
      productData = <ProductData>[];
      json['product'].forEach((v) {
        productData!.add(new ProductData.fromJson(v));
      });
    }
    if (json['accompaineduser'] != null) {
      accompaniedUserData = <AccompaniedUserData>[];
      json['accompaineduser'].forEach((v) {
        accompaniedUserData!.add(new AccompaniedUserData.fromJson(v));
      });
    }
    if (json['data'] != null) {
      hospitalDoctorData = <HospitalDoctorData>[];
      json['data'].forEach((v) {
        hospitalDoctorData!.add(new HospitalDoctorData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productData != null) {
      data['product'] = this.productData!.map((v) => v.toJson()).toList();
    }
    if (this.accompaniedUserData != null) {
      data['accompaineduser'] = this.accompaniedUserData!.map((v) => v.toJson()).toList();
    }
    if (this.hospitalDoctorData != null) {
      data['data'] = this.hospitalDoctorData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductData {
  String? productId;
  String? itemName;
  bool? isSelected;
  int qty = 0;

  ProductData({this.productId, this.itemName, this.qty = 0, this.isSelected});

  ProductData.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    itemName = json['item_name'];
  }

  static List<ProductData> fromJsonList(List<Map<String, dynamic>> jsonList) {
    List<ProductData> _productData = [];
    for (var v in jsonList) {
      _productData.add(ProductData.fromJson(v));
    }
    return _productData;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['item_name'] = this.itemName;
    return data;
  }
}
class AccompaniedUserData {
  String? userId;
  String? userName;
  String? userType;

  AccompaniedUserData({this.userId, this.userName, this.userType});

  AccompaniedUserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userType = json['user_type'];
  }

  static List<AccompaniedUserData> fromJsonList(List<Map<String, dynamic>> jsonList) {
    List<AccompaniedUserData> _productData = [];
    for (var v in jsonList) {
      _productData.add(AccompaniedUserData.fromJson(v));
    }
    return _productData;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_type'] = this.userType;
    return data;
  }
}
class HospitalDoctorData {
  String? hospitalId;
  String? hospitalName;
  String? hospitalAddress;
  List<DoctorData>? doctordata;

  HospitalDoctorData(
      {this.hospitalId,
        this.hospitalName,
        this.hospitalAddress,
        this.doctordata});

  HospitalDoctorData.fromJson(Map<String, dynamic> json) {
    hospitalId = json['hospital_id'];
    hospitalName = json['hospital_name'];
    hospitalAddress = json['hospital_address'];
    if (json['doctordata'] != null) {
      doctordata = <DoctorData>[];
      json['doctordata'].forEach((v) {
        doctordata!.add(new DoctorData.fromJson(v));
      });
    }
  }


  static List<HospitalDoctorData> fromJsonList(List<Map<String, dynamic>> jsonList, List<Map<String, dynamic>> doctorJsonList) {
    List<HospitalDoctorData> _productData = [];
    for (var v in jsonList) {
      HospitalDoctorData _data = HospitalDoctorData.fromJson(v);
      _data.doctordata = DoctorData.fromJsonList(doctorJsonList.where((element) => element['hospital_id'] == v['hospital_id']).toList());
      _productData.add(_data);
    }
    return _productData;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hospital_id'] = this.hospitalId;
    data['hospital_name'] = this.hospitalName;
    data['hospital_address'] = this.hospitalAddress;
    if (this.doctordata != null) {
      data['doctordata'] = this.doctordata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class DoctorData {
  String? doctorId;
  String? doctorName;
  String? phoneNo;
  String? specialityTitle;
  int? index;

  DoctorData(
      {this.doctorId,
        this.doctorName,
        this.phoneNo,
        this.specialityTitle,
        this.index});

  DoctorData.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    doctorName = json['doctor_name'];
    phoneNo = json['phone_no'];
    specialityTitle = json['speciality_title'];
    index = json['index'];
  }

  static List<DoctorData> fromJsonList(List<Map<String, dynamic>> jsonList) {
    List<DoctorData> _productData = [];
    for (var v in jsonList) {
      _productData.add(DoctorData.fromJson(v));
    }
    return _productData;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor_id'] = this.doctorId;
    data['doctor_name'] = this.doctorName;
    data['phone_no'] = this.phoneNo;
    data['speciality_title'] = this.specialityTitle;
    data['index'] = this.index;
    return data;
  }
}
