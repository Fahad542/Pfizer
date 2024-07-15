import 'package:flutter/material.dart';
import 'package:pfizer/src/base/utils/utils.dart';
import 'package:pfizer/src/models/api_resonse/doctor_call_form_model.dart';
import 'package:pfizer/src/models/api_resonse/my_shedule.dart';
import 'package:pfizer/src/shared/buttons.dart';
import 'package:pfizer/src/shared/input_field.dart';
import 'package:pfizer/src/shared/spacing.dart';
import 'package:pfizer/src/shared/top_app_bar.dart';
import 'package:pfizer/src/styles/app_colors.dart';
import 'package:pfizer/src/styles/text_theme.dart';
import 'package:stacked/stacked.dart';

import 'doctor_call_view_model.dart';

class DoctorCallView extends StatelessWidget {
  final MyScheduleData? myScheduleData;

  const DoctorCallView({Key? key, this.myScheduleData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DoctorCallViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: GeneralAppBar(
              title: "Doctor Call",
              onBackTap: () {
                Navigator.pop(context);
              }),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: (model.isBusy)
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomDropDown(
                          label: "Hospital Name",
                          value: (model.hospitalSelectedIndex == -1)
                              ? null
                              : model.hospitalDoctorData[model.hospitalSelectedIndex].hospitalName ?? "",
                          items: model.hospitalDoctorData.map((items) {
                            return items.hospitalName.toString();
                          }).toList(),
                          disabledItemFn: (val) {
                            int l = (model.hospitalDoctorData
                                    .firstWhere((element) =>
                                        element.hospitalName == val)
                                    .doctordata
                                    ?.length ??
                                0);
                            return (l > 0) ? false : true;
                          },
                          onChanged: (String? newValue) {
                            model.hospitalSelectedIndex =
                                model.hospitalDoctorData.indexWhere((element) =>
                                    element.hospitalName == newValue);
                            model.doctorSelectedIndex = 0;
                            model.notifyListeners();
                          },
                        ),
                        VerticalSpacing(15),
                        CustomDropDown(
                          label: "Doctor Name",
                          value: (model.hospitalSelectedIndex == -1 &&
                                  model.doctorSelectedIndex == -1)
                              ? null
                              : model
                                  .hospitalDoctorData[
                                      model.hospitalSelectedIndex]
                                  .doctordata![model.doctorSelectedIndex]
                                  .doctorName,
                          items: (model.hospitalSelectedIndex == -1)
                              ? []
                              : model
                                  .hospitalDoctorData[
                                      model.hospitalSelectedIndex]
                                  .doctordata!
                                  .map((items) {
                                  return items.doctorName.toString();
                                }).toList(),
                          onChanged: (String? newValue) {
                            model.doctorSelectedIndex = model
                                .hospitalDoctorData[model.hospitalSelectedIndex]
                                .doctordata!
                                .indexWhere((element) =>
                                    element.doctorName == newValue);
                            model.notifyListeners();
                          },
                        ),
                        VerticalSpacing(15),
                        Row(
                          children: [
                            Text(
                              "Accompanied Users",
                              style: TextStyling.mediumBold,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomDropDown(
                              value: (model.userSelectedIndex1 == -1)
                                  ? null
                                  : model
                                          .accompaniedUsersData[
                                              model.userSelectedIndex1]
                                          .userName ??
                                      "",
                              items: model.accompaniedUsersData.map((items) {
                                return items.userName.toString();
                              }).toList(),
                              width: context.screenSize().width * 0.4,
                              disabledItemFn: (val) {
                                return (model.userSelectedIndex2 == -1)
                                    ? false
                                    : (model
                                                .accompaniedUsersData[
                                                    model.userSelectedIndex2]
                                                .userName ==
                                            val) ??
                                        false;
                              },
                              onChanged: (String? newValue) {
                                int _index = model.accompaniedUsersData
                                    .indexWhere((element) =>
                                        element.userName == newValue);
                                if (_index != model.userSelectedIndex2) {
                                  model.userSelectedIndex1 = model
                                      .accompaniedUsersData
                                      .indexWhere((element) =>
                                          element.userName == newValue);
                                }
                                model.notifyListeners();
                                model.notifyListeners();
                                model.notifyListeners();
                              },
                            ),
                            CustomDropDown(
                              value: (model.userSelectedIndex2 == -1)
                                  ? null
                                  : model
                                          .accompaniedUsersData[
                                              model.userSelectedIndex2]
                                          .userName ??
                                      "",
                              items: model.accompaniedUsersData.map((items) {
                                return items.userName.toString();
                              }).toList(),
                              width: context.screenSize().width * 0.4,
                              disabledItemFn: (String? val) {
                                return (model.userSelectedIndex1 == -1)
                                    ? false
                                    : (model
                                            .accompaniedUsersData[
                                                model.userSelectedIndex1]
                                            .userName ==
                                        val);
                              },
                              onChanged: (String? newValue) {
                                int _index = model.accompaniedUsersData
                                    .indexWhere((element) =>
                                        element.userName == newValue);
                                if (_index != model.userSelectedIndex1) {
                                  model.userSelectedIndex2 = model
                                      .accompaniedUsersData
                                      .indexWhere((element) =>
                                          element.userName == newValue);
                                }
                                model.notifyListeners();
                              },
                            ),
                          ],
                        ),
                        VerticalSpacing(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                model.addMoreProductList();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                child: Center(
                                    child: Row(
                                  children: [
                                    Text(
                                      "Add",
                                      style: TextStyling.mediumBold
                                          .copyWith(color: AppColors.white),
                                    ),
                                    Icon(
                                      Icons.add,
                                      color: AppColors.white,
                                      size: 18,
                                    ),
                                  ],
                                )),
                              ),
                            )
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: model.selectedProductsData.length,
                          itemBuilder: (context, index) {
                            return productInputCard(
                              context,
                              model,
                              index,
                            );
                          },
                        ),
                        VerticalSpacing(20),
                        MainInputField(
                            label: "Remarks",
                            hint: "enter remarks",
                            controller: model.remarks,
                            error: "please enter remarks"),
                        VerticalSpacing(20),
                        MainButton(
                            text: "Submit",
                            isBusy: model.isBusy,
                            onTap: () {
                              model.submit();
                            }),
                      ],
                    ),
                  ),
          ),
        ),
      ),
      viewModelBuilder: () => DoctorCallViewModel(context, myScheduleData),
      onModelReady: (model) => model.init(),
    );
  }

  Widget productInputCard(
      BuildContext context, DoctorCallViewModel model, int index) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomDropDown(
                label: "Product Name",
                value: model.selectedProductsData[index].itemName ?? "",
                width: context.screenSize().width * 0.8,
                items: model.restProductsData.map((items) {
                  return items.itemName.toString();
                }).toList(),
                onChanged: (String? newValue) {
                  ProductData _oldData = model.selectedProductsData[index];
                  _oldData.isSelected = null;
                  _oldData.qty = 0;
                  model.restProductsData.add(_oldData);
                  ProductData _data = model.restProductsData
                      .firstWhere((element) => element.itemName == newValue);
                  _data.isSelected = false;
                  _data.qty = 1;
                  model.selectedProductsData[index] = _data;
                  model.restProductsData
                      .removeWhere((element) => element.itemName == newValue);
                  model.notifyListeners();
                },
              ),
              InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    model.removeProductList(index);
                  },
                  child: Icon(
                    Icons.cancel_outlined,
                    color: AppColors.red,
                  ))
            ],
          ),
          Row(
            children: [
              Checkbox(
                  value: model.selectedProductsData[index].isSelected,
                  onChanged: (val) {
                    if (val != null)
                      model.selectedProductsData[index].isSelected = val;
                    model.notifyListeners();
                  }),
              Text(
                "is sample provide?",
                style: TextStyling.mediumRegular.copyWith(
                    color:
                        (model.selectedProductsData[index].isSelected ?? false)
                            ? AppColors.green
                            : AppColors.yellow),
              ),
              Spacer(),
              if (model.selectedProductsData[index].isSelected == true)
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          if ((model.selectedProductsData[index].qty) > 1) {
                            model.selectedProductsData[index].qty--;
                          }
                          model.notifyListeners();
                        },
                        child: Icon(
                          Icons.remove_circle_outline,
                          color: AppColors.primary,
                        )),
                    HorizontalSpacing(5),
                    Text(
                      model.selectedProductsData[index].qty.toString(),
                      style: TextStyling.mediumBold,
                    ),
                    HorizontalSpacing(5),
                    InkWell(
                        onTap: () {
                          model.selectedProductsData[index].qty++;
                          model.notifyListeners();
                        },
                        child: Icon(
                          Icons.add_circle_outline_sharp,
                          color: AppColors.primary,
                        )),
                  ],
                )
            ],
          )
        ],
      ),
    );
  }
}
