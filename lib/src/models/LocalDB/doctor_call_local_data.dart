import 'package:hive/hive.dart';

part 'doctor_call_local_data.g.dart';

@HiveType(typeId: 0)
class DoctorCallLocalDB extends HiveObject{
  @HiveField(0)
  String? doctorId;
  @HiveField(1)
  String? hospitalId;
  @HiveField(2)
  String? user1Id;
  @HiveField(3)
  String? user2Id;
  @HiveField(4)
  String? dateTime;
  @HiveField(5)
  String? lat;
  @HiveField(6)
  String? lon;
  @HiveField(7)
  String? remarks;
  @HiveField(8)
  List<DoctorProductsLocalDB>? products;

  DoctorCallLocalDB(
      {this.doctorId,
        this.hospitalId,
        this.user1Id,
        this.user2Id,
        this.dateTime,
        this.lat,
        this.lon,
        this.remarks,
        this.products});
}

@HiveType(typeId: 1)
class DoctorProductsLocalDB extends HiveObject {
  @HiveField(0)
  String? productId;
  @HiveField(1)
  bool? sample;
  @HiveField(2)
  String? qty;

  DoctorProductsLocalDB({this.productId, this.sample, this.qty});

}
