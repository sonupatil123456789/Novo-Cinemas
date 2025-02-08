import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/ImageConstants.dart';
import '../../../../core/utils/DateFormater.dart';
import '../../../Tickets/domain/models/ReservationDetailsModel.dart';

class DirectFnbMovieDetailsCard extends StatelessWidget {
  final bool showDetails;
  final ReservationDetailsModel data;
  const DirectFnbMovieDetailsCard({super.key, required this.showDetails, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                decoration: BoxDecoration(
                  color: context.colorPalette.darkGreyColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Text("${context.language.getText('bookingID')}: ${data.vistaBookingId} ",style: context.textThemeDecoration.subTitleSmall.copyWith(color: context.colorPalette.accentColor))),
            if(showDetails) Text(context.language.getText('viewDetails'),
                style: context.textThemeDecoration.paragraphLarge
                    .copyWith(color: context.colorPalette.accentColor))
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: context.getScreenHeight(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                height: context.getScreenHeight(18),
                width: context.getScreenWidth(28),
                decoration: BoxDecoration(  borderRadius: BorderRadius.circular(10),),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl:data.movie?.movieImageUrl ?? '',
                    height: context.getScreenHeight(18),
                    width: context.getScreenWidth(28),
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, downloadProgress) {
                      return Shimmer.fromColors(
                          baseColor: context.colorPalette.shimmerBaseColor,
                          highlightColor: context.colorPalette.shimmerHighLightColor,
                          enabled: true,
                          child: Container(
                            color: context.colorPalette.accentColor,
                          ));
                    },
                    errorWidget: (context, url, error) => Image.asset(
                      ImageConstants.fallBackImage,
                      height: context.getScreenHeight(18),
                      width: context.getScreenWidth(28),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),


              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      context.language.getText('movie'),
                      style: context.textThemeDecoration.titleSmall.copyWith(
                          color: context.colorPalette.whiteColor.withOpacity(0.3),
                          fontSize: 14
                      ),
                    ),
                    const SizedBox(height: 2,),
                    Text(
                      context.language.getApiText(data.movie?.movieTitle ?? '', data.movie?.movieTitleAr ?? ''),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textThemeDecoration.subTitleMedium,
                    ),
                    SizedBox(height: context.getScreenHeight(1),),
                    Text(
                      context.language.getText('date&time'),
                      style: context.textThemeDecoration.titleSmall.copyWith(
                          color: context.colorPalette.whiteColor.withOpacity(0.3),
                          fontSize: 14
                      ),
                    ),
                    const SizedBox(height: 2,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            '${getDay(data.showDateTime.toString())}-${getMonth(data.showDateTime.toString()).substring(0,3)}-${getYear(data.showDateTime.toString())}',
                            style: context.textThemeDecoration.subTitleSmall
                        ), const SizedBox(width: 5,),
                        Text(
                          '|',
                          style: context.textThemeDecoration.subTitleSmall.copyWith(
                              color: context.colorPalette.accentColor
                          ),
                        ),const SizedBox(width: 5,),
                        Text(
                            data.showTime ?? '',
                            style: context.textThemeDecoration.subTitleSmall
                        ),
                      ],
                    ),
                    SizedBox(height: context.getScreenHeight(1),),
                    Text(
                      context.language.getText('cinemaNameQty'),
                      style: context.textThemeDecoration.titleSmall.copyWith(
                          color: context.colorPalette.whiteColor.withOpacity(0.3),
                          fontSize: 14
                      ),
                    ),
                    const SizedBox(height: 2,),
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      '${data.cinema?.name ?? ''} - ${data.totalSeats}',
                      style: context.textThemeDecoration.subTitleMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
