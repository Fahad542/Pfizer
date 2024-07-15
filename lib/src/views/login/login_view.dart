import 'package:flutter/material.dart';
import 'package:pfizer/generated/assets.dart';
import 'package:pfizer/src/base/utils/utils.dart';
import 'package:pfizer/src/shared/buttons.dart';
import 'package:pfizer/src/shared/input_field.dart';
import 'package:pfizer/src/shared/spacing.dart';
import 'package:pfizer/src/styles/app_colors.dart';
import 'package:pfizer/src/styles/text_theme.dart';
import 'package:stacked/stacked.dart';

import 'login_view_model.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      Assets.imagesLoginBackground,
                      width: context.screenSize().width,
                    ),
                    Positioned(
                        left: 10,
                        top: context.screenSize().width / 5,
                        bottom: 0,
                        child: Text(
                          "Welcome to\nPfizer Portal",
                          style: TextStyling.extraLargeBold
                              .copyWith(color: AppColors.white),
                        )),
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  height:
                      context.screenSize().height - context.screenSize().width,
                  child: Form(
                    child: Builder(
                      builder: (ctx) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MainInputField(
                                label: "",
                                hint: "Enter Territory",
                                controller: model.username,
                                error: "enter territory"),
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
                            VerticalSpacing(30),
                            MainButton(
                                text: "Login",
                                isBusy: model.isBusy,
                                onTap: () {
                                  model.onLogin(ctx);
                                })
                          ],
                        );
                      }
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (model) => model.init(),
    );
  }
}
