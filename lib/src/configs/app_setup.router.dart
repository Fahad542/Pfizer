// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/cupertino.dart' as _i8;
import 'package:flutter/material.dart';
import 'package:pfizer/src/models/api_resonse/my_shedule.dart' as _i9;
import 'package:pfizer/src/models/api_resonse/my_litnerary.dart' as _i15;
import 'package:pfizer/src/views/Tagging/tagging_view.dart' as _i11;
import 'package:pfizer/src/views/Expenses/Expenses_view.dart' as _i12;
import 'package:pfizer/src/views/Itinery/Itinerary_view.dart' as _i13;
import 'package:pfizer/src/views/Itinery/Itineraray_detail/Itinerary_detail_view.dart' as _i14;
import 'package:pfizer/src/views/change_password/change_password_view.dart'
    as _i5;
import 'package:pfizer/src/views/dashboard/dashboard_view.dart' as _i3;
import 'package:pfizer/src/views/doctor_call/doctor_call_view.dart' as _i6;
import 'package:pfizer/src/views/login/login_view.dart' as _i2;
import 'package:pfizer/src/views/my_schedule/my_schedule_view.dart' as _i7;
import 'package:pfizer/src/views/setting/setting_view.dart' as _i4;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i10;

class Routes {
  static const loginView = '/';

  static const dashboardView = '/dashboard-view';
  static const itinerary = '/Itinerary-view';

  static const settingView = '/setting-view';

  static const changePasswordView = '/change-password-view';

  static const doctorCallView = '/doctor-call-view';

  static const myScheduleView = '/my-schedule-view';
  static const ExpensesView = '/Expenses-view';
  static const tagging = '/tagging';
  static const Itinerary_detail = '/Itinerary-detail-view';
  static const all = <String>{
    loginView,
    dashboardView,
    settingView,
    changePasswordView,
    doctorCallView,
    myScheduleView,
    tagging,
    ExpensesView,
    itinerary,
    Itinerary_detail

  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.loginView,
      page: _i2.LoginView,
    ),
    _i1.RouteDef(
      Routes.dashboardView,
      page: _i3.DashboardView,
    ),
    _i1.RouteDef(
      Routes.settingView,
      page: _i4.SettingView,
    ),
    _i1.RouteDef(
      Routes.changePasswordView,
      page: _i5.ChangePasswordView,
    ),
    _i1.RouteDef(
      Routes.doctorCallView,
      page: _i6.DoctorCallView,
    ),
    _i1.RouteDef(
      Routes.myScheduleView,
      page: _i7.MyScheduleView,
    ),
    _i1.RouteDef(
      Routes.tagging,
      page: _i11.TaggingView,
    ),
    _i1.RouteDef(
      Routes.ExpensesView,
      page: _i12.ExpenseView,
    ),
    _i1.RouteDef(
      Routes.itinerary,
      page: _i13.Itinerary_view,
    ),
    _i1.RouteDef(
      Routes.Itinerary_detail,
      page: _i14.Itinerary_detail_view,
    ),
  ];


  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i2.LoginView(),
        settings: data,
      );
    },
    _i3.DashboardView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i3.DashboardView(),
        settings: data,
      );
    },
    _i4.SettingView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i4.SettingView(),
        settings: data,
      );
    },
    _i5.ChangePasswordView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i5.ChangePasswordView(),
        settings: data,
      );
    },
    _i6.DoctorCallView: (data) {
      final args = data.getArgs<DoctorCallViewArguments>(
        orElse: () => const DoctorCallViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i6.DoctorCallView(
            key: args.key, myScheduleData: args.myScheduleData),
        settings: data,
      );
    },
    _i7.MyScheduleView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i7.MyScheduleView(),
        settings: data,
      );
    },
    _i11.TaggingView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i11.TaggingView(),
        settings: data,
      );
    },
    _i12.ExpenseView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i12.ExpenseView(),
        settings: data,
      );
    },
    _i13.Itinerary_view: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i13.Itinerary_view(),
        settings: data,
      );
    },
    _i14.Itinerary_detail_view: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i14.Itinerary_detail_view(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class DoctorCallViewArguments {
  const DoctorCallViewArguments({
    this.key,
    this.myScheduleData,
  });

  final _i8.Key? key;

  final _i9.MyScheduleData? myScheduleData;
}

class Itinerary_detail {
  const Itinerary_detail({
    this.key,
    this.myScheduleData,
  });

  final _i8.Key? key;

  final _i15.My_Itineraray? myScheduleData;
}




extension NavigatorStateExtension on _i10.NavigationService {
  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDashboardView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.dashboardView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSettingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.settingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChangePasswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.changePasswordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDoctorCallView({
    _i8.Key? key,
    _i9.MyScheduleData? myScheduleData,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.doctorCallView,
        arguments:
            DoctorCallViewArguments(key: key, myScheduleData: myScheduleData),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMyScheduleView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.myScheduleView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDashboardView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.dashboardView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSettingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.settingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChangePasswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.changePasswordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDoctorCallView({
    _i8.Key? key,
    _i9.MyScheduleData? myScheduleData,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.doctorCallView,
        arguments:
            DoctorCallViewArguments(key: key, myScheduleData: myScheduleData),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMyScheduleView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.myScheduleView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
  Future<dynamic> replaceWithTaggingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  ]) async {
    return replaceWith<dynamic>(Routes.tagging,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
