import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pfizer/src/base/utils/utils.dart';
import 'package:pfizer/src/styles/app_colors.dart';
import 'package:pfizer/src/styles/text_theme.dart';

class MainButton extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;
  final Widget? icon;
  final Color? color;
  final Function onTap;
  final bool isBusy;
  final EdgeInsetsGeometry? margin;

  const MainButton(
      {Key? key,
        required this.text,
        this.width,
        this.height,
        this.icon,
        required this.onTap,
        this.margin, this.color, this.isBusy = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(isBusy == false)
          onTap();
      },
      child: Container(
        width: width ?? context.screenSize().width,
        height: height ?? 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: color ?? AppColors.primary,
        ),
        padding: EdgeInsets.all(10),
        margin: margin,
        child: (isBusy) ? Center(child: CircularProgressIndicator(color: AppColors.white,)) : Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyling.largeBold.copyWith(color: AppColors.white),
            ),
            if (icon != null) SizedBox(width: 8),
            if (icon != null) icon ?? SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  final Icon icon;
  final Function onTap;

  const RoundIconButton({Key? key, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppColors.primaryBoxShadow,
        ),
        width: 48,
        height: 48,
        child: Center(
            child: icon),
      ),
    );
  }
}