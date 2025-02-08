import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/core/utils/DateFormater.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/constants/ImageConstants.dart';
import '../../core/theams/TextTheamStyle.dart';
import '../../src/Tickets/domain/models/ConcessionModel.dart';
import '../../src/Tickets/domain/models/ReservationDetailsModel.dart';
import '../CustomButton.dart';
import '../QrCodeGenerater.dart';

class FAndBTicketCard extends StatefulWidget {
  ReservationDetailsModel reservationDetails;
  Function  shareTicket;
  FAndBTicketCard({super.key, required this.reservationDetails, required this.shareTicket});

  @override
  State<FAndBTicketCard> createState() => _FAndBTicketCardState();
}

class _FAndBTicketCardState extends State<FAndBTicketCard> {
  final BorderRadius borderRadius = BorderRadius.circular(12);

  Map<String, Map<String, dynamic>> groupedData = {};

  Map<String, Map<String, dynamic>> processConcessionsData(
      List<ConcessionModel> concessionData) {
    for (var item in concessionData) {
      String id = item.concessionId!;

      if (groupedData.containsKey(id)) {
        // If ID exists, increment count
        groupedData[id]!['count'] = groupedData[id]!['count'] + item.quantity;
      } else {
        // If ID doesn't exist, create new entry
        groupedData[id] = {
          'name': item.concessionName,
          'name_ar': item.concessionNameAr,
          'count': item.quantity,
          'image_url': item.concessionImageUrl,
          'Id': item.concessionId
        };
      }
    }

    return groupedData;
  }

  @override
  void initState() {
    if (widget.reservationDetails.concessionData != null) {
      processConcessionsData(widget.reservationDetails.concessionData!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              Positioned(
                bottom: 1,
                child: GestureDetector(
                  onTap: ()=>  widget.shareTicket(widget.reservationDetails.movie?.movieTitle ??'',widget.reservationDetails.movie?.movieDescription ?? '',),
                  child: Container(
                    // alignment: Alignment.center,
                    width: context.getScreenWidth(79),
                    height: context.getScreenHeight(6),
                    decoration: BoxDecoration(
                        color: context.colorPalette.cardBackgroundColor,
                      // color: Colors.transparent,
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
              Container(
                width: context.getScreenWidth(80),
                padding: EdgeInsets.all(context.getScreenWidth(8)),
                decoration: BoxDecoration(borderRadius: borderRadius),
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
                              widget.reservationDetails.movie?.movieBannerUrl ??
                                  '',
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
                      'YOUR MEAL',
                      style: context.textThemeDecoration.titleSmall
                          .copyWith(color: context.colorPalette.accentColor),
                    ),

                    const SizedBox(
                      height: 5,
                    ),
                    // reservationDetails.movie?.s
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.reservationDetails.showDate ?? '',
                            style: context.textThemeDecoration.subTitleSmall),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '|',
                          style: context.textThemeDecoration.subTitleSmall
                              .copyWith(
                                  color: context.colorPalette.accentColor),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(widget.reservationDetails.showTime ?? '',
                            style: context.textThemeDecoration.subTitleSmall),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      widget.reservationDetails.cinema?.name ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: context.textThemeDecoration.subTitleSmall.copyWith(
                        color: context.colorPalette.accentColor,
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    CustomButton(
                      height: context.getScreenHeight(4),
                      width: context.getScreenWidth(50),
                      backgroundColor: context.colorPalette.accentColor,
                      text: 'Prepare order now',
                      textColor: context.colorPalette.darkGreyColor,
                      onTap: () {

                      },
                      borderRadius: 12.0,
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
                              data: widget.reservationDetails.vistaBookingId),
                          SizedBox(
                            width: context.getScreenWidth(38),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Meal',
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
                                        ...groupedData.values.map((toElement) {
                                          return Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: context
                                                      .getScreenWidth(28),
                                                  child: Text(
                                                    toElement['name'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
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
                                                ),
                                                Container(
                                                  width: context
                                                      .getScreenWidth(10),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'X ${toElement['count']}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    style: context
                                                        .textThemeDecoration
                                                        .paragraphSmall
                                                        .copyWith(
                                                            color: context
                                                                .colorPalette
                                                                .accentColor,
                                                            fontFamily:
                                                                TextThemeDecoration
                                                                    .HamburgerFont,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
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
                                  // alignment: Alignment.center,
                                  child: Text(
                                    'Booking ID: ${widget.reservationDetails.vistaBookingId}',
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
              )
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
