class My_Itinerary_model {
  List<My_Itineraray>? tagging;

  My_Itinerary_model({this.tagging});

  My_Itinerary_model.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      tagging = <My_Itineraray>[];
      json['data'].forEach((v) {
        tagging!.add(new My_Itineraray.fromJson(v));
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

class My_Itineraray {
  String? plan_id;
  String? plandate;
  String? t_code;
  String? user_name;
  String? totaldays;


  My_Itineraray({
    this.plan_id,
    this.plandate,
    this.t_code,
    this.user_name,
    this.totaldays,

  });

  factory My_Itineraray.fromJson(Map<String, dynamic> json) {
    return My_Itineraray(
        plan_id: json['plan_id'] ?? "",
        plandate: json['plandate'] ?? "",
        t_code: json['t_code'] ?? "",
        user_name: json['user_name'] ?? "",
        totaldays: json['totaldays'] ??"",

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plan_id': plan_id,
      'plandate': plandate,
      't_code': t_code,
      'user_name': user_name,
      'totaldays': totaldays,

    };
  }
}
