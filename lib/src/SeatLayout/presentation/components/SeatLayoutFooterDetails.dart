


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/SeatLayout/presentation/bloc/SeatLayoutBloc.dart';

import '../../../../components/CustomButton.dart';
import '../../../../core/constants/ImageConstants.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/theams/TextTheamStyle.dart';
import '../../../../core/utils/CurrencyFormater.dart';
import '../screens/SeatLayoutScreen.dart';


class SeatLayoutFooterDetails extends StatefulWidget {
  final MovieSelectionType movieSelectionType;
  final Function onQuickPayClick ;
  final Function onContinueClick ;

   const SeatLayoutFooterDetails({super.key, required this.movieSelectionType, required this.onContinueClick,required this.onQuickPayClick, });

  @override
  State<SeatLayoutFooterDetails> createState() => _SeatLayoutFooterDetailsState();
}

class _SeatLayoutFooterDetailsState extends State<SeatLayoutFooterDetails> {





  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SeatLayoutBloc, SeatLayoutState>(builder: (BuildContext context,  seatState) {

      final totalPrice = seatState.bookSelectedSeat.fold(0, (total, current) {
        return total + (current['PriceInCents'] as int? ?? 0);
      });

      var isContinueLoading =
      seatState.bookSelectedSeatState == CurrentAppState.LOADING
          ? true
          : false;

      var isQuickPayLoading =
      seatState.bookSelectedSeatState == CurrentAppState.LOADING
          ? true
          : false;


      return Container(
        decoration: BoxDecoration(borderRadius:
        const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            color: Colors.transparent,
            border: Border(
              top: BorderSide(color: context.colorPalette.accentColor)
            )),
        height: context.getScreenHeight(10),
        width: context.getScreenWidth(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            if(seatState.selectedSeat.isNotEmpty)...[
              Container(
                height: context.getScreenHeight(8),
                width: context.getScreenWidth(100),
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                              seatState.bookSelectedSeat.map((seats) {
                                return "${seats['RowName']}${seats['SeatName']}";
                              }).toList().join(', '),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textThemeDecoration.subTitleSmall.copyWith(
                                  fontFamily: TextThemeDecoration.HamburgerFont)),
                        ),
                         SizedBox( width: context.getScreenWidth(15),),
                        Text("Qty x ${seatState.bookSelectedSeat.length.toString()}",
                            style: context.textThemeDecoration.subTitleSmall.copyWith(fontFamily: TextThemeDecoration.HamburgerFont))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Price:",
                          style: context.textThemeDecoration.subTitleSmall.copyWith(fontFamily: TextThemeDecoration.HamburgerFont),
                        ),
                        Text(
                          "${currencyCode()} ${priceConverter(totalPrice)}",
                          style: context.textThemeDecoration.subTitleSmall .copyWith(fontFamily: TextThemeDecoration.HamburgerFont),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: context.getScreenWidth(100),
                height: context.getScreenHeight(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                        height: context.getScreenHeight(6),
                        text:" Quick Pay ${priceConverter(totalPrice)} ",
                        // text: isQuickPayLoading ? 'Loading...' :" Quick Pay ${priceConverter(totalPrice)} ",
                        textColor: context.isDarkMode ? context.colorPalette.accentColor : context.colorPalette.textColor,
                        onTap:widget.onQuickPayClick,
                        backgroundColor: context.isDarkMode ?context.colorPalette.accentColor.withOpacity(0.15) : context.colorPalette.transparentColor,
                        borderColor: Border.all(color:context.isDarkMode ? context.colorPalette.accentColor.withOpacity(0.6) : context.colorPalette.darkGreyColor,width: 2.0),
                        disabledBackgroundColor:context.colorPalette.accentColor.withOpacity(0.15),
                        width: context.getScreenWidth(40),
                        isDisabled: seatState.bookSelectedSeat.isEmpty || isQuickPayLoading ? true : false),
                    CustomButton(
                        height: context.getScreenHeight(6),
                        backgroundColor: context.colorPalette.accentColor,
                        text: isContinueLoading ? 'Loading...' : 'Proceed',
                        textColor: context.colorPalette.darkGreyColor,
                        onTap:widget.onContinueClick,
                        width: context.getScreenWidth(40),
                        isDisabled: seatState.bookSelectedSeat.isEmpty ||isContinueLoading ? true : false),

                  ],
                ),
              ),
            ]else ...[
              staticSeatType(context)
            ]

          ],
        ),
      );




    },);
  }





}


Widget staticSeatType(BuildContext context) {
  return Container(
    width: context.getScreenWidth(100),
    height: context.getScreenHeight(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: seatInfoData.map((toElement) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              toElement.icon,
              width: context.getScreenWidth(4),
              height: context.getScreenWidth(4),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              toElement.name,
              style: context.textThemeDecoration.paragraphMedium,
            )
          ],
        );
      }).toList(),
    ),
  );
}

class SeatInfo {
  String name;
  String icon;

  SeatInfo(this.name, this.icon);
}

List<SeatInfo> seatInfoData = [
  SeatInfo("Available", ImageConstants.avalableSeat),
  SeatInfo("Sold", ImageConstants.soldSeat),
  SeatInfo("Selected", ImageConstants.selectedSeat),
  SeatInfo("Disabilities", ImageConstants.disableSeat),
];