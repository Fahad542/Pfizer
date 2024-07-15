import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pfizer/generated/assets.dart';
import 'package:pfizer/src/styles/app_colors.dart';
import 'package:pfizer/src/styles/text_theme.dart';

import '../base/utils/Constants.dart';
import '../models/api_resonse/tagging_modal.dart';
import '../services/remote/api_service.dart';
import '../services/remote/base/api_view_model.dart';
import '../views/dashboard/dashboard_view_model.dart';

class DashboardItemCard extends StatefulWidget {
  final String title;
  final String icon;
  final bool isActive;
  final Function onTap;
 DashboardItemCard({Key? key, required this.title, required this.icon, required this.isActive, required this.onTap}) : super(key: key);

  @override
  State<DashboardItemCard> createState() => _DashboardItemCardState();
}

class _DashboardItemCardState extends State<DashboardItemCard> {
  final DashboardViewModel dashboardViewModel = DashboardViewModel();

  List<Tagging> tagging = [];


  @override
  Widget build(BuildContext context) {
   // ApiViewModel apiViewModel = ApiViewModel();
    return InkWell (
      onTap: () {


         widget.onTap();


          //await Future.delayed(Duration(milliseconds: 100));



      },

      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: (widget.isActive) ? AppColors.primaryBoxShadow : [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.1),
              blurRadius: 1,
              offset: Offset(0, 0)
            )
          ],
          color: AppColors.white,
        ),
        padding: EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Spacer(),
            CachedNetworkImage(
              height: 24, width: 24,
              fit: BoxFit.contain,
              color: AppColors.primary,
              imageUrl: widget.icon,
              placeholder: (context, url) => Center(
                  child: Image.asset(Assets.imagesNoResultsFound)),
              errorWidget: (context, url, error) =>
                  Center(child: Icon(Icons.error)),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              height: 25,
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10), ),
                color: AppColors.primary,
              ),
              child: Center(
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyling.smallBold.copyWith(color: AppColors.white,fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
