// class ExpenseResponse {
//   String status;
//   String statusMessage;
//   ResponseData response;
//
//   ExpenseResponse({
//     required this.status,
//     required this.statusMessage,
//     required this.response,
//   });
//
//   factory ExpenseResponse.fromJson(Map<String, dynamic> json) {
//     return ExpenseResponse(
//       status: json['status'],
//       statusMessage: json['status_message'],
//       response: ResponseData.fromJson(json['response']),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'status_message': statusMessage,
//       'response': response.toJson(),
//     };
//   }
// }
//
// class ResponseData {
//   List<ExpenseData> data;
//
//   ResponseData({required this.data});
//
//   factory ResponseData.fromJson(Map<String, dynamic> json) {
//     var list = json['data'] as List;
//     List<ExpenseData> dataList =
//     list.map((item) => ExpenseData.fromJson(item)).toList();
//     return ResponseData(data: dataList);
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'data': data.map((item) => item.toJson()).toList(),
//     };
//   }
// }
//
// class ExpenseData {
//   String? expenseId;
//   String? expensedate;
//   String? expEmployeeCode;
//   String? expUserName;
//   String? totalNoDay;
//   String? totalexpamount;
//   String? approvalStatus;
//
//   ExpenseData({
//     this.expenseId,
//     this.expensedate,
//     this.expEmployeeCode,
//     this.expUserName,
//     this.totalNoDay,
//     this.totalexpamount,
//     this.approvalStatus,
//   });
//
//   factory ExpenseData.fromJson(Map<String, dynamic> json) {
//     return ExpenseData(
//       expenseId: json['expense_id'] ?? "",
//       expensedate: json['expensedate'] ?? "",
//       expEmployeeCode: json['exp_employee_code'] ?? "",
//       expUserName: json['exp_user_name'] ?? "",
//       totalNoDay: json['total_no_day'] ??"",
//       totalexpamount: json['totalexpamount'] ?? "",
//       approvalStatus: json['approval_status'] ?? "",
//
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'expense_id': expenseId,
//       'expensedate': expensedate,
//       'exp_employee_code': expEmployeeCode,
//       'exp_user_name': expUserName,
//       'total_no_day': totalNoDay,
//       'totalexpamount': totalexpamount,
//       'approval_status': approvalStatus,
//     };
//   }
// }







class ExpenseResponse {
  List<Tagging>? tagging;

  ExpenseResponse({this.tagging});

  ExpenseResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      tagging = <Tagging>[];
      json['data'].forEach((v) {
        tagging!.add(new Tagging.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tagging != null) {
      data['data'] = this.tagging!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tagging {
  String? expenseId;
  String? expensedate;
  String? expEmployeeCode;
  String? expUserName;
  String? totalNoDay;
  String? totalexpamount;
  String? approvalStatus;

  Tagging({
     this.expenseId,
    this.expensedate,
    this.expEmployeeCode,
    this.expUserName,
    this.totalNoDay,
    this.totalexpamount,
    this.approvalStatus,
  });

    factory Tagging.fromJson(Map<String, dynamic> json) {
    return Tagging(
      expenseId: json['expense_id'] ?? "",
      expensedate: json['expensedate'] ?? "",
      expEmployeeCode: json['exp_employee_code'] ?? "",
      expUserName: json['exp_user_name'] ?? "",
      totalNoDay: json['total_no_day'] ??"",
      totalexpamount: json['totalexpamount'] ?? "",
      approvalStatus: json['approval_status'] ?? "",

    );
  }

   Map<String, dynamic> toJson() {
    return {
      'expense_id': expenseId,
      'expensedate': expensedate,
      'exp_employee_code': expEmployeeCode,
      'exp_user_name': expUserName,
      'total_no_day': totalNoDay,
      'totalexpamount': totalexpamount,
      'approval_status': approvalStatus,
    };
  }
}

