import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pfizer/generated/assets.dart';
import 'package:pfizer/src/base/utils/utils.dart';
import 'package:pfizer/src/configs/app_setup.router.dart';
import 'package:pfizer/src/models/api_resonse/my_shedule.dart';
import 'package:pfizer/src/services/local/navigation_service.dart';
import 'package:pfizer/src/shared/input_field.dart';
import 'package:pfizer/src/shared/spacing.dart';
import 'package:pfizer/src/shared/top_app_bar.dart';
import 'package:pfizer/src/styles/app_colors.dart';
import 'package:pfizer/src/styles/text_theme.dart';
import 'package:stacked/stacked.dart';

import '../Itinery/Itineraray_detail/Itinerary_detail_view.dart';
import 'my_schedule_view_model.dart';

class MyScheduleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyScheduleViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: GeneralAppBar(
              title: "My Schedules",
              onBackTap: () {
                Navigator.pop(context);
              }),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: (model.isBusy)
                ? Center(
                    child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ))
                : SingleChildScrollView(
                 child:Column(
                    children: [
                      MainInputField(
                        label: "Schedule Date",
                        hint: "Select Date",
                        controller: model.date,
                        error: "please select schedule date",
                        width: context.screenSize().width,
                        inputType: TextInputType.datetime,
                        readOnly: true,
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: model.selectedDateTime,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now(),
                          ).then((value) {
                            if (value != null) {
                              model.selectedDateTime = value;
                              model.date.text = DateFormat("dd/MM/yyyy")
                                  .format(value)
                                  .toString();
                              model.init();
                            }
                          });
                        },
                      ),
                      VerticalSpacing(20),
                      (model.myScheduleData.length > 0)
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: model.myScheduleData.length,
                              itemBuilder: (context, index) {
                                MyScheduleData data = model.myScheduleData[index];
                                return MyScheduleCard(
                                  data: data,
                                );
                              },
                            )
                          : Column(
                              children: [
                                VerticalSpacing(30),
                                Image.asset(
                                  Assets.imagesNoResultsFound,
                                  width: context.screenSize().width * 0.6,
                                ),
                                VerticalSpacing(10),
                                Text(
                                  "Data Not Found",
                                  style: TextStyling.largeBold
                                      .copyWith(color: AppColors.primary),
                                ),
                              ],
                            ),
                    ],
                  ),
      ),
          ),
        ),
      ),
      viewModelBuilder: () => MyScheduleViewModel(context),
      onModelReady: (model) => model.init(),
    );
  }
}

class MyScheduleCard extends StatelessWidget {
  final MyScheduleData data;

  const MyScheduleCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: "Hospital Name: ",
                style:
                    TextStyling.mediumRegular.copyWith(color: AppColors.black),
                children: [
                  TextSpan(
                    text: data.hospitalName,
                    style: TextStyling.mediumBold
                        .copyWith(color: AppColors.primary),
                  )
                ],
              ),
            ),
            VerticalSpacing(10),
            RichText(
              text: TextSpan(
                text: "Doctor Name: ",
                style:
                    TextStyling.mediumRegular.copyWith(color: AppColors.black),
                children: [
                  TextSpan(
                    text: data.doctorName,
                    style: TextStyling.mediumBold
                        .copyWith(color: AppColors.primary),
                  )
                ],
              ),
            ),
            VerticalSpacing(10),
            RichText(
              text: TextSpan(
                text: "Area: ",
                style:
                    TextStyling.mediumRegular.copyWith(color: AppColors.black),
                children: [
                  TextSpan(
                    text: data.brickName,
                    style: TextStyling.mediumBold
                        .copyWith(color: AppColors.primary),
                  )
                ],
              ),
            ),
            VerticalSpacing(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: (){
                     NavService.doctorCall(arguments: DoctorCallViewArguments(myScheduleData: data));

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.primary.withOpacity(0.6),
                    ),
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Text(
                      "Make Call",
                      style: TextStyling.mediumBold.copyWith(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
