import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/components/CircularLoader.dart';
import 'package:novocinema/core/resources/AppException.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/Offers/presentation/bloc/OffersBloc.dart';
import 'package:novocinema/src/Offers/presentation/components/OfferFooterDetails.dart';
import 'package:novocinema/src/SeatLayout/presentation/components/BookingStepper.dart';
import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/PaymentAndPromoCode.dart';
import '../../../../components/cards/OfferCard.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/theams/TextTheamStyle.dart';
import '../../../../core/utils/CurrencyFormater.dart';
import '../../../../core/utils/SessionTimer.dart';
import '../../../../di.dart';
import '../../../OrderConfirmation/presentation/bloc/OrderConfirmationBloc.dart';
import '../../../SeatLayout/presentation/bloc/SeatLayoutBloc.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final BorderRadius borderRadius = BorderRadius.circular(12);
  late OffersBloc _offersBloc;


  late final SessionTimer _countdownTimer;




  @override
  void initState() {
    super.initState();
    _countdownTimer = SessionTimer();
    _offersBloc = context.read<OffersBloc>() ;
    final seatLayoutBloc = getIt<SeatLayoutBloc>();
    _offersBloc.add(InitialiseOffersEvent(seatLayoutBloc));
    _offersBloc.add(const GetAllOffersEvent());
  }


  void navigateBack(){
    Navigator.pop(context);
    final seatConfirmationDetails  = _offersBloc.state.seatConfirmationDetails;
    context.read<SeatLayoutBloc>().add(const ClearSeatStateEvent());
    context.read<SeatLayoutBloc>().add(GetSeatLayoutEvent(seatConfirmationDetails['SessionId'], seatConfirmationDetails['CinemaId']));
    _offersBloc.add(CancelBookedSelectedSeatsEvent( (p0) {},));
    context.read<OrderConfirmationBloc>().add(const SetBookingStepperEvent(step: BookingFlowSteps.SEAT_SELECTION));
    context.read<OffersBloc>().add(const ClearOfferStateEvent());
  }

  final _formKey = GlobalKey<FormState>();

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
                          child: Text( " : ",
                            style: context.textThemeDecoration.paragraphLarge.copyWith(color: context.colorPalette.accentColor),
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
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          navigateBack();
        },
        child: Stack(
          children: [
            Form(
              key: _formKey,
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
                  SizedBox(
                    height: context.getScreenHeight(2),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 25),
                      child: BlocBuilder<OffersBloc, OffersState>(
                        builder: (context, offersState) {
                          if (offersState.loading == CurrentAppState.SUCCESS ) {

                            return SingleChildScrollView(

                              child: Container(
                                width: context.getScreenWidth(100),
                                child: Wrap(
                                    runSpacing: context.getScreenWidth(5),
                                    alignment: WrapAlignment.spaceBetween,
                                    children: [
                                      if((offersState.offersData?.bankOffers ?? []).isNotEmpty)...[

                                        Container(
                                          clipBehavior: Clip.antiAlias,
                                          padding: EdgeInsets.all(context.getScreenWidth(3)),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: context.colorPalette.accentColor.withOpacity(0.6), width: 0.4)
                                          ),
                                          child: ListView(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            children: [
                                              Text(
                                                "Bank Offers",
                                                overflow: TextOverflow.ellipsis,
                                                  style: context.textThemeDecoration.subTitleMedium.copyWith(
                                                      fontFamily: TextThemeDecoration.HamburgerFont
                                                  )
                                              ),
                                              const SizedBox(height: 10,),

                                              ...(List.generate(
                                                  offersState.offersData?.bankOffers?.length  ??0,(index) {
                                                final bankOffers = offersState.offersData?.bankOffers?[index];

                                                return ExpandableOfferCard(
                                                  bankOffers: bankOffers,
                                                  offerState: offersState,
                                                  offerType: OfferType.BANK_OFFER,
                                                );
                                              }).toList()),
                                            ],
                                          ),
                                        )


                                      ],

                                      if((offersState.offersData?.normalOffers ?? []).isNotEmpty)...[

                                        Container(
                                          clipBehavior: Clip.antiAlias,
                                          padding: EdgeInsets.all(context.getScreenWidth(3)),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: context.colorPalette.accentColor.withOpacity(0.6), width: 0.4)
                                          ),
                                          child: ListView(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            children: [
                                              Text(
                                                "Normal Offers",
                                                overflow: TextOverflow.ellipsis,
                                                  style: context.textThemeDecoration.subTitleMedium.copyWith(
                                                      fontFamily: TextThemeDecoration.HamburgerFont
                                                  )
                                              ),
                                              const SizedBox(height: 10,),
                                              ...(List.generate(offersState.offersData?.normalOffers?.length ??0, (index) {
                                                final normalOffers = offersState.offersData?.normalOffers?[index];

                                                return ExpandableOfferCard(
                                                  bankOffers: normalOffers,
                                                  offerState: offersState,
                                                  offerType: OfferType.NORMAL_OFFER,
                                                );
                                              }).toList()),
                                            ],
                                          ),
                                        )
                                      ],


                                       PaymentAndPromoCode(
                                        isCodeApplied:offersState.isPromoCodeApplied ?? false ,
                                        onCodeAppliedState: offersState.applyDiscountCodeOfferState,
                                        onCodeRemovedState: offersState.removeDiscountCodeOfferState,
                                        title: 'Discount codes',
                                        subTitle: 'Enter the available discount code here',
                                        hintText: 'Enter Code here',
                                         onCodeApplied: (promoCode) {
                                           context.read<OffersBloc>().add(ApplyDiscountCodeOffersEvent(data: {
                                             "reservationId": context.read<OffersBloc>().state.reservationId,
                                             "discountCode":promoCode.trim(),
                                           }, onFailure: (AppException error) { }, onSuccess: (){}));
                                         },
                                         onCodeRemoved: () {
                                           context.read<OffersBloc>().add(RemoveDiscountCodeOffersEvent(
                                               onFailure: (AppException error) {},
                                               onSuccess: () {}));
                                         },
                                         errorMessage: buildErrorSateMessage(offersState),
                                         successMessage: buildSuccessSateMessage(offersState)
                                      ),

                                       SizedBox(height: 100 + MediaQuery.of(context).viewInsets.bottom,)




                                    ]),
                              ),
                            );

                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            BlocBuilder<OffersBloc, OffersState>(
              builder: (context, offersState) {
                if (offersState.loading == CurrentAppState.ERROR) {
                  return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(offersState.appException!.message.toString()));
                }

                if(offersState.loading == CurrentAppState.LOADING || offersState.loading == CurrentAppState.INITIAL){
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6,sigmaY: 6,),
                    child: const Center(child: CircularLoader()) ,
                  );
                }

                else{
                  if (offersState.offersData!.bankOffers!.isEmpty && offersState.offersData!.normalOffers!.isEmpty) {
                    return const Text('No offers avalable');
                  }
                }


                return const SizedBox.shrink();
              },
            ),

            // Positioned(
            //   bottom: MediaQuery.of(context).viewInsets.bottom,
            //   child: const OfferFooterDetails(),
            // )


          ],
        ),
      ),
      footerHeight: context.getScreenHeight(16),
      footer: const OfferFooterDetails(),
    );
  }


}

Widget clockContainer(BuildContext context, String time) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8)),
    padding: EdgeInsets.symmetric(
        horizontal: context.getScreenWidth(2),
        vertical: context.getScreenHeight(0.8)),
    alignment: Alignment.center,
    child: Text(
      time,
      style: context.textThemeDecoration.subTitleSmall
          .copyWith(color: context.isDarkMode ? context.colorPalette.accentColor : context.colorPalette.textColor),
    ),
  );
}




String? buildSuccessSateMessage(OffersState state){
  if(state.applyDiscountCodeOfferState == CurrentAppState.SUCCESS){
    return 'Congratulations you got discount of QAR ${priceConverter(state.discountPrice!)} 🎉';
  }
  else if(state.removeDiscountCodeOfferState == CurrentAppState.SUCCESS){
    return null;
  }
  else{
    return null ;
  }
}

String? buildErrorSateMessage(OffersState state){
  if(state.applyDiscountCodeOfferState == CurrentAppState.ERROR){
    return'\u2022 ${state.appException?.message}';
  }
  else if(state.removeDiscountCodeOfferState == CurrentAppState.ERROR){
    return'\u2022 ${state.appException?.message}';
  }
  else{
    return null ;
  }
}




