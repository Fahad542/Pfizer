import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pfizer/generated/assets.dart';
import 'package:pfizer/src/shared/buttons.dart';
import 'package:pfizer/src/shared/spacing.dart';
import 'package:pfizer/src/styles/app_colors.dart';
import 'package:pfizer/src/styles/text_theme.dart';
import 'package:stacked/stacked.dart';
import 'dart:math' as math;
import '../../services/local/navigation_service.dart';
import 'setting_view_model.dart';

class SettingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: (model.isBusy) ? Center(child: CircularProgressIndicator(color: AppColors.primary,)) : Stack(
            children: [
              Image.asset(
                Assets.imagesLoginBackground2,
              ),
              Column(
                children: [
                  VerticalSpacing(20),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.chevron_left,
                            color: AppColors.white,
                            size: 36,
                          )),
                    ],
                  ),
                  Spacer(),
                  CachedNetworkImage(
                    height: 120,
                    width: 120,
                    fit: BoxFit.contain,
                    imageUrl:
                        "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                    placeholder: (context, url) =>
                        Center(child: Image.asset(Assets.imagesNoResultsFound)),
                    errorWidget: (context, url, error) =>
                        Center(child: Icon(Icons.error)),
                  ),
                  VerticalSpacing(10),
                  Text(
                    "UserName:",
                    style: TextStyling.largeBold.copyWith(
                        color: AppColors.black,
                        decoration: TextDecoration.underline),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    model.authService.user?.userData?.userName.toString() ?? "",
                    style: TextStyling.largeBold
                        .copyWith(color: AppColors.primary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  VerticalSpacing(10),
                  Text(
                    "Territory Code:",
                    style: TextStyling.largeBold.copyWith(
                        color: AppColors.black,
                        decoration: TextDecoration.underline),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    model.authService.user?.userData?.tCode.toString() ?? "",
                    style: TextStyling.largeBold
                        .copyWith(color: AppColors.primary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  VerticalSpacing(10),
                  Text(
                    "Position:",
                    style: TextStyling.largeBold.copyWith(
                        color: AppColors.black,
                        decoration: TextDecoration.underline),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    model.authService.user?.userData?.userType.toString() ?? "",
                    style: TextStyling.largeBold
                        .copyWith(color: AppColors.primary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: (){
                      NavService.changePassword();
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: AppColors.primaryBoxShadow,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Change Password",
                            style: TextStyling.mediumBold
                                .copyWith(color: AppColors.primary),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 24,
                            color: AppColors.primary,
                          )
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Spacer(),
                  MainButton(
                      text: "LogOut",
                      color: AppColors.red,
                      icon: Icon(
                        Icons.logout,
                        color: AppColors.white,
                      ),
                      onTap: () {
                        model.onLogout(context);
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => SettingViewModel(),
      onModelReady: (model) => model.init(),
    );
  }
}
