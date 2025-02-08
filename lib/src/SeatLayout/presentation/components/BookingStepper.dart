import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novocinema/core/theams/Utils.dart';

import '../../../../core/constants/ImageConstants.dart';


class BookingStepper extends StatefulWidget {
  final BookingFlowSteps initialStep;
  final Function(BookingFlowSteps) onStepChanged;

  const BookingStepper({
    super.key,
    this.initialStep = BookingFlowSteps.SEAT_SELECTION,
    required this.onStepChanged,
  });

  @override
  State<BookingStepper> createState() => _BookingStepperState();
}

enum BookingFlowSteps {
  SEAT_SELECTION(0, 'Seat', ImageConstants.stepperSeatSelection),
  OFFERS(1, 'Offers', ImageConstants.steppeOffers),
  FANDB(2, 'F&B', ImageConstants.stepperFAB),
  PAYMENT(3, 'Payment', ImageConstants.stepperPayment);

  final int id;
  final String title;
  final String icon;

  const BookingFlowSteps(this.id, this.title, this.icon);
}



class _BookingStepperState extends State<BookingStepper> {
  late BookingFlowSteps activeStep;

  // final seatStepperKey = GlobalKey<_BookingStepperState>();
  // final offersStepperKey = GlobalKey<_BookingStepperState>();

  @override
  void initState() {
    super.initState();
    activeStep = widget.initialStep;
  }

  void setActiveStep(BookingFlowSteps newStep) {
    if (newStep.id <= BookingFlowSteps.PAYMENT.id) {
      setState(() {
        activeStep = newStep;
      });
      widget.onStepChanged(newStep);
    }
  }

  void goToNextStep() {
    final nextStepIndex = activeStep.id + 1;
    if (nextStepIndex <= BookingFlowSteps.PAYMENT.id) {
      setActiveStep(BookingFlowSteps.values[nextStepIndex]);
    }
  }

  void goToPreviousStep() {
    final previousStepIndex = activeStep.id - 1;
    if (previousStepIndex >= 0) {
      setActiveStep(BookingFlowSteps.values[previousStepIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: context.getScreenHeight(8),
      child: EasyStepper(
        activeStep: activeStep.id,
        showStepBorder: false,
        stepShape: StepShape.circle,
        activeStepBorderType: BorderType.normal,
        defaultStepBorderType: BorderType.normal,
        unreachedStepBorderType: BorderType.normal,
        dashPattern: const [8, 5],
        lineStyle: LineStyle(
          lineSpace: 4,
          lineType: LineType.dashed,
          defaultLineColor: context.colorPalette.disabledColor,
          finishedLineColor: context.colorPalette.accentColor,
          lineThickness: 1,
          lineLength: context.getScreenWidth(10),
        ),
        borderThickness: 2,
        stepRadius: context.getScreenWidth(3.6),
        activeStepTextColor: context.colorPalette.accentColor,
        activeStepBorderColor: context.colorPalette.accentColor,
        finishedStepBorderColor: context.colorPalette.accentColor,
        finishedStepTextColor: context.colorPalette.accentColor,
        finishedStepBackgroundColor: context.colorPalette.accentColor,
        unreachedStepBorderColor: context.colorPalette.accentColor,
        enableStepTapping: false,
        showLoadingAnimation: false,
        steps: List.generate(BookingFlowSteps.values.length, (index) {
          BookingFlowSteps data = BookingFlowSteps.values[index];
          return EasyStep(
            customStep: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: activeStep.id > index
                  ? Icon(
                Icons.check,
                color: context.colorPalette.darkGreyColor,
                size: context.getScreenWidth(3),
              )
                  : Opacity(
                opacity: activeStep.id >= index ? 1 : 0.3,
                child: SvgPicture.asset(
                  data.icon,
                  width: context.getScreenWidth(7),
                  height: context.getScreenWidth(7),
                ),
              ),
            ),
            customTitle: Text(
              data.title,
              textAlign: TextAlign.center,
              style: context.textThemeDecoration.paragraphMedium.copyWith(
                color: activeStep.id >= index
                    ? context.isDarkMode ? context.colorPalette.accentColor : context.colorPalette.textColor
                    : context.colorPalette.disabledColor,
              ),
            ),
          );
        }),
        onStepReached: (index) {
          // Optionally handle step tapping here if enableStepTapping is true
        },
      ),
    );
  }
}

// class BookingStepper extends StatefulWidget {
//   const BookingStepper({
//     super.key,
//     required active
//   });
//
//   @override
//   State<BookingStepper> createState() => _BookingStepperState();
// }
//
// enum BookingFlowSteps {
//   SEAT_SELECTION(0, 'Seat', ImageConstants.stepperSeatSelection),
//   OFFERS(1, 'Offers', ImageConstants.steppeOffers),
//   FANDB(2, 'F&B', ImageConstants.stepperFAB),
//   PAYNENT(3, 'Payment', ImageConstants.stepperPayment);
//
//     final int Id;
//   final String title;
//   final String icon;
//   const BookingFlowSteps(this.Id, this.title, this.icon);
// }
//
// class _BookingStepperState extends State<BookingStepper> {
//
//
//    setActiveSteps(BookingFlowSteps setActiveStep){
//      setState(() {
//
//        activeStep = setActiveStep;
//
//      });
//   }
//
//
//
//    BookingFlowSteps activeStep = BookingFlowSteps.SEAT_SELECTION;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       height: context.getScreenHeight(8),
//       child: EasyStepper(
//         activeStep: activeStep.Id,
//         showStepBorder: false,
//         stepShape: StepShape.circle, //
//         activeStepBorderType: BorderType.normal,
//         defaultStepBorderType: BorderType.normal,
//         unreachedStepBorderType :BorderType.normal,
//
//         dashPattern: const  [8, 5],
//
//         // Line Style Configuration
//         lineStyle: LineStyle(
//           lineSpace: 4, // Space between dashes
//           lineType: LineType.dashed, // or LineType.normal for solid line
//           defaultLineColor: context.colorPalette.disabledColor, // Color for incomplete steps
//           finishedLineColor: context.colorPalette.accentColor, // Color for completed steps
//           lineThickness: 1, // Thickness of the line
//           lineLength: context.getScreenWidth(10), // Length of each dash
//         ),
//
//         borderThickness: 2,
//         stepRadius: context.getScreenWidth(3.6),
//         activeStepTextColor: context.colorPalette.accentColor,
//         activeStepBorderColor: context.colorPalette.accentColor,
//         finishedStepBorderColor: context.colorPalette.accentColor,
//         finishedStepTextColor: context.colorPalette.accentColor,
//         finishedStepBackgroundColor: context.colorPalette.accentColor,
//         unreachedStepBorderColor: context.colorPalette.accentColor,
//         enableStepTapping: false,
//         showLoadingAnimation: false,
//         steps: List.generate(BookingFlowSteps.values.length, (index) {
//           BookingFlowSteps data = BookingFlowSteps.values[index];
//           return EasyStep(
//             customStep: ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: activeStep.Id > index
//                   ? Icon(
//                       Icons.check,
//                       color: context.colorPalette.darkGreyColor,
//                       size: context.getScreenWidth(3),
//                     )
//                   : Opacity(
//                       opacity: activeStep.Id >= index ? 1 : 0.3,
//                       child: SvgPicture.asset(
//                         data.icon,
//                         width: context.getScreenWidth(7),
//                         height: context.getScreenWidth(7),
//                       ),
//                     ),
//             ),
//             customTitle: Text(
//               data.title,
//               textAlign: TextAlign.center,
//               style: context.textThemeDecoration.paragraphMedium.copyWith(
//                   color: activeStep.Id >= index
//                       ? context.colorPalette.accentColor
//                       : context.colorPalette.disabledColor
//                   // context.colorPalette.disabledColor,
//                   ),
//             ),
//           );
//         }),
//         onStepReached: (index) {
//           // setState(() => activeStep.Id = index);
//         },
//       ),
//     );
//   }
// }

// List<StepperData> stepperDataList = [
//   StepperData(0, 'Seat', ImageConstants.stepperSeatSelection),
//   StepperData(1, 'Offers', ImageConstants.steppeOffers),
//   StepperData(2, 'F&B', ImageConstants.stepperFAB),
//   StepperData(3, 'Payment', ImageConstants.stepperPayment),
// ];
//
// class StepperData {
//   int Id;
//   String title;
//   String icon;
//   StepperData(this.Id, this.title, this.icon);
// }


// EasyStep(
// customStep: ClipRRect(
// borderRadius: BorderRadius.circular(15),
// child: Opacity(
// opacity: activeStep >= 1 ? 1 : 0.3,
// child: SvgPicture.asset(ImageConstants.steppeOffers),
// ),
// ),
// customTitle: const Text(
// 'Offers',
// textAlign: TextAlign.center,
// ),
// ),