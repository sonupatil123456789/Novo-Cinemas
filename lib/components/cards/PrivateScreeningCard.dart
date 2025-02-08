import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constants/ImageConstants.dart';
import '../../src/PrivateScreening/presentation/components/PrivateScreeningDetailDialogBox.dart';
import '../CustomButton.dart';

class PrivateScreeningCard extends StatelessWidget {
  Map<String, dynamic> privateScreeningData;
  void Function(BuildContext context, Map<String, dynamic> privateScreeningData)
      onPressEvent;

  PrivateScreeningCard(
      {super.key,
      required this.privateScreeningData,
      required this.onPressEvent});

  final double borderRadius = 10;

  @override
  Widget build(BuildContext context) {
    final cardWidth = context.getScreenWidth(100);
    final cardHeight = context.getScreenHeight(35);

    return SizedBox(
      width: cardWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: CachedNetworkImage(
              imageUrl: privateScreeningData['image'],
              width: context.getScreenWidth(100),
              height: context.getScreenHeight(20),
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
                height: cardHeight,
                width: cardWidth,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: context.getScreenHeight(1),
          ),
          Text(privateScreeningData['title'],
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: context.textThemeDecoration.subTitleLarge.copyWith(fontSize: 16)),
          SizedBox(
            height: context.getScreenHeight(1.2),
          ),
          Text(
            privateScreeningData['subtitle'],
            style: context.textThemeDecoration.paragraphLarge.copyWith(fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: context.getScreenHeight(1.2),
          ),
          SizedBox(
            // color: context.colorPalette.backGroundColor,
            width: context.getScreenWidth(100),
            height: context.getScreenHeight(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  height: context.getScreenHeight(6),
                  backgroundColor: context.colorPalette.transparentColor,
                  iconSpacing: 10,
                  text: 'More info',
                  textColor: context.colorPalette.accentColor,
                  onTap: () async {
                    showDialog(context: context,
                        builder: (context) {
                          return const  PrivateScreeningDetailDialogBox();
                        },);
                  },
                  borderColor: Border.all(
                      color: context.colorPalette.accentColor, width: 2.0),
                  width: context.getScreenWidth(30),
                ),
                CustomButton(
                  height: context.getScreenHeight(6),
                  backgroundColor: context.colorPalette.accentColor,
                  text: 'Book Now',
                  textColor: context.colorPalette.darkGreyColor,
                  onTap: () {},
                  width: context.getScreenWidth(50),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
