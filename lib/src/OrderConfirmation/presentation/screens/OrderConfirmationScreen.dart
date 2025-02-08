import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novocinema/core/constants/RoutesName.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/F&B/presentation/bloc/F&BBloc.dart';
import 'package:novocinema/src/Home/presentation/bloc/HomeBloc.dart';

import 'package:novocinema/src/OrderConfirmation/presentation/bloc/OrderConfirmationBloc.dart';
import 'package:novocinema/src/OrderConfirmation/presentation/components/LoyaltyPointsCard.dart';
import 'package:novocinema/src/SeatLayout/presentation/bloc/SeatLayoutBloc.dart';
import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/CustomButton.dart';
import '../../../../components/PaymentAndPromoCode.dart';
import '../../../../core/theams/TextTheamStyle.dart';
import '../../../../core/utils/CurrencyFormater.dart';
import '../../../MovieDetails/presentation/bloc/MovieDetailsBloc.dart';
import '../../../SeatLayout/presentation/components/BookingStepper.dart';
import '../components/MovieDetailsCard.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/utils/ListnerUtils.dart';
import '../../../../di.dart';
import '../../../Offers/presentation/bloc/OffersBloc.dart';
import '../../../../components/CustomTextField.dart';

class OrderConfirmationScreen extends StatefulWidget {
  final String reservationId;

  final String navigateToScreen;

  const OrderConfirmationScreen(
      {super.key, required this.reservationId, required this.navigateToScreen});

  @override
  State<OrderConfirmationScreen> createState() => _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  final BorderRadius borderRadius = BorderRadius.circular(12);
  late SeatLayoutBloc seatLayoutBloc;
  late MovieDetailsBloc movieDetailsBloc;
  late FAndBBloc fAndBBloc;
  late HomeBloc homeBloc;
  late OffersBloc offerBloc;

  @override
  void initState() {
    seatLayoutBloc = getIt<SeatLayoutBloc>();
    movieDetailsBloc = getIt<MovieDetailsBloc>();
    fAndBBloc = getIt<FAndBBloc>();
    homeBloc = getIt<HomeBloc>();
    offerBloc = getIt<OffersBloc>();

    final total = fAndBBloc.state.totalFinalPrice + (offerBloc.state.totalSeatPrice ?? 0) ;
    context.read<OrderConfirmationBloc>().add(InitialiseOrderConformationEvent(finalPrice: total));


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ArtBoard(
      header: BackButtonNavBar(onBackPress: () {
        navigateBackToScreen();
      }),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          navigateBackToScreen();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: context.getScreenHeight(2),
                ),
                BlocBuilder<OrderConfirmationBloc, OrderConfirmationState>(
                  builder: (BuildContext context, orderConfirmationState) {
                    return BookingStepper(
                        initialStep: orderConfirmationState.bookingFlowSteps,
                        onStepChanged: (BookingFlowSteps data) {
                          print(data.toString());
                        });
                  },),
                SizedBox(
                  height: context.getScreenHeight(2),
                ),
                MovieDetailsCard(
                  movieDetailsBloc: movieDetailsBloc,
                  fAndBBloc: fAndBBloc,
                  seatLayoutBloc: seatLayoutBloc,
                  homeBloc: homeBloc,
                ),
                SizedBox(
                  height: context.getScreenHeight(2),
                ),

                BlocBuilder<OrderConfirmationBloc,OrderConfirmationState>(
                  builder: (BuildContext context, OrderConfirmationState orderState) {

                    return PaymentAndPromoCode(
                        isCodeApplied:orderState.isVoucherApplied ?? false ,
                        onCodeAppliedState: orderState.applyVoucherCodeState,
                        onCodeRemovedState: orderState.removeVoucherCodeState,
                        title: 'Payment voucher',
                        subTitle: 'Enter the available voucher code here',
                        hintText: 'Enter Code here',
                        onCodeApplied: (promoCode) {
                          context.read<OrderConfirmationBloc>().add(ApplyVoucherCodeEvent(data: {
                            "reservationId": widget.reservationId,
                            "voucherBarcode":promoCode.trim(),
                          }, onFailure: (AppException error) { }, onSuccess: (){}));
                        },
                        onCodeRemoved: () {
                          context.read<OrderConfirmationBloc>().add(RemoveVoucherCodeEvent(
                              onFailure: (AppException error) {},
                              onSuccess: () {}, reservationId: widget.reservationId));
                        },
                        errorMessage: buildErrorSateMessage(orderState),
                        successMessage: buildSuccessSateMessage(orderState)
                    );

                },),

                SizedBox(
                  height: context.getScreenHeight(5),
                ),



              ],
            ),
          ),
        ),
      ),
      footerHeight: context.getScreenHeight(16),
      footer: BlocBuilder<OrderConfirmationBloc, OrderConfirmationState>(
        builder: (context, orderState) {
          var isLoading =
          orderState.confirmationOrderState == CurrentAppState.LOADING
              ? true
              : false;

          return Container(
            width: context.getScreenWidth(100),
            padding: const EdgeInsets.symmetric(horizontal: 22),
            height: context.getScreenHeight(16),
            decoration: BoxDecoration(
                color: context.colorPalette.backGroundColor,
                borderRadius:
                const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                border: Border(
                    top: BorderSide(color: context.colorPalette.accentColor)
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  // color: Colors.greenAccent,
                  height: context.getScreenHeight(6),
                  width: context.getScreenWidth(100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment:  CrossAxisAlignment.center  ,
                    children: [
                      Text('Total Price',
                          style: context.textThemeDecoration.subTitleSmall.copyWith(
                            fontFamily: TextThemeDecoration.HamburgerFont
                          )),
                      const Spacer(),
                      const SizedBox(width: 5,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if(orderState.isVoucherApplied== true)...[
                            Text('${currencyCode()} ${priceConverter((orderState.totalOrderPrice! + orderState.discountPrice!))}',
                                style: context.textThemeDecoration.paragraphMedium.copyWith(
                                  color: context.colorPalette.lightGreyColor,
                                  decoration: TextDecoration.lineThrough,
                                )
                            ),
                            const SizedBox(height: 2,),
                            Text('${currencyCode()} ${priceConverter((orderState.totalOrderPrice!))}',
                                style: context.textThemeDecoration.subTitleLarge.copyWith(
                                  color: context.colorPalette.accentColor,
                                )
                            )
                          ]
                          else...[
                            Text('${currencyCode()} ${priceConverter((orderState.totalOrderPrice!))}',
                                style: context.textThemeDecoration.subTitleLarge.copyWith(
                                  color: context.colorPalette.accentColor,
                                )
                            )
                          ]
                        ],
                      )

                    ],
                  ),
                ),
                SizedBox(
                  height: context.getScreenHeight(10),
                  width: context.getScreenWidth(100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomButton(
                        height: context.getScreenHeight(6),
                        backgroundColor: context.colorPalette.accentColor,
                        text: isLoading ? 'Loading...' : 'Pay ${currencyCode()} ${priceConverter((orderState.totalOrderPrice!))}',
                        textColor: context.colorPalette.darkGreyColor,
                        onTap: () {
                          context.read<OrderConfirmationBloc>().add(CompleteOrderEvent(
                              reservationId: widget.reservationId,
                              onFailure: (AppException error) {
                                ListnersUtils.showErrorMessage(error.message, 'Reservation Error', context);
                              },
                              onSuccess: () {
                                Navigator.pushNamed(context, RoutesName.ticketListScreen, arguments: {
                                  'reservationId': widget.reservationId,
                                  'isDeepLinking' : false
                                });
                              }));
                        },
                        width: context.getScreenWidth(90),
                        isDisabled: isLoading,
                      ),
                    ],
                  ),
                ),
              ],
            )
          );
        },
      ),
    );
  }

  void navigateBackToScreen() {
    if (widget.navigateToScreen == RoutesName.seatLayoutScreen) {
      context.read<OffersBloc>().add(CancelBookedSelectedSeatsEvent(
            (p0) {
          context.read<OrderConfirmationBloc>().add(
              const SetBookingStepperEvent(
                  step: BookingFlowSteps.SEAT_SELECTION));
        },
      ));
    } else {
      context
          .read<OrderConfirmationBloc>()
          .add(
          CancelFAndBEvent(reservationId: widget.reservationId, onSuccess: () {
            context.read<OrderConfirmationBloc>().add(
                const SetBookingStepperEvent(step: BookingFlowSteps.PAYMENT));
          }));
    }

    Navigator.popUntil(
        context, (route) => route.settings.name == widget.navigateToScreen);
  }

}



String? buildSuccessSateMessage(OrderConfirmationState state){
  if(state.applyVoucherCodeState == CurrentAppState.SUCCESS){
    return 'Congratulations you got discount of QAR ${priceConverter(state.discountPrice!)} 🎉';
  }
  else if(state.removeVoucherCodeState == CurrentAppState.SUCCESS){
    return null;
  }
  else{
    return null ;
  }
}

String? buildErrorSateMessage(OrderConfirmationState state){
  if(state.applyVoucherCodeState == CurrentAppState.ERROR){
    return'\u2022 ${state.appException?.message}';
  }
  else if(state.removeVoucherCodeState == CurrentAppState.ERROR){
    return'\u2022 ${state.appException?.message}';
  }
  else{
    return null ;
  }
}
