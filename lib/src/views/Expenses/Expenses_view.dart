import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfizer/src/base/utils/utils.dart';
import 'package:stacked/stacked.dart';
import '../../../generated/assets.dart';
import '../../models/api_resonse/My_expense.dart';
import '../../shared/spacing.dart';
import '../../shared/top_app_bar.dart';
import '../../styles/app_colors.dart';
import '../../styles/text_theme.dart';
import 'Expenses_view_model.dart';

class ExpenseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyExpenseViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: GeneralAppBar(
              title: "My Expenses",
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
                      Tagging data = model.Data[index];
                      return MyScheduleCard(
                        data: data, color: model.getColorForStatus(data.approvalStatus.toString())
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
      viewModelBuilder: () => MyExpenseViewModel(context),
      onModelReady: (model) => model.init(),
    );
  }
}

class MyScheduleCard extends StatelessWidget {
  final Tagging data;
  final Color color;


  const MyScheduleCard({Key? key, required this.data, required this.color}) : super(key: key);

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
                    text: data.expUserName,
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
                    text: data.expEmployeeCode,
                    style: TextStyling.mediumBold
                        .copyWith(color: AppColors.primary),
                  )
                ],
              ),
            ),
            VerticalSpacing(10),
            RichText(
              text: TextSpan(
                text: "Expense Month: ",
                style:
                TextStyling.mediumRegular.copyWith(color: AppColors.black),
                children: [
                  TextSpan(
                    text: data.expensedate,
                    style: TextStyling.mediumBold
                        .copyWith(color: AppColors.primary),
                  )
                ],
              ),
            ),

            VerticalSpacing(10),
            RichText(
              text: TextSpan(
                text: "Total number of days: ",
                style:
                TextStyling.mediumRegular.copyWith(color: AppColors.black),
                children: [
                  TextSpan(
                      text: data.totalNoDay,
                    style: TextStyling.mediumBold
                        .copyWith(color: AppColors.primary),

                  )
                ],
              ),
            ),
            VerticalSpacing(10),
            RichText(
              text: TextSpan(
                text: "Total Expense amount: ",
                style:
                TextStyling.mediumRegular.copyWith(color: AppColors.black),
                children: [
                  TextSpan(
                    text: data.totalexpamount,
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
                    text: "Status: ",
                    style:
                    TextStyling.mediumRegular.copyWith(color: AppColors.black),
                    children: [
                      TextSpan(
                        text: data.approvalStatus,
                      style: TextStyle(color: color)

                      )
                    ],
                  ),
                ),
                // InkWell(
                //   onTap: () => ontap(),
                //   child: Container(
                //     padding: EdgeInsets.all(8),
                //     decoration: BoxDecoration(color: AppColors.primary,
                //     borderRadius: BorderRadius.circular(12)
                //     ),
                //     child: Text("See details", style: TextStyle(color: AppColors.white, fontSize: 10),),),
                // )
              ],

            ),
            //VerticalSpacing(10),

          ],
        ),
      ),
    );
  }
}