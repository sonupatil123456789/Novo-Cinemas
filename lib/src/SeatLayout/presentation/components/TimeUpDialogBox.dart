import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/SeatLayout/presentation/bloc/SeatLayoutBloc.dart';
import 'package:novocinema/src/SeatLayout/presentation/bloc/SeatLayoutBloc.dart';

import '../../../../components/CustomButton.dart';
import '../../../../core/constants/RoutesName.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/utils/ListnerUtils.dart';
import '../../../../core/utils/SessionTimer.dart';
import '../../../Offers/presentation/bloc/OffersBloc.dart';


class TimeUpDialogBox extends StatelessWidget {
  String reservationId;
  final SessionTimer countdownTimer;

  TimeUpDialogBox(
      {super.key, required this.reservationId, required this.countdownTimer});

  @override
  Widget build(BuildContext context) {
    return Dialog(

      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async{
          if (didPop) return;
          await navigateToSeatScreen(context);
        },
        child: Container(
            width: context.getScreenWidth(80),
            height: context.getScreenHeight(25),
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
            decoration: BoxDecoration(
                color: context.colorPalette.backGroundColor,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Time up !",
                  overflow: TextOverflow.ellipsis,
                  style: context.textThemeDecoration.titleSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Please extend the timer if you still want to book the seat or else cancel the rservation by cancelling your seats will be remove from hold",
                  style: context.textThemeDecoration.paragraphLarge,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      height: context.getScreenHeight(5),
                      backgroundColor: context.colorPalette.transparentColor,
                      text: 'Cancel',
                      textColor: context.colorPalette.accentColor,
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      borderColor: Border.all(
                          color: context.colorPalette.accentColor, width: 2.0),
                      width: context.getScreenWidth(20),
                    ),
                    const SizedBox(width: 20,),
                    BlocBuilder<SeatLayoutBloc, SeatLayoutState>(
                      builder: (context, seatState) {

                        var isLoading = seatState.extendTimerState == CurrentAppState.LOADING? true: false;


                        return CustomButton(
                          isDisabled: isLoading,
                          height: context.getScreenHeight(5),
                          backgroundColor: context.colorPalette.accentColor,
                          text: 'Extend Time',
                          textColor: context.colorPalette.darkGreyColor,
                          onTap: () {
                            context.read<SeatLayoutBloc>().add(ExtendSeatBookingTimerEvent(reservationId: reservationId,
                                onFailure: (AppException error ) {
                                  ListnersUtils.showErrorMessage('Fail to extend timer', 'Timer Error', context);
                                }, onSuccess: (String reservationId) {
                                  countdownTimer.extendTime(SEASSION_TIMER_DURATION);
                                  Navigator.pop(context);
                                }));
                          },
                          width: context.getScreenWidth(30),
                        );
                      },
                    ),
                    const SizedBox(width: 20,),
                  ],
                )
              ],
            )
        ),
      ),
    );
  }

  navigateToSeatScreen(BuildContext context ){
    context.read<OffersBloc>().add(CancelBookedSelectedSeatsEvent(
          (p0) {
            // Navigator.pop(context);
        countdownTimer.stopTimer();
        Navigator.popUntil(context,(route) => route.settings.name==RoutesName.seatLayoutScreen,);
      },
    ));
  }
}
