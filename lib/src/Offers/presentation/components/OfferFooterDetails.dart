


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/theams/Utils.dart';

import '../../../../components/CustomButton.dart';
import '../../../../components/CustomTextField.dart';
import '../../../../core/constants/ApiUrlConstants.dart';
import '../../../../core/constants/RoutesName.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/theams/TextTheamStyle.dart';
import '../../../../core/utils/CurrencyFormater.dart';
import '../../../F&B/presentation/screens/FAndBScreen.dart';
import '../../../OrderConfirmation/presentation/bloc/OrderConfirmationBloc.dart';
import '../../../SeatLayout/presentation/components/BookingStepper.dart';
import '../bloc/OffersBloc.dart';

class OfferFooterDetails extends StatefulWidget {

   const OfferFooterDetails({super.key });

  @override
  State<OfferFooterDetails> createState() => _OfferFooterDetailsState();
}

class _OfferFooterDetailsState extends State<OfferFooterDetails> {



  @override
  Widget build(BuildContext context) {

    return BlocBuilder<OffersBloc, OffersState>(builder: (BuildContext context,  offersState) {
        return Container(
          width: context.getScreenWidth(100),
          height: context.getScreenHeight(16),
          padding: const EdgeInsets.symmetric(horizontal: 22),
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
                  // crossAxisAlignment: offersState.isOffersApplied== true ||  offersState.isPromoCodeApplied == true? CrossAxisAlignment.start :  CrossAxisAlignment.center  ,
                  children: [
                    Text('Total Price',
                        style: context.textThemeDecoration.subTitleSmall.copyWith(
                            fontFamily: TextThemeDecoration.HamburgerFont
                        )),
                    const Spacer(),
                    const SizedBox(width: 5,),
                    Column(
                      mainAxisAlignment: offersState.isOffersApplied== true ||  offersState.isPromoCodeApplied == true ? MainAxisAlignment.start : MainAxisAlignment.center,
                      children: [
                        if(offersState.isOffersApplied== true ||  offersState.isPromoCodeApplied == true)...[
                          Text('${currencyCode()} ${priceConverter((offersState.totalSeatPrice! + offersState.discountPrice!))}',
                              style: context.textThemeDecoration.paragraphMedium.copyWith(
                                color: context.colorPalette.lightGreyColor,
                                decoration: TextDecoration.lineThrough,
                              )
                          ),
                          const SizedBox(height: 2,),
                          Text('${currencyCode()} ${priceConverter((offersState.totalSeatPrice!))}',
                              style: context.textThemeDecoration.subTitleLarge.copyWith(
                                color: context.colorPalette.accentColor,
                              )
                          )
                        ]
                        else...[
                          Text('${currencyCode()} ${priceConverter((offersState.totalSeatPrice!))}',
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

                    if(offersState.isOffersApplied== true || offersState.isPromoCodeApplied == true)...[
                      CustomButton(
                        height: context.getScreenHeight(6),
                        backgroundColor: context.colorPalette.accentColor,
                        text: 'Continue',
                        textColor: context.colorPalette.darkGreyColor,
                        onTap: () {
                          context.read<OrderConfirmationBloc>().add(const SetBookingStepperEvent(step: BookingFlowSteps.FANDB));
                          navigateToFAndBScreen(context , offersState);
                        },
                        width: context.getScreenWidth(100),
                      ),
                    ] else ...[
                      CustomButton(
                        height: context.getScreenHeight(6),
                        backgroundColor: context.isDarkMode ?context.colorPalette.accentColor.withOpacity(0.15) : context.colorPalette.transparentColor,
                        borderColor: Border.all(color:context.isDarkMode ? context.colorPalette.accentColor.withOpacity(0.6) : context.colorPalette.darkGreyColor,width: 2.0),
                        disabledBackgroundColor:context.colorPalette.accentColor.withOpacity(0.15),
                        textColor: context.isDarkMode ? context.colorPalette.accentColor : context.colorPalette.textColor,
                        text: 'Skip Offers',
                        onTap: () {
                          context.read<OrderConfirmationBloc>().add(const SetBookingStepperEvent(step: BookingFlowSteps.FANDB));
                          navigateToFAndBScreen(context, offersState);
                        },
                        width: context.getScreenWidth(100),),
                    ]

                  ],
                ),
              )



            ],
          ),
        );
    },);

  }

  void navigateToFAndBScreen(BuildContext context, OffersState offersState){
    Navigator.pushNamed(context, RoutesName.fAndBScreen,
        arguments: {
          'reservationId': offersState.reservationId,
          'cinemaId':offersState.seatConfirmationDetails['CinemaId'],
          'sessionId':offersState.seatConfirmationDetails['SessionId'],
          'postConcessionUrl':ApiUrlConstants.getAllFoodAndBevRage ,
          'fAndBType':FAndBType.BOOKING_FLOW_FANDB
        });
  }
}
