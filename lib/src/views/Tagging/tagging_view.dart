import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:pfizer/generated/assets.dart';
import 'package:pfizer/src/base/utils/utils.dart';
import 'package:pfizer/src/configs/app_setup.router.dart';
import 'package:pfizer/src/models/api_resonse/my_shedule.dart';
import 'package:pfizer/src/models/api_resonse/tagging_modal.dart';
import 'package:pfizer/src/services/local/navigation_service.dart';
import 'package:pfizer/src/shared/input_field.dart';
import 'package:pfizer/src/shared/spacing.dart';
import 'package:pfizer/src/shared/top_app_bar.dart';
import 'package:pfizer/src/styles/app_colors.dart';
import 'package:pfizer/src/styles/text_theme.dart';
import 'package:pfizer/src/views/Tagging/geotagupdate.dart';
import 'package:stacked/stacked.dart';

import 'tagging_view_model.dart';

class TaggingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaggingViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: GeneralAppBar(
              title: "Geo Tagging",
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
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                          child: TextField(
                            onChanged: (value) {
                              //Tagging data = model.tagging as Tagging;
                              model.search.text = value;
                              //data.hospitalName.contains(value);
                              model.updateSearchResults();
                            },
                            style: TextStyle(fontSize: 16.0), // Adjust font size as needed
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              hintText: 'Enter Hospital Name',
                              hintStyle: TextStyle(color: Colors.grey),
                              suffixIcon: Icon(Icons.search, color: Colors.blue),
                              contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                            ),
                          )


                        ),


                        (model.search.text.isNotEmpty)

                            ?
                        ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: model.searchResults.length,
                                itemBuilder: (context, index) {
                                  Tagging data = model.searchResults[index];
                                  return MyScheduleCard(

                                    data: data,

                                  );
                                },

                              )

                            :model.search.text.isEmpty ?ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: model.tagging.length,
                          itemBuilder: (context, index) {
                            Tagging data = model.tagging[index];

                            return MyScheduleCard(
                              data: data,
                            );
                          },
                        ):



                        Column(
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
      viewModelBuilder: () => TaggingViewModel(context),
      onModelReady: (model) => model.init(),
    );
  }
}

class MyScheduleCard extends StatelessWidget {
  final Tagging data;



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
                    text: data.hospitalAddress,
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
                  onTap: () async {
                    Position position = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GeoTAgUpdate(
                                index: data.index,
                                address: '${data.hospitalAddress}',
                                custlat: '${position.latitude}',
                                custlong: '${position.longitude}',
                                Hospitalname: '${data.hospitalName}',
                                hospitalid: '${data.hospitalId.toString()}',

                              )

                      ),
                    );
                    print(data.index);
                    print(data);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.green,
                    ),
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Text(
                      "Geo Tag",
                      style: TextStyling.mediumBold
                          .copyWith(color: AppColors.white),
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
