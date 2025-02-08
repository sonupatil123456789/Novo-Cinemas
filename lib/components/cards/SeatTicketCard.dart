import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/constants/ImageConstants.dart';
import '../../core/theams/TextTheamStyle.dart';
import '../../core/utils/DateFormater.dart';
import '../../src/Tickets/domain/models/ReservationDetailsModel.dart';
import '../QrCodeGenerater.dart';

class SeatTicketCard extends StatelessWidget {
  ReservationDetailsModel reservationDetails;
  Function(String,String) shareTicket;
  SeatTicketCard({super.key, required this.reservationDetails, required this.shareTicket});

  final BorderRadius borderRadius = BorderRadius.circular(12);

  @override
  Widget build(BuildContext context) {
    // final movieDate = reservationDetails.showDateTime.toString();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: context.getScreenWidth(80),
          height: context.getScreenHeight(72),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    border: Border.all(
                        width: 0.6, color: context.colorPalette.accentColor)),
              ),
              Positioned(
                  top: context.getScreenHeight(38),
                  left: -context.getScreenWidth(7),
                  child: circularContainer(context)),
              Positioned(
                top: context.getScreenHeight(40),
                right: context.getScreenWidth(10),
                child: SizedBox(
                  width: context.getScreenWidth(60),
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(14, (index) {
                      return Container(
                        width: 8,
                        height: 1,
                        color: context.colorPalette.accentColor,
                      );
                    }),
                  ),
                ),
              ),
              Positioned(
                  top: context.getScreenHeight(38),
                  right: -context.getScreenWidth(7),
                  child: circularContainer(context)),

              Container(
                width: context.getScreenWidth(80),
                padding: EdgeInsets.all(context.getScreenWidth(8)),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(40)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: context.getScreenHeight(20),
                      width: context.getScreenWidth(90),
                      decoration: BoxDecoration(borderRadius: borderRadius),
                      child: ClipRRect(
                        borderRadius: borderRadius,
                        child: CachedNetworkImage(
                          imageUrl:
                              reservationDetails.movie?.movieBannerUrl ?? '',
                          height: context.getScreenHeight(20),
                          width: context.getScreenWidth(90),
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) {
                            return Shimmer.fromColors(
                                baseColor:
                                    context.colorPalette.shimmerBaseColor,
                                highlightColor:
                                    context.colorPalette.shimmerHighLightColor,
                                enabled: true,
                                child: Container(
                                  color: context.colorPalette.accentColor,
                                ));
                          },
                          errorWidget: (context, url, error) => Image.asset(
                            ImageConstants.fallBackImage,
                            height: context.getScreenHeight(20),
                            width: context.getScreenWidth(90),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      reservationDetails.movie?.movieTitle ?? '',
                      style: context.textThemeDecoration.titleSmall.copyWith(
                          color: context.isDarkMode
                              ? context.colorPalette.accentColor
                              : null),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'English, 2D',
                          style: context.textThemeDecoration.subTitleSmall,
                        ),
                        Text(
                          '|',
                          style: context.textThemeDecoration.subTitleSmall
                              .copyWith(
                                  color: context.colorPalette.accentColor),
                        ),
                        Text(reservationDetails.showDate ?? '',
                            style: context.textThemeDecoration.subTitleSmall),
                        Text(
                          '|',
                          style: context.textThemeDecoration.subTitleSmall
                              .copyWith(
                                  color: context.colorPalette.accentColor),
                        ),
                        Text(reservationDetails.showTime ?? '',
                            style: context.textThemeDecoration.subTitleSmall),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      reservationDetails.cinema?.name ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: context.textThemeDecoration.subTitleSmall.copyWith(
                        color: context.colorPalette.accentColor,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: context.getScreenHeight(4),
                      width: context.getScreenWidth(60),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: ShapeDecoration(
                        color: context.colorPalette.cardBackgroundColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36),
                            side: BorderSide(
                                width: 0.2,
                                color: context.colorPalette.accentColor)),
                      ),
                      // alignment: Alignment.center,
                      child: Text(
                        '230 Loyalty points EARNED',
                        style: context.textThemeDecoration.paragraphMedium
                            .copyWith(
                                color: context.colorPalette.accentColor,
                                fontFamily: TextThemeDecoration.HamburgerFont),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: context.getScreenHeight(9),
                    ),
                    SizedBox(
                      height: context.getScreenHeight(18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          QrCodeGenerater(
                              qrSize: context.getScreenWidth(23.5),
                              data: reservationDetails.vistaBookingId),
                          SizedBox(
                            width: context.getScreenWidth(38),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Tickets',
                                  style: context
                                      .textThemeDecoration.subTitleLarge
                                      .copyWith(
                                          fontFamily: TextThemeDecoration
                                              .HamburgerFont),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        if (reservationDetails.seatName !=
                                            null) ...[
                                          ...reservationDetails.seatName!
                                              .map((seatData) {
                                            return Container(
                                              width: context.getScreenWidth(40),
                                              padding: const EdgeInsets.only(
                                                  bottom: 5),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    seatData.areaName ?? '',
                                                    style: context
                                                        .textThemeDecoration
                                                        .paragraphSmall
                                                        .copyWith(
                                                            color: context
                                                                .colorPalette
                                                                .accentColor,
                                                            fontFamily:
                                                                TextThemeDecoration
                                                                    .HamburgerFont),
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                    seatData.seats ?? '',
                                                    textAlign: TextAlign.center,
                                                    style: context
                                                        .textThemeDecoration
                                                        .paragraphSmall
                                                        .copyWith(
                                                            color: context
                                                                .colorPalette
                                                                .accentColor,
                                                            fontFamily:
                                                                TextThemeDecoration
                                                                    .HamburgerFont),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: context.getScreenHeight(4),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                  ),
                                  alignment: Alignment.center,
                                  decoration: ShapeDecoration(
                                    color: context
                                        .colorPalette.cardBackgroundColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: borderRadius,
                                    ),
                                  ),
                                  child: Text(
                                    'Booking ID: ${reservationDetails.vistaBookingId}',
                                    style: context
                                        .textThemeDecoration.paragraphSmall
                                        .copyWith(
                                            color: context
                                                .colorPalette.accentColor,
                                            fontFamily: TextThemeDecoration
                                                .HamburgerFont),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: context.getScreenHeight(2),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 1,
                child: GestureDetector(
                  onTap: () => shareTicket(reservationDetails.movie?.movieTitle ??'', reservationDetails.movie?.movieDescription ?? '',),
                  child: Container(
                    // alignment: Alignment.center,
                    width: context.getScreenWidth(79),
                    height: context.getScreenHeight(6),
                    decoration: BoxDecoration(
                        color: context.colorPalette.cardBackgroundColor,
                        shape: BoxShape.rectangle,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(ImageConstants.share),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("SHARE TICKET",
                            style: context.textThemeDecoration.titleSmall
                                .copyWith(
                                fontSize: 14,
                                color: context.colorPalette.accentColor)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget circularContainer(BuildContext context) {
    return Container(
      width: context.getScreenWidth(15),
      height: context.getScreenWidth(15),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  width: 0.9, color: context.colorPalette.accentColor),
              right: BorderSide(
                  width: 0.9, color: context.colorPalette.accentColor)),
          color: context.colorPalette.backGroundColor,
          borderRadius: BorderRadius.circular(100)),
    );
  }
}
