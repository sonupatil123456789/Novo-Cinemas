import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novocinema/core/constants/ImageConstants.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/core/utils/CurrencyFormater.dart';
import 'package:novocinema/core/utils/DateFormater.dart';
import 'package:novocinema/src/GiftCard/domain/models/SendReceivedDataModel.dart';

String cardData = '''
<svg width="326" height="407" viewBox="0 0 326 407" fill="none" xmlns="http://www.w3.org/2000/svg">
<g clip-path="url(#clip0_61_3383)">
<rect x="326" width="407" height="326" rx="20" transform="rotate(90 326 0)" fill="black" fill-opacity="0.2"/>
<rect x="328" width="57" height="330" transform="rotate(90 328 0)" fill="url(#paint0_linear_61_3383)"/>
<rect x="-2" y="343" width="330" height="64" fill="url(#paint1_linear_61_3383)" fill-opacity="0.2"/>
<rect x="-1.5" y="343.5" width="329" height="63" stroke="#FFEF00" stroke-opacity="0.2"/>
</g>
<defs>
<linearGradient id="paint0_linear_61_3383" x1="356.5" y1="0" x2="356.5" y2="330" gradientUnits="userSpaceOnUse">
<stop stop-color="#FFEF00" stop-opacity="0"/>
<stop offset="0.465" stop-color="#CCBF00" stop-opacity="0.8"/>
<stop offset="1" stop-color="#998F00" stop-opacity="0"/>
</linearGradient>
<linearGradient id="paint1_linear_61_3383" x1="163" y1="343" x2="163" y2="407" gradientUnits="userSpaceOnUse">
<stop stop-color="#FFDD00"/>
<stop offset="1" stop-color="#998500"/>
</linearGradient>
<clipPath id="clip0_61_3383">
<rect x="326" width="407" height="326" rx="20" transform="rotate(90 326 0)" fill="white"/>
</clipPath>
</defs>
</svg>
''';

String setData(BuildContext context) {
  return '''
   <svg width="${context.getScreenWidth(100)}" height="${context.getScreenHeight(40)}" viewBox="0 0 ${context.getScreenWidth(100)} ${context.getScreenHeight(40)}" fill="none" xmlns="http://www.w3.org/2000/svg">
<g clip-path="url(#clip0_61_3383)">
<rect x="326" width="407" height="326" rx="20" transform="rotate(90 326 0)" fill="black" fill-opacity="0.2"/>
<rect x="328" width="57" height="330" transform="rotate(90 328 0)" fill="url(#paint0_linear_61_3383)"/>
<rect x="-2" y="343" width="330" height="64" fill="url(#paint1_linear_61_3383)" fill-opacity="0.2"/>
<rect x="-1.5" y="343.5" width="329" height="63" stroke="#FFEF00" stroke-opacity="0.2"/>
</g>
<defs>
<linearGradient id="paint0_linear_61_3383" x1="356.5" y1="0" x2="356.5" y2="330" gradientUnits="userSpaceOnUse">
<stop stop-color="#FFEF00" stop-opacity="0"/>
<stop offset="0.465" stop-color="#CCBF00" stop-opacity="0.8"/>
<stop offset="1" stop-color="#998F00" stop-opacity="0"/>
</linearGradient>
<linearGradient id="paint1_linear_61_3383" x1="163" y1="343" x2="163" y2="407" gradientUnits="userSpaceOnUse">
<stop stop-color="#FFDD00"/>
<stop offset="1" stop-color="#998500"/>
</linearGradient>
<clipPath id="clip0_61_3383">
<rect x="326" width="407" height="326" rx="20" transform="rotate(90 326 0)" fill="white"/>
</clipPath>
</defs>
</svg>
   ''';
}

class GiftCardReceived extends StatelessWidget {
  final SendReceivedDataModel data;

  const GiftCardReceived({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
            width: context.getScreenWidth(100),
            // height: context.getScreenWidth(20),
            decoration: BoxDecoration(
                color: context.colorPalette.cardBackgroundColor,
                borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              Container(
                height: context.getScreenHeight(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: context.colorPalette.giftCard)),
                child: Text(
                  'Gift Card',
                  style: context.textThemeDecoration.titleLarge.copyWith(
                      fontSize: 16, color: context.colorPalette.accentColor),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      const Color(0xff998F00).withOpacity(0.0),
                      context.colorPalette.backGroundColor.withOpacity(0.4),
                    ])),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Column(
                    children: [
                      SvgPicture.asset(ImageConstants.gift), // TODO: Change too outline icon
                      SizedBox(height: context.getScreenHeight(3)),
                      Text(
                        '${currencyCode()} ${priceConverter(data.balanceInCents)}',
                        style: context.textThemeDecoration.titleLarge.copyWith(
                            fontSize: 16,
                            color: context.colorPalette.accentColor),
                      ),
                      SizedBox(height: context.getScreenHeight(3)),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: context.colorPalette.whiteColor
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          'Expires on ${data.expiresAt}',
                          style: context.textThemeDecoration.paragraphLarge
                              .copyWith(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: context.getScreenHeight(4)),
                      GestureDetector(
                        onTap: () async {
                          const String textToCopy = '768ID12';
                          if (textToCopy.isNotEmpty) {
                            try {
                              await Clipboard.setData(const ClipboardData(text: textToCopy));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Copied to Clipboard!')),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:Text('Failed to copy to clipboard.')),
                              );
                            }
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Gift Card Code. ',

                              style: context.textThemeDecoration.subTitleMedium,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            SvgPicture.asset(
                              ImageConstants.copy,
                              width: 18,
                              height: 18,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {

                },
                child: Container(
                  width: context.getScreenWidth(70),
                  height: context.getScreenHeight(7),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors:context.colorPalette.giftCard)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(ImageConstants.redeem, width: 15,height: 15,),
                      const SizedBox(width: 10,),
                      Text('Check Balance Now', style: context.textThemeDecoration.subTitleLarge.copyWith(
                          color: context.colorPalette.accentColor,
                          fontSize: 16
                      ),),

                    ],
                  ),
                ),
              )

            ])));
  }
}
