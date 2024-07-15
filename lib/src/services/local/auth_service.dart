import 'dart:convert';
import 'package:pfizer/src/models/api_resonse/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class AuthService with ReactiveServiceMixin {
  static late SharedPreferences prefs;
  ReactiveValue<UserModel?> _user = ReactiveValue<UserModel?>(null);
  ReactiveValue<DateTime?> _datetime = ReactiveValue<DateTime?>(null);

  UserModel? get user => _user.value;
  DateTime? get datetime => _datetime.value;
  final String _prefKey = "USER_LOGIN_DATA";

  AuthService() {
    listenToReactiveValues([_user]);
    listenToReactiveValues([_datetime]);
    _restoreUserFromLocal();
  }

  set user(UserModel? user) {
    _user.value = user;
    _storeLocally();
  }
  set datetime(DateTime? time) {
    _datetime.value = time;
    _storeLocally();
  }

  logout() {
    _clearUserFromLocal();
  }

  _storeLocally() async {
    if (_user.value == null) return;
    prefs.setString(_prefKey, jsonEncode(_user.value?.toJson() ?? {}));
  }

  _restoreUserFromLocal() async {
    if (!prefs.containsKey(_prefKey)) return;
    user = UserModel.fromJson(jsonDecode(prefs.getString(_prefKey) ?? "{}"));
    _datetime.value = DateTime.now();
  }

  _clearUserFromLocal() async {
    if (!prefs.containsKey(_prefKey)) return;
    prefs.remove(_prefKey);
    _user.value = null;
    _datetime.value = null;
  }
}