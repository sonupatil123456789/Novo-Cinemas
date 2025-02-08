


import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';

import '../core/utils/DateFormater.dart';

class TimeLanguageRating extends StatelessWidget {
  int time ;
  dynamic languages;
  String rating ;


  TimeLanguageRating({super.key, required this.time, required this.languages , required this.rating});

  final BorderRadius borderRadius =  BorderRadius.circular(12);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
                convertMinutesToHours(time),
                overflow: TextOverflow.ellipsis,
                style: context.textThemeDecoration.subTitleLarge.copyWith(
                    fontWeight: FontWeight.w500
                )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: VerticalDivider(
                  color: context.colorPalette.reverseBackGroundColor,
                  thickness: 0
              ),
            ),
            Text(
              languages ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: context.textThemeDecoration.subTitleMedium.copyWith(fontWeight: FontWeight.w400),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: VerticalDivider(
                  color: context.colorPalette.reverseBackGroundColor,
                  thickness: 0
              ),
            ),
            Container(
              // width: context.getScreenWidth(20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              height: context.getScreenHeight(4),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: context.colorPalette.reverseBackGroundColor),
                  borderRadius: borderRadius),
              child: Text(rating,style:context.textThemeDecoration.subTitleLarge),
            ),
          ],
        ),
      ),
    );
  }
}



