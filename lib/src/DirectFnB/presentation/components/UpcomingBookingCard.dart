import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/DirectFnB/presentation/components/DirectFnbMovieDetailsCard.dart';
import 'package:novocinema/src/Tickets/domain/models/ReservationDetailsModel.dart';

class UpcomingBookingCard extends StatelessWidget {
  bool isSelected;
  ReservationDetailsModel upcomingBooking;
  Function(ReservationDetailsModel) onClick;
  Color? backgroundColor;

  bool showDetails;

  UpcomingBookingCard(
      {super.key,
      required this.isSelected,
      required this.upcomingBooking,
      required this.onClick,
      this.backgroundColor,
      this.showDetails = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick(upcomingBooking);
      },
      child: Container(
        width: context.getScreenWidth(100),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor ?? context.colorPalette.cardBackgroundColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          // border: Border.all(
          //     color: isSelected ? context.colorPalette.accentColor : Colors.transparent)
        ),
        child: DirectFnbMovieDetailsCard(data: upcomingBooking, showDetails: showDetails),
      ),
    );
  }
}
