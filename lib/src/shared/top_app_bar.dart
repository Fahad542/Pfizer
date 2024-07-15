import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pfizer/generated/assets.dart';
import 'package:pfizer/src/base/utils/utils.dart';
import 'package:pfizer/src/shared/buttons.dart';
import 'package:pfizer/src/shared/spacing.dart';
import 'package:pfizer/src/styles/app_colors.dart';
import 'package:pfizer/src/styles/text_theme.dart';

class DashboardAppBar extends PreferredSize {
  final String name;
  final String image;
  final Function onSettingTap;

  DashboardAppBar({
    Key? key,
    required this.name,
    required this.image,
    required this.onSettingTap,
  }) : super(preferredSize: Size.fromHeight(100), child: SizedBox.shrink());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 20),
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            height: 64,
            width: 64,
            fit: BoxFit.contain,
            imageUrl: image,
            placeholder: (context, url) =>
                Center(child: Image.asset(Assets.imagesNoResultsFound)),
            errorWidget: (context, url, error) =>
                Center(child: Icon(Icons.error)),
          ),
          HorizontalSpacing(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome,",
                style:
                    TextStyling.mediumRegular.copyWith(color: AppColors.black),
              ),
              Text(
                name.toUpperCase(),
                style: TextStyling.largeBold.copyWith(color: AppColors.primary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Spacer(),
          RoundIconButton(
            icon: Icon(
              Icons.settings,
              color: AppColors.primary,
            ),
            onTap: () {
              onSettingTap();
            },
          ),
        ],
      ),
    );
  }
}

class GeneralAppBar extends PreferredSize {
  final String title;
  final Function onBackTap;

  GeneralAppBar({
    Key? key,
    required this.title,
    required this.onBackTap,
  }) : super(preferredSize: Size.fromHeight(100), child: SizedBox.shrink());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 20),
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RoundIconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primary,
            ),
            onTap: () {
              onBackTap();
            },
          ),
          Text(
            title,
            style: TextStyling.largeBold.copyWith(color: AppColors.primary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            width: 48,
            height: 48,
          )
        ],
      ),
    );
  }
}
