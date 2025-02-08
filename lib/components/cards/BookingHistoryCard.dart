import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/constants/ImageConstants.dart';
import '../../core/constants/RoutesName.dart';
import '../../core/theams/TextTheamStyle.dart';
import '../../core/utils/DateFormater.dart';
import '../../dartassets/novoHeaderLogo.dart';
import '../../src/Tickets/domain/models/ReservationDetailsModel.dart';
import '../QrCodeGenerater.dart';

class BookingHistoryCard extends StatelessWidget {
  ReservationDetailsModel bookingHistory;

  BookingHistoryCard({super.key, required this.bookingHistory});

  final BorderRadius borderRadius = BorderRadius.circular(12);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.ticketListScreen, arguments: {'reservationId': bookingHistory.reservationId});
      },
      child: Container(
        width: context.getScreenWidth(100),
        height: context.getScreenHeight(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
              width: 0.6,
              color: context.colorPalette.accentColor.withOpacity(0.6)),
        ),
        padding: EdgeInsets.all(context.getScreenHeight(1.2)),
        child: Row(
          children: [
            Container(
              width: context.getScreenWidth(16),
              height: context.getScreenWidth(16),
              decoration: BoxDecoration(borderRadius: borderRadius),
              child: ClipRRect(
                borderRadius: borderRadius,
                child: CachedNetworkImage(
                  imageUrl: '',
                  width: context.getScreenWidth(18),
                  height: context.getScreenWidth(20),
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) {
                    return Shimmer.fromColors(
                        baseColor: context.colorPalette.shimmerBaseColor,
                        highlightColor:
                        context.colorPalette.shimmerHighLightColor,
                        enabled: true,
                        child: Container(
                          color: context.colorPalette.accentColor,
                        ));
                  },
                  errorWidget: (context, url, error) =>
                      Image.asset(
                        ImageConstants.fallBackImage,
                        height: context.getScreenHeight(20),
                        width: context.getScreenWidth(90),
                        fit: BoxFit.cover,
                      ),
                ),
              ),
            ),
            const SizedBox(
              width: 14,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          bookingHistory.movie?.movieTitle ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textThemeDecoration.subTitleMedium,
                        ),
                      ),

                      const SizedBox(width: 5,),

                      Icon(Icons.chevron_right, size: context.getScreenWidth(6),),

                      const SizedBox(width: 5,),


                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          '${getDay(
                              bookingHistory.showDateTime.toString())}-${getMonth(
                              bookingHistory.showDateTime.toString()).substring(
                              0, 3)}-${getYear(
                              bookingHistory.showDateTime.toString())}',
                          style: context.textThemeDecoration.paragraphLarge),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '|',
                        style: context.textThemeDecoration.subTitleSmall
                            .copyWith(color: context.colorPalette.accentColor),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(bookingHistory.showTime ?? '',
                          style: context.textThemeDecoration.paragraphLarge),
                    ],
                  ),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    '${bookingHistory.cinema?.name ?? ''} - ${bookingHistory
                        .totalSeats}',
                    style: context.textThemeDecoration.paragraphLarge,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class BookingHistoryCard extends StatelessWidget {
//   ReservationDetailsModel bookingHistory;
//   bool showRating;
//
//   BookingHistoryCard(
//       {super.key, required this.bookingHistory, this.showRating = true});
//
//   final BorderRadius borderRadius = BorderRadius.circular(12);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // TODO: receiving reservation id as ""
//         Navigator.pushNamed(context, RoutesName.ticketListScreen, arguments: {'reservationId': bookingHistory.reservationId});
//       },
//       child: Container(
//         width: context.getScreenWidth(100),
//         height: context.getScreenHeight(12),
//         decoration: BoxDecoration(
//           color: context.colorPalette.transparentColor.withOpacity(0.2),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//               width: 0.6,
//               color: context.colorPalette.accentColor.withOpacity(0.6)),
//         ),
//         padding: EdgeInsets.all(context.getScreenHeight(1.2)),
//         child: Row(
//           children: [
//             Container(
//               decoration: BoxDecoration(borderRadius: borderRadius),
//               child: ClipRRect(
//                 borderRadius: borderRadius,
//                 child: CachedNetworkImage(
//                   imageUrl: bookingHistory.movie!.movieImageUrl ?? '',
//                   fit: BoxFit.cover,
//                   width: context.getScreenWidth(18),
//                   progressIndicatorBuilder: (context, url, downloadProgress) {
//                     return Shimmer.fromColors(
//                         baseColor: context.colorPalette.shimmerBaseColor,
//                         highlightColor:
//                             context.colorPalette.shimmerHighLightColor,
//                         enabled: true,
//                         child: Container(
//                           color: context.colorPalette.accentColor,
//                         ));
//                   },
//                   errorWidget: (context, url, error) => Image.asset(
//                     ImageConstants.fallBackImage,
//                     height: context.getScreenHeight(20),
//                     width: context.getScreenWidth(90),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               width: 14,
//             ),
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           bookingHistory.movie?.movieTitle ?? '',
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: context.textThemeDecoration.subTitleMedium
//                               .copyWith(fontSize: 16),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                           '${getDay(bookingHistory.showDateTime.toString())}-${getMonth(bookingHistory.showDateTime.toString()).substring(0, 3)}-${getYear(bookingHistory.showDateTime.toString())}',
//                           style: context.textThemeDecoration.subTitleMedium
//                               .copyWith(fontSize: 12)),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       Text(
//                         '|',
//                         style: context.textThemeDecoration.subTitleSmall
//                             .copyWith(
//                                 color: context.colorPalette.accentColor,
//                                 fontSize: 12),
//                       ),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       Text(bookingHistory.showTime ?? '',
//                           style: context.textThemeDecoration.subTitleMedium
//                               .copyWith(fontSize: 12)),
//                     ],
//                   ),
//                   Text(
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     '${bookingHistory.cinema?.name ?? ''} - ${bookingHistory.totalSeats}',
//                     style: context.textThemeDecoration.subTitleMedium,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               width: 14,
//             ),
//             Column(
//               mainAxisAlignment: showRating
//                   ? MainAxisAlignment.spaceBetween
//                   : MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Icon(Icons.chevron_right, size: context.getScreenWidth(6)),
//                 if (showRating)
//                   Row(
//                     children: [
//                       Icon(Icons.star_border,
//                           color: context.colorPalette.accentColor, size: 18),
//                       Text("Ratings",
//                           style: context.textThemeDecoration.subTitleSmall
//                               .copyWith(
//                                   color: context.colorPalette.accentColor,
//                                   fontSize: 12))
//                     ],
//                   )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:novocinema/core/theams/Utils.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../core/constants/ImageConstants.dart';
// import '../../core/theams/TextTheamStyle.dart';
// import '../../core/utils/DateFormater.dart';
// import '../../src/Tickets/domain/models/ReservationDetailsModel.dart';
// import '../QrCodeGenerater.dart';
//
// class BookingHistoryCard extends StatelessWidget {
//   ReservationDetailsModel bookingHistory ;
//   BookingHistoryCard({super.key, required this.bookingHistory});
//
//   final BorderRadius borderRadius = BorderRadius.circular(12);
//
//   @override
//   Widget build(BuildContext context) {
//
//
//
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           width: context.getScreenWidth(75),
//           height: context.getScreenHeight(58),
//           margin: EdgeInsets.only(bottom: context.getScreenHeight(3)),
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                     borderRadius: borderRadius,
//                     border: Border.all(width: 0.6, color: context.colorPalette.accentColor)),
//               ),
//
//               Positioned(
//                   top: context.getScreenHeight(42),
//                   left: -context.getScreenWidth(7),
//                   child: circularContainer(context)),
//
//               Positioned(
//                 top: context.getScreenHeight(44),
//                 right: context.getScreenWidth(10),
//                 child: SizedBox(
//                   width: context.getScreenWidth(56),
//                   height: 20,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: List.generate(10, (index) {
//                       return Container(
//                         width: 8,
//                         height: 1,
//                         color: context.colorPalette.accentColor,
//                       );
//                     }),
//                   ),
//                 ),
//               ),
//
//               Positioned(
//                   top: context.getScreenHeight(42),
//                   right: -context.getScreenWidth(7),
//                   child: circularContainer(context)),
//
//
//
//               Container(
//                 width: context.getScreenWidth(75),
//                 padding: EdgeInsets.all(context.getScreenWidth(4)),
//                 decoration: BoxDecoration(borderRadius: borderRadius  ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//                     Container(
//                       height: context.getScreenHeight(20),
//                       width: context.getScreenWidth(90),
//                       decoration: BoxDecoration(borderRadius: borderRadius),
//                       child: ClipRRect(
//                         borderRadius: borderRadius,
//                         child: CachedNetworkImage(
//                           imageUrl:'',
//                           height: context.getScreenHeight(20),
//                           width: context.getScreenWidth(90),
//                           fit: BoxFit.cover,
//                           progressIndicatorBuilder: (context, url, downloadProgress) {
//                             return Shimmer.fromColors(
//                                 baseColor: context.colorPalette.shimmerBaseColor,
//                                 highlightColor: context.colorPalette.shimmerHighLightColor,
//                                 enabled: true,
//                                 child: Container(
//                                   color: context.colorPalette.accentColor,
//                                 ));
//                           },
//                           errorWidget: (context, url, error) => Image.asset(
//                             ImageConstants.fallBackImage,
//                             height: context.getScreenHeight(20),
//                             width: context.getScreenWidth(90),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(height: 10,),
//
//                     Text(
//                       'Movie',
//                       style: context.textThemeDecoration.titleSmall.copyWith(
//                         color: context.isDarkMode ? context.colorPalette.accentColor : null,
//                         fontSize: 14
//                       ),
//                     ),
//                     const SizedBox(height: 2,),
//                     Text(
//                       bookingHistory.movie?.movieTitle ?? '',
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: context.textThemeDecoration.subTitleMedium,
//                     ),
//                      SizedBox(height: context.getScreenHeight(1),),
//                     Text(
//                       'Date & Time',
//                       style: context.textThemeDecoration.titleSmall.copyWith(
//                           color: context.isDarkMode ? context.colorPalette.accentColor : null,
//                           fontSize: 14
//                       ),
//                     ),
//                     const SizedBox(height: 2,),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text(
//                             '${getDay(bookingHistory.showDateTime.toString())}-${getMonth(bookingHistory.showDateTime.toString()).substring(0,3)}-${getYear(bookingHistory.showDateTime.toString())}',
//                             style: context.textThemeDecoration.subTitleSmall
//                         ), const SizedBox(width: 5,),
//                         Text(
//                           '|',
//                           style: context.textThemeDecoration.subTitleSmall.copyWith(
//                               color: context.colorPalette.accentColor
//                           ),
//                         ),const SizedBox(width: 5,),
//                         Text(
//                             bookingHistory.showTime ?? '',
//                             style: context.textThemeDecoration.subTitleSmall
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: context.getScreenHeight(1),),
//                     Text(
//                       'Cinema Name - qty',
//                       style: context.textThemeDecoration.titleSmall.copyWith(
//                           color: context.isDarkMode ? context.colorPalette.accentColor : null,
//                           fontSize: 14
//                       ),
//                     ),
//                     const SizedBox(height: 2,),
//                     Text(
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       '${bookingHistory.cinema?.name ?? ''} - ${bookingHistory.totalSeats}',
//                       style: context.textThemeDecoration.subTitleMedium,
//                     ),
//                     SizedBox(height: context.getScreenHeight(10),),
//
//                     IntrinsicHeight(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           points(context,'Points Earned','0'),
//                            VerticalDivider(color: context.colorPalette.accentColor,thickness: 0.4,width: 5,indent: 3,),
//                           points(context,'Points Used','0')
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget circularContainer(BuildContext context) {
//     return Container(
//       width: context.getScreenWidth(15),
//       height: context.getScreenWidth(15),
//       decoration: BoxDecoration(
//           border: Border(left: BorderSide(width: 0.8, color: context.colorPalette.accentColor ),right: BorderSide(width: 0.8, color: context.colorPalette.accentColor) ),
//           color: context.colorPalette.backGroundColor,
//           borderRadius: BorderRadius.circular(100)),
//     );
//   }
//
//   Widget points (BuildContext context , String? key , String? value){
//     return SizedBox(
//       child: Column(
//         children: [
//           Text(
//             key ?? '',
//             style: context.textThemeDecoration.titleSmall.copyWith(
//                 color: context.isDarkMode ? context.colorPalette.accentColor : null,
//                 fontSize: 14
//             ),
//           ),
//           const SizedBox(height: 2,),
//           Text(
//             value ?? '',
//             style: context.textThemeDecoration.subTitleMedium,
//           ),
//         ],
//       ),
//     );
//   }
//
// }
