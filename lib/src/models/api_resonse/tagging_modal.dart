class PfizerTagging {
  List<Tagging>? tagging;

  PfizerTagging({this.tagging});

  PfizerTagging.fromJson(Map<String, dynamic> json) {
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
  int index;
  String hospitalId;
  String hospitalName;
  String hospitalAddress;
  String brickName;

  Tagging({
    required this.index,
    required this.hospitalId,
    required this.hospitalName,
    required this.hospitalAddress,
    required this.brickName,
  });

  factory Tagging.fromJson(Map<String, dynamic> json) => Tagging(
        index: json["index"],
        hospitalId: json["hospital_id"],
        hospitalName: json["hospital_name"],
        hospitalAddress: json["hospital_address"],
        brickName: json["brick_name"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "hospital_id": hospitalId,
        "hospital_name": hospitalName,
        "hospital_address": hospitalAddress,
        "brick_name": brickName,
      };
}
