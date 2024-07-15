class DoctorCallBody {
  String? userId;
  String? doctorId;
  String? hospitalId;
  String? user1Id;
  String? user2Id;
  String? dateTime;
  String? lat;
  String? lon;
  String? syncLat;
  String? syncLon;
  String? remarks;
  List<DoctorProducts>? products;

  DoctorCallBody(
      {this.doctorId,
        this.userId,
        this.hospitalId,
        this.user1Id,
        this.user2Id,
        this.dateTime,
        this.lat,
        this.lon,
        this.syncLat,
        this.syncLon,
        this.remarks,
        this.products});

  DoctorCallBody.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    doctorId = json['doctor_id'];
    hospitalId = json['hospital_id'];
    user1Id = json['user_1_id'];
    user2Id = json['user_2_id'];
    dateTime = json['dateTime'];
    lat = json['lat'];
    lon = json['lon'];
    syncLat = json['synclat'];
    syncLon = json['synclon'];
    remarks = json['callremarks'];
    if (json['products'] != null) {
      products = <DoctorProducts>[];
      json['products'].forEach((v) {
        products!.add(new DoctorProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['doctor_id'] = this.doctorId;
    data['hospital_id'] = this.hospitalId;
    data['user_1_id'] = this.user1Id;
    data['user_2_id'] = this.user2Id;
    data['dateTime'] = this.dateTime;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['synclat'] = syncLat;
    data['synclon'] = syncLon;
    data['callremarks'] = remarks;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DoctorProducts {
  String? productId;
  bool? sample;
  String? qty;

  DoctorProducts({this.productId, this.sample, this.qty});

  DoctorProducts.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    sample = json['sample'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['sample'] = this.sample;
    data['qty'] = this.qty;
    return data;
  }
}
