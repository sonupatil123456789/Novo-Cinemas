import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novocinema/core/theams/Utils.dart';

enum ButtonType { ICON_BUTTON, TEXT_BUTTON }

class CustomButton extends StatelessWidget {
  double height;
  double width;
  Border? borderColor;
  Color? backgroundColor;
  Color? disabledBackgroundColor;
  String text;
  Color? textColor;
  Function onTap;
  double? borderRadius;
  ButtonType? type;
  String? icon;
  double? iconSpacing;
  double? iconSize;
  bool? isDisabled;
  FontWeight? fontWeight;
  FontStyle? fontStyle;
  TextStyle? textStyle;
  LinearGradient? gradient;
  Color? iconColor;

  CustomButton(
      {super.key,
      this.borderColor,
      this.textColor,
      this.backgroundColor,
      this.isDisabled = false,
      required this.text,
      required this.onTap,
      required this.width,
      required this.height,
      this.borderRadius,
      this.disabledBackgroundColor,
      this.icon,
      this.iconSize,
      this.iconSpacing,
      this.fontWeight,
      this.fontStyle,
      this.textStyle,
      this.type = ButtonType.TEXT_BUTTON,
      this.gradient,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    final appliedFontWeight = fontWeight ?? FontWeight.normal;
    if (type == ButtonType.ICON_BUTTON) {
      return IgnorePointer(
        ignoring: isDisabled != null && isDisabled == false ? false : true,
        child: InkWell(
          onTap: () {
            onTap();
          },
          child: Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: gradient,
                color: isDisabled != null && isDisabled == false
                    ? (backgroundColor ?? context.colorPalette.accentColor)
                    : (disabledBackgroundColor ??
                        context.colorPalette.disabledButtonColor),
                shape: BoxShape.rectangle,
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius ?? 12)),
                border: borderColor ??
                    Border.all(
                      color: isDisabled != null && isDisabled == false
                          ? (backgroundColor ??
                              context.colorPalette.accentColor)
                          : (disabledBackgroundColor ??
                              context.colorPalette.disabledButtonColor),
                    )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  icon!,
                  width: iconSize,
                  height: iconSize,
                  color: iconColor,
                ),
                SizedBox(
                  width: iconSpacing,
                ),
                Text(
                  text,
                  style: textStyle ??
                      context.textThemeDecoration.titleSmall.copyWith(
                        color: textColor,
                        fontSize: 10,
                        fontWeight: appliedFontWeight,
                      ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return IgnorePointer(
      ignoring: isDisabled != null && isDisabled == false ? false : true,
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: isDisabled != null && isDisabled == false
                  ? (backgroundColor ?? context.colorPalette.accentColor)
                  : (disabledBackgroundColor ??
                      context.colorPalette.disabledButtonColor),
              shape: BoxShape.rectangle,
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 12)),
              border: borderColor ??
                  Border.all(
                    color: isDisabled != null && isDisabled == false
                        ? (backgroundColor ?? context.colorPalette.accentColor)
                        : (disabledBackgroundColor ??
                            context.colorPalette.disabledButtonColor),
                  )),
          child: Text(
            text,
            style: context.textThemeDecoration.titleSmall
                .copyWith(color: textColor, fontSize: 10),
          ),
        ),
      ),
    );
  }
}
