class Itinerary_model {
  List<Itineraray>? tagging;

  Itinerary_model({this.tagging});

  Itinerary_model.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      tagging = <Itineraray>[];
      json['data'].forEach((v) {
        tagging!.add(new Itineraray.fromJson(v));
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

class Itineraray {
  String? dates;
  String? dayname;
  String? morning_area;
  String? morning_point;
  String? morning_time;
  String? evening_area;
  String? evening_point;
  String? evening_time;

  Itineraray({
    this.dates,
    this.dayname,
    this.morning_area,
    this.morning_point,
    this.morning_time,
    this.evening_area,
    this.evening_point,
    this.evening_time,
  });

  factory Itineraray.fromJson(Map<String, dynamic> json) {
    return Itineraray(
      dates: json['dates'] ?? "",
      dayname: json['dayname'] ?? "",
      morning_area: json['morning_area'] ?? "",
      morning_point: json['morning_point'] ?? "",
      morning_time: json['morning_time'] ??"",
      evening_area: json['evening_area'] ?? "",
      evening_point: json['evening_point'] ?? "",
        evening_time: json["evening_time"] ?? ""

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dates': dates,
      'dayname': dayname,
      'morning_area': morning_area,
      'morning_point': morning_point,
      'morning_time': morning_time,
      'evening_area': evening_area,
      'evening_point': evening_point,
      'evening_time':evening_time
    };
  }
}

