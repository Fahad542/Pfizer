import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfizer/src/base/utils/utils.dart';
import 'package:pfizer/src/services/local/navigation_service.dart';
import 'package:stacked/stacked.dart';
import '../../../generated/assets.dart';
import '../../configs/app_setup.router.dart';
import '../../models/api_resonse/Itinerary_model.dart';
import '../../models/api_resonse/My_expense.dart';
import '../../models/api_resonse/my_litnerary.dart';
import '../../shared/spacing.dart';
import '../../shared/top_app_bar.dart';
import '../../styles/app_colors.dart';
import '../../styles/text_theme.dart';
import 'Itineraray_detail/Itinerary_detail_view.dart';
import 'Itinerary_view_model.dart';

class Itinerary_view extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItinerayViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: GeneralAppBar(
              title: "My Itinerary",
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
                      My_Itineraray data = model.Data[index];
                      return MyScheduleCard(
                          data: data,);

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
      viewModelBuilder: () => ItinerayViewModel(context),
      onModelReady: (model) => model.init(),
    );
  }
}

class MyScheduleCard extends StatelessWidget {
  final My_Itineraray data;




  const MyScheduleCard({Key? key, required this.data }) : super(key: key);

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
                text: "Name: ",
                style:
                TextStyling.mediumRegular.copyWith(color: AppColors.black),
                children: [
                  TextSpan(
                    text: data.user_name,
                    style: TextStyling.mediumBold
                        .copyWith(color: AppColors.primary),
                  )
                ],
              ),
            ),
            VerticalSpacing(10),
            RichText(
              text: TextSpan(
                text: "Employee Code: ",
                style:
                TextStyling.mediumRegular.copyWith(color: AppColors.black),
                children: [
                  TextSpan(
                    text: data.t_code,
                    style: TextStyling.mediumBold
                        .copyWith(color: AppColors.primary),
                  )
                ],
              ),
            ),
            VerticalSpacing(10),
            RichText(
              text: TextSpan(
                text: "Plan Date: ",
                style:
                TextStyling.mediumRegular.copyWith(color: AppColors.black),
                children: [
                  TextSpan(
                    text: data.plandate,
                    style: TextStyling.mediumBold
                        .copyWith(color: AppColors.primary),
                  )
                ],
              ),
            ),

            VerticalSpacing(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Total number of days: ",
                    style:
                    TextStyling.mediumRegular.copyWith(color: AppColors.black),
                    children: [
                      TextSpan(
                        text: data.totaldays,
                        style: TextStyling.mediumBold
                            .copyWith(color: AppColors.primary),

                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                   // NavService.Itinerary_detail(arguments:Itinerary_detail(myScheduleData: data) );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Itinerary_detail_view(data:data)

                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Text("See details", style: TextStyle(color: AppColors.white, fontSize: 10),),),
                )
              ],
            ),



            //VerticalSpacing(10),

          ],
        ),
      ),
    );
  }
}