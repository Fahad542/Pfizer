import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pfizer/generated/assets.dart';
import 'package:pfizer/src/base/utils/utils.dart';
import 'package:pfizer/src/shared/dashboard_item_card.dart';
import 'package:pfizer/src/shared/spacing.dart';
import 'package:pfizer/src/shared/top_app_bar.dart';
import 'package:pfizer/src/styles/app_colors.dart';
import 'package:pfizer/src/styles/text_theme.dart';
import 'package:stacked/stacked.dart';

import 'dashboard_view_model.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: DashboardAppBar(
            name: model.authService.user?.userData?.userName.toString() ?? "USERNAME",
            image: "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
            onSettingTap: () {
              model.onSetting(context);
            },
          ),
          body: (model.isBusy)
              ? Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ))
              : Column(
                children: [
                  SizedBox(
                    height: context.screenSize().height - 250,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          VerticalSpacing(10),
                          CachedNetworkImage(
                            height: 150,
                            fit: BoxFit.contain,
                            imageUrl: "https://connect-assets.prosple.com/cdn/ff/XjSrT9sezP7R7n8yb05_290_nU6LFj2Q2y7atki4H-A/1628137208/public/2021-08/Banner-Pfizer-890x320-2021.jpg",
                            placeholder: (context, url) => Center(
                                child: Image.asset(Assets.imagesNoResultsFound)),
                            errorWidget: (context, url, error) =>
                                Center(child: Icon(Icons.error)),
                          ),
                          VerticalSpacing(10),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                            padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: AppColors.secondary),
                            child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: model.activeItems.length,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.8),
                              itemBuilder: (BuildContext context, int index) {
                                return DashboardItemCard(
                                  title: model.activeItems[index].name,
                                  icon: model.activeItems[index].icon, isActive: true, onTap: (){
                                  model.getNavigatorByItem(model.activeItems[index].name);
                                },
                                );
                              },
                            ),
                          ),
                          Text(
                            "Upcoming",
                            style: TextStyling.extraLargeBold.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(50, 10, 50, 20),
                            child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: model.unActiveItems.length,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.8),
                              itemBuilder: (BuildContext context, int index) {
                                return DashboardItemCard(
                                  title: model.unActiveItems[index].name,
                                  icon: model.unActiveItems[index].icon, isActive: false, onTap: (){


                                },
                                );


                              },
                            ),


                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Stack(
                    children: [
                      Image.asset(Assets.imagesDashboardBackground,),
                      Positioned(
                        bottom: 20,
                        left: (context.screenSize().width - 140) / 2,
                        right: (context.screenSize().width - 140) / 2,
                        child: Badge(
                          backgroundColor: AppColors.white,
                          textColor: AppColors.primary,
                          textStyle: TextStyling.smallBold,
                          label: Text("${model.db.countCalls.value.toString()}"),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            onTap: (){
                              model.onSync(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.secondary.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.white)
                              ),
                              width: 200,
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "SYNC",
                                    style: TextStyling.largeBold
                                        .copyWith(color: AppColors.white, ),
                                  ),
                                  Icon(Icons.refresh_sharp, color: AppColors.white, size: 30,)
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
        ),
      ),
      viewModelBuilder: () => DashboardViewModel(),
      onModelReady: (model) => model.init(context),
    );
  }
}
