import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novocinema/core/constants/ImageConstants.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/core/utils/CurrencyFormater.dart';

import '../../domain/models/SendReceivedDataModel.dart';

class GiftCardSent extends StatelessWidget {
  final SendReceivedDataModel data;

  const GiftCardSent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: context.getScreenWidth(100),
        // height: context.getScreenWidth(20),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
            color: context.colorPalette.transparentColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.colorPalette.accentColor.withOpacity(0.2))),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: context.getScreenWidth(10),
                  width: context.getScreenWidth(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all( color: context.colorPalette.accentColor.withOpacity(0.6))),
                  child: SvgPicture.asset(ImageConstants.gift),
                ),
                const SizedBox(height: 20),
                Text("${currencyCode()} ${priceConverter(data.balanceInCents)}",
                  overflow: TextOverflow.clip,
                  style: context.textThemeDecoration.subTitleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  data.createdAt,
                  overflow: TextOverflow.clip,
                  style: context.textThemeDecoration.subTitleLarge.copyWith(
                      color: context.colorPalette.textColor.withOpacity(0.5)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Transform.rotate(
                    angle: 0.5,
                    child: Icon(Icons.arrow_upward,
                    color: context.colorPalette.accentColor)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "to ${data.sharedWithEmail}",
                    overflow: TextOverflow.clip,
                    style: context.textThemeDecoration.subTitleLarge
                        .copyWith(color: context.colorPalette.accentColor),
                  ),
                )
              ],
            ),
          )
          // Container(
          //   height: context.getScreenHeight(5),
          //   alignment: Alignment.center,
          //   decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //           begin: Alignment.centerLeft,
          //           end: Alignment.centerRight,
          //           colors: context.colorPalette.giftCard)),
          //   child: Text(
          //     'Gift Card',
          //     style: context.textThemeDecoration.titleLarge.copyWith(
          //         fontSize: 16, color: context.colorPalette.accentColor),
          //   ),
          // ),
          // Container(
          //   decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //           begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter,
          //           colors: [
          //         const Color(0xff998F00).withOpacity(0.0),
          //         context.colorPalette.backGroundColor.withOpacity(0.4),
          //       ])),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 25),
          //     child: Column(
          //       children: [
          //         SvgPicture.asset(ImageConstants.gift),
          //         // TODO: Change too outline icon
          //         SizedBox(height: context.getScreenHeight(3)),
          //         Text(
          //           '${currencyCode()} ${priceConverter(data.balanceInCents)}',
          //           style: context.textThemeDecoration.titleLarge.copyWith(
          //               fontSize: 16, color: context.colorPalette.accentColor),
          //         ),
          //         SizedBox(height: context.getScreenHeight(3)),
          //         Container(
          //           padding: const EdgeInsets.all(10),
          //           decoration: BoxDecoration(
          //               color: context.colorPalette.whiteColor.withOpacity(0.1),
          //               borderRadius: BorderRadius.circular(8)),
          //           child: Text(
          //             'Expires on ${data.expiresAt}',
          //             style: context.textThemeDecoration.paragraphLarge
          //                 .copyWith(fontSize: 16),
          //           ),
          //         ),
          //         SizedBox(height: context.getScreenHeight(4)),
          //         GestureDetector(
          //           onTap: () async {
          //             const String textToCopy = '768ID12';
          //             if (textToCopy.isNotEmpty) {
          //               try {
          //                 await Clipboard.setData(
          //                     ClipboardData(text: textToCopy));
          //                 ScaffoldMessenger.of(context).showSnackBar(
          //                   const SnackBar(
          //                       content: Text('Copied to Clipboard!')),
          //                 );
          //               } catch (e) {
          //                 ScaffoldMessenger.of(context).showSnackBar(
          //                   const SnackBar(
          //                       content: Text('Failed to copy to clipboard.')),
          //                 );
          //               }
          //             }
          //           },
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Text(
          //                 'Gift Card Code. ',
          //                 // TODO: add gift card number if available
          //                 style: context.textThemeDecoration.subTitleMedium,
          //               ),
          //               const SizedBox(
          //                 width: 8,
          //               ),
          //               SvgPicture.asset(
          //                 ImageConstants.copy,
          //                 width: 18,
          //                 height: 18,
          //               ),
          //             ],
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () {},
          //   child: Container(
          //     width: context.getScreenWidth(70),
          //     height: context.getScreenHeight(7),
          //     decoration: BoxDecoration(
          //         gradient: LinearGradient(
          //             begin: Alignment.centerLeft,
          //             end: Alignment.centerRight,
          //             colors: context.colorPalette.giftCard)),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         SvgPicture.asset(
          //           ImageConstants.redeem,
          //           width: 15,
          //           height: 15,
          //         ),
          //         const SizedBox(
          //           width: 10,
          //         ),
          //         Text(
          //           'Check Balance Now',
          //           style: context.textThemeDecoration.subTitleLarge.copyWith(
          //               color: context.colorPalette.accentColor, fontSize: 16),
          //         ),
          //       ],
          //     ),
          //   ),
          // )
        ]));
  }
}
