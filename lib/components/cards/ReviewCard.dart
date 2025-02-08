import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:novocinema/core/theams/Utils.dart';

import '../../core/constants/ImageConstants.dart';

class ReviewCard extends StatelessWidget {
  final BorderRadius borderRadius =  BorderRadius.circular(12);
  ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getScreenWidth(78),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: context.colorPalette.accentColor),
          borderRadius: borderRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: context.getScreenHeight(3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: context.getScreenWidth(50),
                  child: Text('Amina Al-Farooq Amina Amina Al-Farooq Amina Amina Al-Farooq Amina',
                      maxLines: 1 ,
                      overflow: TextOverflow.ellipsis,
                      style:context.textThemeDecoration.subTitleLarge
                  ),
                ),
                const Spacer(),
                SvgPicture.asset(ImageConstants.like)
              ],
            ),
          ),
          const SizedBox(height: 2,),
          SizedBox(
            height: context.getScreenHeight(3),
            width: context.getScreenWidth(26),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index){
                  return  SvgPicture.asset(ImageConstants.filledStar);
                }).toList()
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                children: List.generate(8, (index){
                  return Container(
                    height: context.getScreenHeight(4),
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                    margin: const EdgeInsets.only(top: 10,right: 10),
                    decoration: ShapeDecoration(
                      color: context.colorPalette.cardBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(36),

                      ),
                    ),
                    // alignment: Alignment.center,
                    child: Text('Stunning',style:context.textThemeDecoration.subTitleSmall
                    ),
                  );
                }
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}
