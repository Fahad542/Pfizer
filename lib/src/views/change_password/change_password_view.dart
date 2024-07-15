import 'package:flutter/material.dart';
import 'package:pfizer/generated/assets.dart';
import 'package:pfizer/src/base/utils/utils.dart';
import 'package:pfizer/src/shared/buttons.dart';
import 'package:pfizer/src/shared/input_field.dart';
import 'package:pfizer/src/shared/spacing.dart';
import 'package:pfizer/src/styles/app_colors.dart';
import 'package:stacked/stacked.dart';

import 'change_password_view_model.dart';

class ChangePasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePasswordViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            child: Column(
              children: [
                VerticalSpacing(20),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                        child: Icon(
                      Icons.chevron_left,
                      color: AppColors.primary,
                      size: 36,
                    )),
                  ],
                ),
                VerticalSpacing(50),
                Image.asset(
                  Assets.imagesIcon,
                  width: context.screenSize().width * 0.6,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child: Form(
                    child: Builder(builder: (ctx) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MainInputField(
                              label: "",
                              hint: "Enter Password",
                              controller: model.password,
                              error: "enter password",
                              isPassword: (model.isShowPassword) ? false : true,
                              suffixIcon: InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    model.isShowPassword = !model.isShowPassword;
                                    model.notifyListeners();
                                  },
                                  child: Icon(
                                    Icons.remove_red_eye_outlined,
                                    size: 20,
                                    color: AppColors.primary,
                                  ))),
                          MainInputField(
                              label: "",
                              hint: "ReEnter Password",
                              controller: model.rePassword,
                              error: "re-enter password",
                              isPassword: (model.isShowRePassword) ? false : true,
                              suffixIcon: InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    model.isShowRePassword =
                                        !model.isShowRePassword;
                                    model.notifyListeners();
                                  },
                                  child: Icon(
                                    Icons.remove_red_eye_outlined,
                                    size: 20,
                                    color: AppColors.primary,
                                  ))),
                          VerticalSpacing(30),
                          MainButton(text: "Change Password", onTap: () {
                            model.onChangePassword(context, ctx);
                          },
                            isBusy: model.isBusy,
                          )
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => ChangePasswordViewModel(),
      onModelReady: (model) => model.init(),
    );
  }
}
