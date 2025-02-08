import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import '../../../../components/CustomButton.dart';
import '../../../Tickets/domain/models/ReservationDetailsModel.dart';
import 'UpcomingBookingCard.dart';

class ConfirmBookingPopup extends StatelessWidget {
  final ReservationDetailsModel upcomingBooking;
  final Function onTapNext;

  const ConfirmBookingPopup({super.key, required this.upcomingBooking, required this.onTapNext});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        decoration: BoxDecoration(
            color: context.colorPalette.blackColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: context.colorPalette.accentColor.withOpacity(0.3))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.language.getText('confirmYourMovie'),
                style: context.textThemeDecoration.titleMedium),
            UpcomingBookingCard(
              isSelected: false,
              upcomingBooking: upcomingBooking,
              showDetails: false,
              backgroundColor: context.colorPalette.blackColor,
              onClick: (upcomingBooking) {},
            ),
            SizedBox(height: context.getScreenHeight(2)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  height: context.getScreenHeight(6),
                  backgroundColor:
                  context.colorPalette.accentColor.withOpacity(0.1),
                  borderColor: Border.all(
                      color: context.colorPalette.accentColor.withOpacity(0.2)),
                  text: context.language.getText('cancel'),
                  textColor: context.colorPalette.accentColor,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  width: context.getScreenWidth(30),
                  isDisabled: false,
                ),
                CustomButton(
                  height: context.getScreenHeight(6),
                  backgroundColor: context.colorPalette.accentColor,
                  text: context.language.getText('confirm'),
                  textColor: context.colorPalette.darkGreyColor,
                  onTap: () => onTapNext(),
                  width: context.getScreenWidth(30),
                  isDisabled: false,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
