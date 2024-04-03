import 'package:flutter/material.dart';
import 'package:storyapp/constants/app_colors.dart';
import 'package:storyapp/data/enums.dart';
import 'package:storyapp/widgets/text_view.dart';

class AppRaisedButton extends StatelessWidget {
  String? title;
  Widget? child;
  Color? color;
  Color? borderColor;
  double? height;
  double? width;
  BoxConstraints? constraints;
  double borderRadius;
  Color titleColor;
  double titleSize;
  FontWeight? titleFontWeight;
  int titleMaxLines;
  TextAlign titleAlign;
  double elevation;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  VoidCallback? onPressed;
  bool isOutlineButton;
  TextOverflow? textOverflow;
  Color? shadowColor;
  double? borderWidth;
  ViewState viewState;

  AppRaisedButton({
    Key? key,
    this.title,
    this.child,
    this.color = AppColors.primaryColor,
    this.borderColor,
    this.height,
    this.width,
    this.constraints,
    this.borderRadius = 8,
    this.titleColor = Colors.white,
    this.titleSize = 16,
    this.titleFontWeight,
    this.titleMaxLines = 1,
    this.titleAlign = TextAlign.center,
    this.elevation = 1.0,
    this.padding,
    this.margin,
    this.onPressed,
    this.textOverflow,
    this.isOutlineButton = false,
    this.shadowColor,
    this.borderWidth = 3,
    this.viewState = ViewState.ideal,
  }) : super(key: key) {
    if (isOutlineButton) {
      elevation = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlineButton ? Colors.white : color,
          side: isOutlineButton
              ? BorderSide(
                  color: Colors.white,
                  width: isOutlineButton ? 2 : 0,
                )
              : null,
          textStyle: TextStyle(
            color: titleColor,
            fontSize: titleSize,
            fontWeight: titleFontWeight ?? FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: borderColor != null
                  ? BorderSide(color: borderColor!, width: borderWidth ?? 3)
                  : BorderSide.none),
          elevation: elevation,
          padding: padding,
          shadowColor: shadowColor,
        ),
        onPressed: viewState == ViewState.ideal ? onPressed : null,
        child: title != null
            ? TextView(
                title!,
                maxLines: titleMaxLines,
                textAlign: titleAlign,
                textColor: isOutlineButton ? Colors.black : titleColor,
                fontWeight: titleFontWeight ?? FontWeight.w600,
                fontSize: titleSize,
                textOverflow: textOverflow,
              )
            : child,
      ),
    );
  }
}
