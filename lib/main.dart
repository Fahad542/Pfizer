// @dart=2.9
import 'package:flutter/material.dart';
import 'package:pfizer/src/app/app_view.dart';
import 'package:pfizer/src/configs/app_setup.locator.dart';
import 'package:pfizer/src/services/local/auth_service.dart';
import 'package:pfizer/src/services/local/flavor_service.dart';
import 'package:package_info/package_info.dart';
import 'package:pfizer/src/services/local/local_db.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthService.prefs = await SharedPreferences.getInstance();
  await LocalDatabase.init();
  // getting package
  final package = await PackageInfo.fromPlatform();
  setupLocator();

  // app flavor init
  FlavorService.init(package);

  runApp(
    AppView(),
  );
}
