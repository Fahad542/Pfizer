class UserModel {
  UserData? userData;
  List<MenuData>? menuData;

  UserModel({this.userData, this.menuData});

  UserModel.fromJson(Map<String, dynamic> json) {
    userData = json['data'] != null ? new UserData.fromJson(json['data']) : null;
    if (json['menudata'] != null) {
      menuData = <MenuData>[];
      json['menudata'].forEach((v) {
        menuData!.add(new MenuData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userData != null) {
      data['data'] = this.userData!.toJson();
    }
    if (this.menuData != null) {
      data['menudata'] = this.menuData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserData {
  String? userId;
  String? tCode;
  String? userName;
  String? parentId;
  String? userType;

  UserData({this.userId, this.tCode, this.userName, this.parentId, this.userType});

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    tCode = json['t_code'];
    userName = json['user_name'];
    parentId = json['parent_id'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['t_code'] = this.tCode;
    data['user_name'] = this.userName;
    data['parent_id'] = this.parentId;
    data['user_type'] = this.userType;
    return data;
  }
}

class MenuData {
  String? name;
  String? icon;
  String? status;

  MenuData({this.name, this.icon, this.status});

  MenuData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['status'] = this.status;
    return data;
  }
}
