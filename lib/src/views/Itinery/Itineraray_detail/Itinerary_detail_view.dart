import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfizer/src/base/utils/utils.dart';
import 'package:stacked/stacked.dart';
import '../../../../generated/assets.dart';
import '../../../models/api_resonse/Itinerary_model.dart';
import '../../../models/api_resonse/my_litnerary.dart';
import '../../../shared/spacing.dart';
import '../../../shared/top_app_bar.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/text_theme.dart';
import 'Itinerary_detail_view_model.dart';



class Itinerary_detail_view extends StatelessWidget {
  final My_Itineraray? data;
   Itinerary_detail_view({Key? key,  this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItineraydetailViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: GeneralAppBar(
              title: model.data?.user_name ?? "",
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

                  (model.Data.length > 0)
                      ? ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: model.Data.length,
                    itemBuilder: (context, index) {
                      Itineraray data = model.Data[index];
                      return MyScheduleCard(
                        data: data);

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
      viewModelBuilder: () => ItineraydetailViewModel(context, data),
      onModelReady: (model) => model.init(),
    );
  }
}

class MyScheduleCard extends StatelessWidget {
  final Itineraray data;




  const MyScheduleCard({Key? key, required this.data }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  data.dayname !="Sunday" ? Card(
      color: AppColors.white,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: "Days: ",
                style:
                TextStyling.mediumRegular.copyWith(color: AppColors.black),
                children: [
                  TextSpan(
                    text: data.dates,
                    style: TextStyling.mediumBold
                        .copyWith(color: AppColors.primary),

                  )
                ],
              ),
            ),
            VerticalSpacing(10),
            RichText(
              text: TextSpan(
                text: "Day Name: ",
                style:
                TextStyling.mediumRegular.copyWith(color: AppColors.black),
                children: [
                  TextSpan(
                    text: data.dayname,
                    style: TextStyling.mediumBold
                        .copyWith(color: AppColors.primary),
                  )
                ],
              ),
            ),
            VerticalSpacing(10),
            RichText(
              text: TextSpan(
                text: "Morning Area: ",
                style:
                TextStyling.mediumRegular.copyWith(color: AppColors.black),
                children: [
                  TextSpan(
                    text: data.morning_area,
                    style: TextStyling.mediumBold
                        .copyWith(color: AppColors.primary),
                  )
                ],
              ),
            ),
            VerticalSpacing(10),
            RichText(
              text: TextSpan(
                text: "Morning Point: ",
                style:
                TextStyling.mediumRegular.copyWith(color: AppColors.black),
                children: [
                  TextSpan(
                    text: data.morning_point,
                    style: TextStyling.mediumBold
                        .copyWith(color: AppColors.primary),
                  )
                ],
              ),
            ),

            VerticalSpacing(10),

            RichText(
              text: TextSpan(
                text: "Morning Time: ",
                style:
                TextStyling.mediumRegular.copyWith(color: AppColors.black),
                children: [
                  TextSpan(
                    text: data.morning_time,
                    style: TextStyling.mediumBold
                        .copyWith(color: AppColors.primary),

                  )
                ],
              ),
            ),
            VerticalSpacing(10),
            RichText(
              text: TextSpan(
                text: "Evening Area: ",
                style:
                TextStyling.mediumRegular.copyWith(color: AppColors.black),
                children: [
                  TextSpan(
                    text: data.evening_area,
                    style: TextStyling.mediumBold
                        .copyWith(color: AppColors.primary),
                  )
                ],
              ),
            ),
            VerticalSpacing(10),
            RichText(
              text: TextSpan(
                text: "Evening Point: ",
                style:
                TextStyling.mediumRegular.copyWith(color: AppColors.black),
                children: [
                  TextSpan(
                    text: data.evening_point,
                    style: TextStyling.mediumBold
                        .copyWith(color: AppColors.primary),
                  )
                ],
              ),
            ),

            VerticalSpacing(10),

                RichText(
                  text: TextSpan(
                    text: "Evening Time: ",
                    style:
                    TextStyling.mediumRegular.copyWith(color: AppColors.black),
                    children: [
                      TextSpan(
                        text: data.evening_time,
                        style: TextStyling.mediumBold
                            .copyWith(color: AppColors.primary),

                      )
                    ],
                  ),
                ),






         
          ],
        ),
      ),
    ):Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(color: AppColors.primary,
      borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
      Center(child: Text("Sunday off", style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),textAlign: TextAlign.center,))
    ],),);
  }
}