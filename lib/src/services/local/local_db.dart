import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pfizer/src/base/utils/Constants.dart';
import 'package:pfizer/src/models/LocalDB/doctor_call_local_data.dart';
import 'package:pfizer/src/models/api_resonse/doctor_call_form_model.dart';
import 'package:pfizer/src/models/api_resonse/my_shedule.dart';
import 'package:pfizer/src/models/usable_data/usable_data_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stacked/stacked.dart';

class LocalDatabase with ReactiveServiceMixin {
  static late Box doctorCallDb;
  static late Database database;
  ReactiveValue<int> countCalls = ReactiveValue<int>(0);
  LocalDatabase() {
    listenToReactiveValues([countCalls]);
    () async {
      await init();
      countCalls.value = doctorCallDb.values.length;
    }();
  }

  static Future<void> init() async {
    //Hive
    var directory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(directory.path);
    Hive.resetAdapters();
    Hive.registerAdapter(DoctorCallLocalDBAdapter());
    Hive.registerAdapter(DoctorProductsLocalDBAdapter());
    doctorCallDb = await Hive.openBox<DoctorCallLocalDB>('doctor_call');
    //Hive

    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'pfizer123.db');
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // ProductData
        await db.execute(
            'CREATE TABLE ProductData (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, product_id TEXT, item_name TEXT)');
        // AccompaniedUserData
        await db.execute(
            'CREATE TABLE AccompaniedUserData (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, user_id TEXT, user_name TEXT, user_type TEXT)');
        // HospitalDoctorData
        await db.execute(
            'CREATE TABLE HospitalDoctorData (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, hospital_id TEXT, hospital_name TEXT, hospital_address TEXT)');
        // OnlyDoctorData
        await db.execute(
            'CREATE TABLE OnlyDoctorData (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, doctor_id TEXT, doctor_name TEXT, phone_no TEXT, speciality_title TEXT, hospital_id TEXT)');
        // MySchedule
        await db.execute(
            'CREATE TABLE MySchedule (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, schedule_id TEXT, detail_id TEXT, brick_code TEXT, brick_name TEXT, hospital_name TEXT, doctor_name TEXT, doctor_id TEXT, hospital_id TEXT, schedule_date TEXT, status TEXT)');
      },
    );
  }

  //Hive
  Future<List<DoctorCallLocalDB>?> addDoctorCall(
      BuildContext context, DoctorCallLocalDB data) async {
    try {
      await doctorCallDb.add(data);
      data.save();
      countCalls.value = doctorCallDb.values.length;
      return doctorCallDb.values.toList().cast<DoctorCallLocalDB>();
    } catch (e) {
      Constants.customErrorSnack(context, e.toString());
      return null;
    }
  }

  Future<List<DoctorCallLocalDB>?> getAllDoctorCall(
      BuildContext context) async {
    try {
      countCalls.value = doctorCallDb.values.length;
      return doctorCallDb.values.toList().cast<DoctorCallLocalDB>();
    } catch (e) {
      Constants.customErrorSnack(context, e.toString());
      return null;
    }
  }

  // Future<bool> deleteAllDoctorCall(BuildContext context) async {
  //   bool isDeleted = false;
  //   try {
  //     await doctorCallDb.deleteFromDisk();
  //     doctorCallDb = await Hive.openBox<DoctorCallLocalDB>('doctor_call');
  //     isDeleted = true;
  //     return isDeleted;
  //   } catch (e) {
  //     Constants.customErrorSnack(context, e.toString());
  //     return isDeleted;
  //   }
  // }
  Future<bool> deleteDoctorCall(
      BuildContext context, DoctorCallLocalDB data) async {
    bool isDeleted = false;
    try {
      await data.delete();
      var d = doctorCallDb.values.toList().cast<DoctorCallLocalDB>();
      isDeleted = true;
      return isDeleted;
    } catch (e) {
      Constants.customErrorSnack(context, e.toString());
      return isDeleted;
    }
  }
  //Hive

  Future<UsableDataModel> insertIntoTables(UsableDataModel? dataModel) async {
    await database.rawQuery('DELETE FROM ProductData');
    List<dynamic> _productData = [];
    dataModel?.doctorCallFormModelData?.productData?.forEach((element) async {
      var p = await database.rawQuery(
          "INSERT INTO ProductData(product_id, item_name) VALUES ('${element.productId}', '${element.itemName}')");
      _productData.add(p);
    });
    List<dynamic> _accompaniedUserData = [];
    await database.rawQuery('DELETE FROM AccompaniedUserData');
    dataModel?.doctorCallFormModelData?.accompaniedUserData
        ?.forEach((element) async {
      var p = await database.rawQuery(
          "INSERT INTO AccompaniedUserData(user_id, user_name, user_type) VALUES ('${element.userId}', '${element.userName}', '${element.userType}')");
      _accompaniedUserData.add(p);
    });
    List<dynamic> _hospitalDoctorData = [];
    await database.rawQuery('DELETE FROM HospitalDoctorData');
    await database.rawQuery('DELETE FROM OnlyDoctorData');
    dataModel?.doctorCallFormModelData?.hospitalDoctorData
        ?.forEach((element) async {
      var p = await database.rawQuery(
          "INSERT INTO HospitalDoctorData(hospital_id, hospital_name, hospital_address) VALUES ('${element.hospitalId}', '${element.hospitalName}', '${element.hospitalAddress}')");
      element.doctordata?.forEach((e) async {
        await database.rawQuery(
            "INSERT INTO OnlyDoctorData(doctor_id, doctor_name, phone_no, speciality_title, hospital_id) VALUES ('${e.doctorId}', '${e.doctorName}', '${e.phoneNo}', '${e.specialityTitle}', '${element.hospitalId}')");
      });
      _hospitalDoctorData.add(p);
    });
    List<dynamic> _myScheduleData = [];
    await database.rawQuery('DELETE FROM MySchedule');
    dataModel?.mySchedule?.myScheduleData?.forEach((element) async {
      var p = await database.rawQuery(
          "INSERT INTO MySchedule(schedule_id, detail_id, brick_code, brick_name, hospital_name, doctor_name, doctor_id, hospital_id, schedule_date, status) VALUES ('${element.scheduleId}', '${element.detailId}', '${element.brickCode}', '${element.brickName}', '${element.hospitalName}', '${element.doctorName}', '${element.doctorId}', '${element.hospitalId}', '${element.scheduleDate}', '${element.isApplied}')");
      _myScheduleData.add(p);
    });
    return await getFromTable();
  }

  Future<void> UpdateOfflineStatus(String detail_id) async {
    final myScheduleDataMapsupdate = await database.rawQuery(
      "Update  MySchedule set status='1' where detail_id='${detail_id}'",
    );
    myScheduleDataMapsupdate;
  }

  Future<UsableDataModel> getFromTable() async {
    List<ProductData>? productsData;
    List<AccompaniedUserData>? accompaniedUserData;
    List<HospitalDoctorData>? hospitalDoctorData;
    List<MyScheduleData>? myScheduleData;

    final productDataMaps = await database.query(
      "ProductData",
    );
    if (productDataMaps.isNotEmpty)
      productsData = ProductData.fromJsonList(productDataMaps);

    final accompaniedUserDataMaps = await database.query(
      "AccompaniedUserData",
    );
    if (accompaniedUserDataMaps.isNotEmpty)
      accompaniedUserData =
          AccompaniedUserData.fromJsonList(accompaniedUserDataMaps);

    final onlyDoctorDataMaps = await database.query(
      "OnlyDoctorData",
    );
    final hospitalDoctorDataMaps = await database.query(
      "HospitalDoctorData",
    );
    if (accompaniedUserDataMaps.isNotEmpty) {
      hospitalDoctorData = HospitalDoctorData.fromJsonList(
          hospitalDoctorDataMaps, onlyDoctorDataMaps);
    }

    final myScheduleDataMaps = await database.query(
      "MySchedule",
    );
    if (myScheduleDataMaps.isNotEmpty)
      myScheduleData = MyScheduleData.fromJsonList(myScheduleDataMaps);

    DoctorCallFormModelData doctorCallFormModelData = DoctorCallFormModelData(
        productData: productsData,
        accompaniedUserData: accompaniedUserData,
        hospitalDoctorData: hospitalDoctorData);
    MySchedule mySchedule = MySchedule(myScheduleData: myScheduleData);

    return UsableDataModel(
        doctorCallFormModelData: doctorCallFormModelData,
        mySchedule: mySchedule);
  }
  // delete({String? tableName}) async {
  //   if (tableName == null) {
  //     await database.delete("ProductData");
  //     await database.delete("AccompaniedUserData");
  //     await database.delete("OnlyDoctorData");
  //     await database.delete("HospitalDoctorData");
  //     await database.delete("MySchedule");
  //   } else {
  //     await database.delete(tableName);
  //   }
  // }
}
