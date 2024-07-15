import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:pfizer/src/base/utils/Constants.dart';
import 'package:pfizer/src/configs/app_setup.locator.dart';
import 'package:pfizer/src/models/api_body/doctor_call_body_data.dart';
import 'package:pfizer/src/models/api_resonse/doctor_call_form_model.dart';
import 'package:pfizer/src/models/api_resonse/my_shedule.dart';
import 'package:pfizer/src/models/api_resonse/tagging_modal.dart';
import 'package:pfizer/src/models/api_resonse/user.dart';
import 'package:pfizer/src/services/local/auth_service.dart';
import 'package:pfizer/src/services/local/flavor_service.dart';
import 'package:pfizer/src/services/remote/Intersepters/SuperAppIntersepter.dart';
import 'package:pfizer/src/services/remote/api_client.dart';
import 'package:pfizer/src/services/remote/api_result.dart';
import 'package:pfizer/src/services/remote/network_exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../models/api_resonse/Itinerary_model.dart';
import '../../models/api_resonse/My_expense.dart';
import '../../models/api_resonse/my_litnerary.dart';

class ApiService {
  ApiClient? _apiClient;

  AuthService user = locator<AuthService>();

  ApiService() {
    _apiClient = ApiClient(Dio(),
        baseUrl: FlavorService.getSuperAppBaseApi,
        interceptors: [SuperAppApiInterceptor()]);
  }

  Future<ApiResult<UserModel>?> login(
      BuildContext context, String tCode, String userPass) async {
    try {
      var response = await _apiClient?.postReq(
        "/Login",
        data: {"t_code": tCode, "userpass": userPass},
      );
      if (response?.statusCode != 200) {
        Constants.customErrorSnack(context, response?.message.toString() ?? "");
        return null;
      }
      return ApiResult.success(data: UserModel.fromJson(response!.data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<bool>> changePassword(
      BuildContext context, String userPass) async {
    try {
      var response = await _apiClient?.postReq(
        "/ChangePassword",
        data: {"t_code": user.user?.userData?.tCode, "newpass": userPass},
      );
      Constants.customSuccessSnack(context, response?.message.toString() ?? "");
      return ApiResult.success(data: (response?.statusCode == 200) ? true : false);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<DoctorCallFormModelData>?> getHospitalDoctorList(
      BuildContext context) async {
    try {
      var response = await _apiClient?.postReq(
        "/HospitalDoctorList",
        data: {
          "userid": user.user?.userData?.userId,
          "t_code": user.user?.userData?.tCode,
          "appVersion": "4.0.1"
        },
      );
      if (response?.statusCode != 200) {
        Constants.customErrorSnack(context, response?.message.toString() ?? "");
        return null;
      }
      return ApiResult.success(
          data: DoctorCallFormModelData.fromJson(response!.data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<PfizerTagging>?> getTaggingHospitalList(
      BuildContext context) async {
    try {
      var response = await _apiClient?.postReq(
        "/UntagHospitalList",
        data: {
          "userid": user.user?.userData?.userId,
          "t_code": user.user?.userData?.tCode,
        },
      );
      if (response?.statusCode != 200) {
        Constants.customErrorSnack(context, response?.message.toString() ?? "");
        return null;
      }

      return ApiResult.success(data: PfizerTagging.fromJson(response!.data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }


  Future<ApiResult<My_Itinerary_model>?> myitinerarayList(BuildContext context) async {
    try {
      // Ensure _apiClient and user data are not null
      if (_apiClient == null || user.user?.userData == null) {
        Constants.customErrorSnack(context, "API client or user data is null");
        return null;
      }

      var response = await _apiClient!.postReq(
        "/MyItinerary",
        data: {
          "userid": user.user!.userData!.userId,
          "t_code": user.user!.userData!.tCode,
        },
      );
      if (response.statusCode != 200) {

        Constants.customErrorSnack(
            context, response.message.toString() ?? "Unknown error occurred");
        return null;
      }
      else {
        return ApiResult.success(data: My_Itinerary_model.fromJson(response.data));}
    } catch (e) {
      print("failed");
      print("Error: $e");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }







  Future<ApiResult<Itinerary_model>?> itinerarayList(BuildContext context, String? plan_id) async {
    try {
      // Ensure _apiClient and user data are not null
      if (_apiClient == null || user.user?.userData == null) {
        Constants.customErrorSnack(context, "API client or user data is null");
        return null;
      }

      var response = await _apiClient!.postReq(
        "/ItineraryDetail",
        data: {
          "userid": user.user!.userData!.userId,
          "t_code": user.user!.userData!.tCode,
          'plan_id':plan_id
        },


      );

      if (response.statusCode != 200) {

        Constants.customErrorSnack(
            context, response.message.toString() ?? "Unknown error occurred");
        return null;
      }
      else {

        return ApiResult.success(data: Itinerary_model.fromJson(response.data));}
    } catch (e) {
      print("failed");
      print("Error: $e");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<ExpenseResponse>?> myexpenseList(BuildContext context) async {
    try {
      // Ensure _apiClient and user data are not null
      if (_apiClient == null || user.user?.userData == null) {
        Constants.customErrorSnack(context, "API client or user data is null");
        return null;
      }

      var response = await _apiClient!.postReq(
        "/MyExpenseList",
        data: {
          "userid": user.user!.userData!.userId,
          "t_code": user.user!.userData!.tCode,
        },
      );
      if (response.statusCode != 200) {

        Constants.customErrorSnack(
            context, response.message.toString() ?? "Unknown error occurred");
        return null;
      }
      else {
      return ApiResult.success(data: ExpenseResponse.fromJson(response.data));}
    } catch (e) {
      print("failed");
      print("Error: $e");
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }





  Future<ApiResult<MySchedule>?> getMySchedule(BuildContext context) async {
    try {
      var response = await _apiClient?.postReq(
        "/MySchedule",
        data: {
          "userid": user.user?.userData?.userId,
          "sdate": DateTime.now().toString()
        },
      );
      if (response?.statusCode != 200) {
        Constants.customErrorSnack(context, response?.message.toString() ?? "");
        return null;
      }
      print("MySchedule:${MySchedule.fromJson(response?.data)}");
      return ApiResult.success(data: MySchedule.fromJson(response?.data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<ApiResult<String>?> addDoctorCall(
      BuildContext context, DoctorCallBody data) async {
    try {
      var response = await _apiClient?.postReq(
        "/AddDoctorCall",
        data: data.toJson(),
      );
      if (response?.statusCode != 200) {
        Constants.customErrorSnack(context, response?.message.toString() ?? "");
        return null;
      }
      return ApiResult.success(
          data: "${response?.message.toString()} in Live Database");
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }

  Future<dynamic> UploadgeoTag(
      BuildContext context,
      String hospital_id,
      String hospital_latitude,
      String hospital_longitude,
      String img_latitude,
      String img_longitude,
      var filepath) async {
    try {
      var headers = {'Authorization': 'Basic UGZpemVyQXBpOngyRnN0VnN6'};
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://pfizer.premierspulse.com/pfizer_api/AddGeoTagging'));
      request.fields.addAll({
        "user_id": '${user.user?.userData?.userId}',
        "t_code": '${user.user?.userData?.tCode}',
        'hospital_id': '${hospital_id}',
        'hospital_latitude': '${hospital_latitude}',
        'hospital_longitude': '${hospital_longitude}',
        'img_latitude': '${img_latitude}',
        'img_longitude': '${img_longitude}'
      });
      request.files
          .add(await http.MultipartFile.fromPath('img_file', filepath));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return await response.stream.bytesToString();
      } else {
        Constants.customErrorSnack(context, response.stream.toString() ?? "");
        return await response.stream.bytesToString();
      }
    } catch (e) {
      //return ApiResult.failure(error: NetworkExceptions.getDioException(e)!);
    }
  }
}
