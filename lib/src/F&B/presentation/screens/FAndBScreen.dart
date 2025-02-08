
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/constants/RoutesName.dart';
import 'package:novocinema/core/resources/AppException.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/F&B/presentation/bloc/F&BBloc.dart';
import 'package:novocinema/src/F&B/presentation/components/F&BCartPopup.dart';
import 'package:novocinema/src/F&B/presentation/components/F&BItems.dart';
import 'package:novocinema/src/Offers/presentation/screens/OffersScreen.dart';
import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/CustomButton.dart';
import '../../../../core/utils/ListnerUtils.dart';
import '../../../../core/utils/SessionTimer.dart';
import '../../../OrderConfirmation/presentation/bloc/OrderConfirmationBloc.dart';
import '../../../SeatLayout/presentation/components/BookingStepper.dart';

enum FAndBType {
  BOOKING_FLOW_FANDB,
  DIRECT_FANDB,
  TAKEAWAY_FNB,
  QR_FNB,
  STAR_FNB
}

class FAndBScreen extends StatefulWidget {
  final String reservationId;
  final String sessionId;
  final String cinemaId;
  final String postConcessionUrl;
  final FAndBType fAndBType;

  FAndBScreen({
    super.key,
    required this.reservationId,
    required this.sessionId,
    required this.cinemaId,
    required this.fAndBType,
    required this.postConcessionUrl,
  });

  @override
  State<FAndBScreen> createState() => _FAndBScreenState();
}

class _FAndBScreenState extends State<FAndBScreen> {
  final BorderRadius borderRadius = BorderRadius.circular(12);
  late final SessionTimer _countdownTimer;

  @override
  void initState() {
    _countdownTimer = SessionTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ArtBoard(
      header: BackButtonNavBar(
          center: Container(
            height: double.infinity,
            child: Row(
              children: [
                StreamBuilder<Map<String, dynamic>>(
                  stream: _countdownTimer.countdownStream,
                  builder: (context, snapshot) {
                    final time = snapshot.data;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        clockContainer(context, "${time?['minutes']} Min"),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.getScreenWidth(3)),
                          child: Text(
                            " : ",
                            style: context.textThemeDecoration.paragraphLarge
                                .copyWith(color: context.colorPalette.accentColor),
                          ),
                        ),
                        clockContainer(context, "${time?['seconds']} Sec"),
                      ],
                    );
                  },
                ),

                const Spacer(),
              ],
            ),
          ),
          onBackPress: () {
           navigateBack();
      }),
      body: PopScope(
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          navigateBack();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: context.getScreenHeight(2),
              ),
              BlocBuilder<OrderConfirmationBloc,OrderConfirmationState>(
                builder: (BuildContext context,  orderConfirmationState) {
                  return BookingStepper(
                      initialStep:orderConfirmationState.bookingFlowSteps ,
                      onStepChanged: (BookingFlowSteps data) {
                        print(data.toString());
                      });
                },),
              Container(
                  height: context.getScreenHeight(8),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: context.getScreenHeight(1.6)),
                      Text(
                        "Food & Beverage",
                        overflow: TextOverflow.ellipsis,
                        style: context.textThemeDecoration.titleLarge,
                      ),
                      Text(
                        "Prebook your meal & save more",
                        overflow: TextOverflow.ellipsis,
                        style: context.textThemeDecoration.paragraphLarge,
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),

              Expanded(child: FnBItems(cinemaId: widget.cinemaId))
            ],
          ),
        ),
      ),
      footerHeight: context.getScreenHeight(10),
      footer: BlocBuilder<FAndBBloc, FAndBState>(
        builder: (context, fAndBState) {
          var isLoading =
              fAndBState.fnbConfirmationState == CurrentAppState.LOADING
                  ? true
                  : false;

          return Container(
            width: context.getScreenWidth(100),
            height: context.getScreenHeight(8),
            decoration: BoxDecoration(
                color: context.colorPalette.backGroundColor,
                borderRadius:
                const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                border: Border(
                    top: BorderSide(color: context.colorPalette.accentColor)
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (fAndBState.addConcessionItemList.isEmpty &&widget.fAndBType == FAndBType.BOOKING_FLOW_FANDB) ...[

                  CustomButton(
                    height: context.getScreenHeight(6),
                    backgroundColor: context.colorPalette.accentColor.withOpacity(0.15),
                    text: 'Skip F&B',
                    textColor: context.colorPalette.accentColor,
                    onTap: () {

                      skipConcessionOrder(
                      reservationId: widget.reservationId,
                      sessionId: widget.sessionId,
                      cinemaId: widget.cinemaId,
                      postConcessionUrl: widget.postConcessionUrl,
                      fAndBType: widget.fAndBType,
                      fAndBState: fAndBState);

                    },
                    borderColor: Border.all(color: context.colorPalette.accentColor.withOpacity(0.6),width: 2.0),
                    disabledBackgroundColor:context.colorPalette.accentColor.withOpacity(0.15),
                    width: context.getScreenWidth(40),),
                ] else ...[
                  CustomButton(
                    height: context.getScreenHeight(6),
                    backgroundColor: context.colorPalette.accentColor.withOpacity(0.15),
                    text:'View Cart ( ${fAndBState.addConcessionItemList.length.toString() ?? '0'} )',
                    textColor: context.colorPalette.accentColor,
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return const FnBCartPopup();
                        },
                      );
                    },
                    borderColor: Border.all(color: context.colorPalette.accentColor.withOpacity(0.6),width: 2.0),
                    disabledBackgroundColor:context.colorPalette.accentColor.withOpacity(0.15),
                    width: context.getScreenWidth(40),
                  ),
                ],
                CustomButton(
                  height: context.getScreenHeight(6),
                  backgroundColor: context.colorPalette.accentColor,
                  text: isLoading ? 'Loading...' : 'Continue',
                  textColor: context.colorPalette.darkGreyColor,
                  onTap: () async {
                    completeConcessionOrder(
                        reservationId: widget.reservationId,
                        sessionId: widget.sessionId,
                        cinemaId: widget.cinemaId,
                        postConcessionUrl: widget.postConcessionUrl,
                        fAndBType: widget.fAndBType,
                        fAndBState: fAndBState);
                  },
                  width: context.getScreenWidth(40),
                  isDisabled:
                      isLoading || fAndBState.addConcessionItemList.isEmpty
                          ? true
                          : false,
                ),
              ],
            ),
          );
        },
      ),
    );
  }


  void navigateBack(){
    context.read<FAndBBloc>().add(const ClearFAndBStateEvent());
    context.read<OrderConfirmationBloc>().add(const SetBookingStepperEvent(step: BookingFlowSteps.OFFERS));
    Navigator.pop(context);
  }



  void skipConcessionOrder(
      {required String reservationId,
        required String sessionId,
        required String cinemaId,
        required String postConcessionUrl,
        required FAndBType fAndBType,
        required FAndBState fAndBState}) {

    switch(fAndBType) {
      case FAndBType.BOOKING_FLOW_FANDB:
        context.read<OrderConfirmationBloc>().add(const SetBookingStepperEvent(step: BookingFlowSteps.PAYMENT));
        Navigator.pushNamed(
            context, RoutesName.orderConfirmationScreen,
            arguments: {
              'reservationId': widget.reservationId,
              'navigateToScreen': RoutesName.fAndBScreen,
            });
      case FAndBType.DIRECT_FANDB:
        Navigator.pushNamed(context, RoutesName.directFnBSummaryScreen,
            arguments: {
              'reservationId': fAndBState.fnbConfirmationDetails['reservationId'] as String,
              'fAndBType': widget.fAndBType,
            });
      case FAndBType.TAKEAWAY_FNB:
        Navigator.pushNamed(context, RoutesName.directFnBSummaryScreen,
            arguments: {
              'reservationId': fAndBState.fnbConfirmationDetails['reservationId'] as String,
              'fAndBType': widget.fAndBType,
            });
      case FAndBType.QR_FNB:
        // TODO: Handle this case.
        throw UnimplementedError();
      case FAndBType.STAR_FNB:
        // TODO: Handle this case.
        throw UnimplementedError();
    }



  }

  void completeConcessionOrder(
      {required String reservationId,
      required String sessionId,
      required String cinemaId,
      required String postConcessionUrl,
      required FAndBType fAndBType,
      required FAndBState fAndBState}) {
    switch (fAndBType) {
      case FAndBType.BOOKING_FLOW_FANDB:
        context.read<FAndBBloc>().add(CompleteFAndBEvent(
            onFailure: (AppException error) {
              ListnersUtils.showErrorMessage(
                  error.message, 'Order Error', context);
            },
            onSuccess: (data) {
              context.read<OrderConfirmationBloc>().add(const SetBookingStepperEvent(step: BookingFlowSteps.PAYMENT));
              Navigator.pushNamed(context, RoutesName.orderConfirmationScreen,
                  arguments: {
                    'reservationId': widget.reservationId,
                    'navigateToScreen': RoutesName.fAndBScreen,
                  });
            },
            data: <String, dynamic>{
              "reservationId": widget.reservationId,
              "cinemaId": widget.cinemaId,
              "sessionId": widget.sessionId,
              "Concessions": fAndBState.addConcessionItemList,
            },
            postConcessionUrl: widget.postConcessionUrl));
        break;
      case FAndBType.DIRECT_FANDB:
        context.read<FAndBBloc>().add(CompleteFAndBEvent(
            onFailure: (AppException error) {
              ListnersUtils.showErrorMessage(
                  error.message, 'Order Error', context);
            },
            onSuccess: (data) {
              Navigator.pushNamed(context, RoutesName.directFnBSummaryScreen,
                  arguments: {
                    'reservationId': data['reservationId'] as String,
                    'fAndBType': widget.fAndBType,
                  });
            },
            data: <String, dynamic>{
              "reservationId": widget.reservationId,
              "cinemaId": widget.cinemaId,
              "sessionId": widget.sessionId,
              "Concessions": fAndBState.addConcessionItemList,
            },
            postConcessionUrl: widget.postConcessionUrl));
        break;
      case FAndBType.TAKEAWAY_FNB:
        context.read<FAndBBloc>().add(CompleteFAndBEvent(
            onFailure: (AppException error) {
              ListnersUtils.showErrorMessage(
                  error.message, 'Order Error', context);
            },
            onSuccess: (data) {
              Navigator.pushNamed(context, RoutesName.directFnBSummaryScreen,
                  arguments: {
                    'reservationId': data['reservationId'] as String,
                    'fAndBType': widget.fAndBType,
                  });
            },
            data: <String, dynamic>{
              "reservationId": widget.reservationId,
              "cinemaId": widget.cinemaId,
              "sessionId": widget.sessionId,
              "Concessions": fAndBState.addConcessionItemList,
            },
            postConcessionUrl: widget.postConcessionUrl));
        break;
      case FAndBType.QR_FNB:
        // TODO: Handle this case.
        throw UnimplementedError();
      case FAndBType.STAR_FNB:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
