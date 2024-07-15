import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:pfizer/src/base/utils/utils.dart';
import 'package:pfizer/src/shared/spacing.dart';
import 'package:pfizer/src/styles/app_colors.dart';
import 'package:pfizer/src/styles/text_theme.dart';

class MainInputField extends StatelessWidget {
  final bool isPassword;
  final String label, hint;
  final TextEditingController controller;
  final Function? onTap;
  final TextInputType? inputType;
  final ValueChanged<String>? onChanged;
  final bool isRequired;
  final bool? readOnly;
  final String error;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? width;
  final double? height;
  final BoxDecoration? decoration;

  const MainInputField(
      {Key? key,
        this.width,
        this.height,
        this.isPassword = false,
        required this.label,
        required this.hint,
        required this.controller,
        this.onTap,
        this.inputType,
        this.onChanged,
        this.isRequired = true,
        this.suffixIcon,
        this.prefixIcon,
        required this.error,
        this.readOnly, this.decoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != "")
          Text(
            label,
            style: TextStyling.smallBold,
          ),
        VerticalSpacing(),
        Container(
          width: width ?? context.screenSize().width,
          height: height ?? 50,
          decoration: decoration ?? BoxDecoration(
            border: Border.all(color: (controller.text.length > 0) ? AppColors.secondary : AppColors.primary),
            color: AppColors.secondary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5)
          ),
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Row(
            children: [
              prefixIcon ?? SizedBox.shrink(),
              Expanded(
                child: Center(
                  child: TextFormField(
                    onTap: () {
                      onTap!();
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: inputType ?? TextInputType.text,
                    validator: (val) {
                      bool emailValid = true;
                      if (inputType == TextInputType.emailAddress) {
                        emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(controller.text);
                      }
                      return isRequired
                          ? (val!.isEmpty || (emailValid == false))
                          ? error
                          : null
                          : null;
                    },
                    onChanged: (val) {
                      onChanged!(val);
                    },
                    controller: controller,
                    readOnly: readOnly ?? false,
                    obscureText: isPassword,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hint,
                      hintStyle: TextStyling.mediumRegular.copyWith(color: AppColors.grey),
                      hintMaxLines: 1,
                      labelStyle: TextStyling.mediumRegular,
                      contentPadding:
                      const EdgeInsetsDirectional.fromSTEB(20, 0, 24, 0),
                    ),
                    cursorColor: AppColors.primary,
                    cursorHeight: 20,
                    style: TextStyling.mediumRegular.copyWith(color: AppColors.primary),
                  ),
                ),
              ),
              suffixIcon ?? SizedBox.shrink()
            ],
          ),
        ),
      ],
    );
  }
}

class CustomDropDown extends StatelessWidget {
  final String? label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final DropdownSearchPopupItemEnabled<String>? disabledItemFn;
  final double? width;
  final double? height;


  CustomDropDown(
      {Key? key,
        this.label,
        required this.value,
        required this.items,
        required this.onChanged,
        this.disabledItemFn,
        this.width,
        this.height})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label ?? "",
            style: TextStyling.smallBold,
          ),
        VerticalSpacing(),
        Container(
          width: width ?? context.screenSize().width,
          height: height ?? 50,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.secondary,),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.fromLTRB(10, 0, 10, 2),
          child: DropdownSearch<String>(
            popupProps: PopupProps.menu(
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary), borderRadius: BorderRadius.circular(5)),
                  disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.lightGrey), borderRadius: BorderRadius.circular(5)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.lightGrey), borderRadius: BorderRadius.circular(5)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary), borderRadius: BorderRadius.circular(5)),
                  focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.red), borderRadius: BorderRadius.circular(5)),
                  errorBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.red), borderRadius: BorderRadius.circular(5)),
                  hintText: "search",
                  hintStyle: TextStyling.mediumRegular.copyWith(color: AppColors.lightGrey)
                )
              ),
              fit: FlexFit.loose,
              showSelectedItems: true,
              showSearchBox: true,
              disabledItemFn: disabledItemFn
            ),
            items: items,
            dropdownBuilder: (context,value){
              if(value != null)
                return Text(value, style: TextStyling.mediumBold.copyWith(color: AppColors.primary),maxLines: 1,);
              else
                return Text("Select", style: TextStyling.mediumRegular.copyWith(color: AppColors.lightGrey),maxLines: 1,);
            },
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                hintText: "country in menu mode",
                hintStyle: TextStyling.mediumBold.copyWith(color: AppColors.darkGrey),
              ),
            ),
            onChanged: onChanged,
            selectedItem: value,
          ),
        ),
      ],
    );
  }
}