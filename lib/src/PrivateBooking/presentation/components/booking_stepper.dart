import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novocinema/core/constants/ImageConstants.dart';
import 'package:novocinema/core/theams/Utils.dart';

class BookingStepperPrivate extends StatelessWidget {
  final int currentStep;

  const BookingStepperPrivate({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: EasyStepper(
        activeStep: currentStep,
        showStepBorder: false,
        borderThickness: 0,
        stepRadius: context.getScreenWidth(5),
        activeStepTextColor: context.colorPalette.accentColor,
        enableStepTapping: true,
        showLoadingAnimation: false,
        steps: List.generate(stepperPrivateDataList.length, (index) {
          StepperData data = stepperPrivateDataList[index];
          return EasyStep(
            customStep: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: currentStep > index
                  ? Icon(
                      Icons.check,
                      color: context.colorPalette.darkGreyColor,
                    )
                  : Opacity(
                      opacity: currentStep >= index ? 1 : 0.3,
                      child: SvgPicture.asset(
                        data.icon,
                        width: context.getScreenWidth(8.4),
                        height: context.getScreenWidth(9),
                      ),
                    ),
            ),
            customTitle: Text(
              data.title,
              textAlign: TextAlign.center,
              style: context.textThemeDecoration.paragraphMedium.copyWith(
                color: currentStep >= index
                    ? context.colorPalette.accentColor
                    : context.colorPalette.accentColor,
              ),
            ),
          );
        }),
      ),
    );
  }
}

List<StepperData> stepperPrivateDataList = [
  StepperData(0, 'Movie Selection', ImageConstants.stepperFAB),
  StepperData(1, 'Time Selection', ImageConstants.stepperPayment),
  StepperData(2, 'F&B', ImageConstants.stepperFAB),
  StepperData(3, 'Payment', ImageConstants.stepperPayment),
];

class StepperData {
  int id;
  String title;
  String icon;
  StepperData(this.id, this.title, this.icon);
}
