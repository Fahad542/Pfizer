import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pfizer/src/configs/app_setup.locator.dart';
import 'package:pfizer/src/configs/app_setup.router.dart';
import 'package:stacked_services/stacked_services.dart';

class NavService {
  static NavigationService? _navigationService = locator<NavigationService>();
  // key
  static GlobalKey<NavigatorState>? get key => StackedService.navigatorKey;
  // on generate route
  static Route<dynamic>? Function(RouteSettings) get onGenerateRoute =>
      StackedRouter().onGenerateRoute;

  // nested routes with args for root navigator
  static Future<dynamic>? login({dynamic arguments}) => _navigationService!
      .clearStackAndShow(Routes.loginView, arguments: arguments);
  static Future<dynamic>? dashboard({dynamic arguments}) => _navigationService!
      .clearStackAndShow(Routes.dashboardView, arguments: arguments);
  static Future<dynamic>? setting({dynamic arguments}) =>
      _navigationService!.navigateTo(Routes.settingView, arguments: arguments);
  static Future<dynamic>? changePassword({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.changePasswordView, arguments: arguments);
  static Future<dynamic>? doctorCall({dynamic arguments}) => _navigationService!
      .navigateTo(Routes.doctorCallView, arguments: arguments);
  static Future<dynamic>? mySchedule({dynamic arguments}) => _navigationService!
      .navigateTo(Routes.myScheduleView, arguments: arguments);
  static Future<dynamic>? tagging({dynamic arguments}) =>
      _navigationService!.navigateTo(Routes.tagging, arguments: arguments);
  static Future<dynamic>? expenses({dynamic arguments}) =>
      _navigationService!.navigateTo(Routes.ExpensesView, arguments: arguments);
  static Future<dynamic>? Itinerary({dynamic arguments}) =>
      _navigationService!.navigateTo(Routes.itinerary, arguments: arguments);
  static Future<dynamic>? Itinerary_detail({dynamic arguments}) =>
      _navigationService!.navigateTo(Routes.Itinerary_detail, arguments: arguments);
}
