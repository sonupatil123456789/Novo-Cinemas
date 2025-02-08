import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:shimmer/shimmer.dart';

import '../cards/FAndBCard.dart';

class FAndBListShimmer extends StatelessWidget {
   FAndBListShimmer({super.key});

  final BorderRadius borderRadius = BorderRadius.circular(12);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getScreenWidth(100),
      child: Wrap(
        // spacing: context.getScreenWidth(5),
        runSpacing: context.getScreenWidth(2),
        alignment: WrapAlignment.spaceBetween,
        children: List.generate(10, (index) {
          return SizedBox(
            height: context.getScreenHeight(32),
            width: context.getScreenWidth(40),
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: borderRadius,
                    child: Shimmer.fromColors(
                        baseColor: context.colorPalette.shimmerBaseColor,
                        highlightColor:
                            context.colorPalette.shimmerHighLightColor,
                        enabled: true,
                        child: Container(
                          color: context.colorPalette.accentColor,
                          width: context.getScreenWidth(40),
                          height: context.getScreenWidth(40),
                        ))),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    width: context.getScreenWidth(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        Shimmer.fromColors(
                          baseColor: context.colorPalette.shimmerBaseColor,
                          highlightColor: context.colorPalette.shimmerHighLightColor,
                          enabled: true,
                          child: Container(
                            width: context.getScreenWidth(25),
                            height: context.getScreenHeight(1.5),
                            decoration: BoxDecoration(borderRadius: borderRadius,color: context.colorPalette.cardBackgroundColor,),

                          ),
                        ),
                        const SizedBox(height: 10,),
                        Shimmer.fromColors(
                          baseColor: context.colorPalette.shimmerBaseColor,
                          highlightColor: context.colorPalette.shimmerHighLightColor,
                          enabled: true,
                          child: Container(
                            width: context.getScreenWidth(16),
                            height: context.getScreenHeight(1),
                            decoration: BoxDecoration(borderRadius: borderRadius,color: context.colorPalette.cardBackgroundColor,),

                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Shimmer.fromColors(
                              baseColor: context.colorPalette.shimmerBaseColor,
                              highlightColor: context.colorPalette.shimmerHighLightColor,
                              enabled: true,
                              child: Container(
                                width: context.getScreenWidth(12),
                                height: context.getScreenHeight(2.4),
                                decoration: BoxDecoration(borderRadius: borderRadius,color: context.colorPalette.cardBackgroundColor,),

                              ),
                            ),

                            Shimmer.fromColors(
                              baseColor: context.colorPalette.shimmerBaseColor,
                              highlightColor: context.colorPalette.shimmerHighLightColor,
                              enabled: true,
                              child: Container(
                                width: context.getScreenWidth(20),
                                height: context.getScreenHeight(4),
                                decoration: BoxDecoration(
                                  color: context.colorPalette.accentColor,
                                  borderRadius: borderRadius,
                                  border: Border.all(
                                      color: context.colorPalette.accentColor,
                                      width: 0.5),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}


Widget fAndBTabShimmer(BuildContext context){
  return   SizedBox(
      width: context.getScreenWidth(100),
      height: context.getScreenHeight(6),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(10, (index) {
          return Shimmer.fromColors(
              baseColor: context.colorPalette.shimmerBaseColor,
              highlightColor: context.colorPalette.shimmerHighLightColor,
              enabled: true,
              child: Container(
                margin:
                const EdgeInsets.only(top: 6, bottom: 6, right: 10),
                width: context.getScreenWidth(25),
                height: context.getScreenWidth(3),
                decoration: BoxDecoration(
                    color: context.colorPalette.cardBackgroundColor,
                    borderRadius: BorderRadius.circular(8)),
              ));
        }).toList(),
      ));

}

