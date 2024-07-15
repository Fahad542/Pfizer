import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pfizer/generated/assets.dart';
import 'package:pfizer/src/base/utils/Constants.dart';
import 'package:pfizer/src/services/local/navigation_service.dart';
import 'package:pfizer/src/shared/spacing.dart';
import 'package:pfizer/src/styles/app_colors.dart';
import 'package:pfizer/src/styles/text_theme.dart';
import 'package:pfizer/src/views/login/login_view.dart';

class AppView extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.primary,
      statusBarIconBrightness: Brightness.light,
    ));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp(
      title: Constants.appTitle,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: NavService.onGenerateRoute,
      navigatorKey: NavService.key,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
          colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: AppColors.primary,
              onPrimary: AppColors.white,
              secondary: AppColors.secondary,
              onSecondary: AppColors.white,
              error: AppColors.red,
              onError: AppColors.white,
              background: AppColors.white,
              onBackground: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.primary),
          fontFamily: 'Poppins'),
      home: LoginView(),
      builder: (context, child) {
        return Navigator(
          onGenerateRoute: (setting) => MaterialPageRoute(
              builder: (_) => Scaffold(
                    body: Stack(
                      children: [child!],
                    ),
                  )),
        );
      },
    );
  }
}
