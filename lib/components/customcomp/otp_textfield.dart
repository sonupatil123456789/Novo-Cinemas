
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:pinput/pinput.dart';

class OtpTextField extends StatelessWidget {
  double height;
  double width;
  int? maxLength;
  Function(String) getOtpTextFieldValue;
  Function(String?) validateTextField;

  OtpTextField({
    super.key,
    required this.height,
    this.maxLength,
    required this.width,
    required this.getOtpTextFieldValue,
    required this.validateTextField,
  });





  @override
  Widget build(BuildContext context) {

    final defaultPinTheme = PinTheme(
      width: context.getScreenWidth(11),
      height: context.getScreenWidth(11),
      textStyle: context.textThemeDecoration.subTitleMedium,
      decoration: BoxDecoration(
        color: context.colorPalette.cardBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );


    return SizedBox(
      width: width,
      height: height,
      child: Pinput(
          length: maxLength ?? 4,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme:defaultPinTheme.copyDecorationWith(
            color: context.colorPalette.accentColor

          ),
          validator: (validate) {
            validateTextField(validate);
          },
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          showCursor: true,
          keyboardType: TextInputType.number,
          onCompleted: (pin) {
            getOtpTextFieldValue(pin);
          }),
    );
  }
}
