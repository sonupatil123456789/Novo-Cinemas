import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:shimmer/shimmer.dart';

class MovieListShimmer extends StatelessWidget {
  const MovieListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [


        SizedBox(
            height: context.getScreenHeight(5),
            width: context.getScreenWidth(100),
            child : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(3, (index){
                // final tabsData = tabData[index];
                return Shimmer.fromColors(
                    baseColor: context.colorPalette.shimmerBaseColor,
                    highlightColor: context.colorPalette.shimmerHighLightColor,
                    enabled: true,
                    child: Container(
                      width: context.getScreenWidth(26),
                      height: context.getScreenHeight(6),
                      decoration: BoxDecoration(
                          color: context.colorPalette.cardBackgroundColor,
                          borderRadius: BorderRadius.circular(12)),
                    ));
              }).toList(),
            )
        ),
        SizedBox(height: context.getScreenHeight(3)),
        SizedBox(
          width : context.getScreenWidth(100),
          child: Wrap(
            // spacing: context.getScreenWidth(5),
            runSpacing: context.getScreenWidth(4),
            alignment: WrapAlignment.spaceBetween,
            children: List.generate(10, (index) {
              return Shimmer.fromColors(
                  baseColor: context.colorPalette.shimmerBaseColor,
                  highlightColor: context.colorPalette.shimmerHighLightColor,
                  enabled: true,
                  child: Container(
                    height: context.getScreenHeight(26),
                    width: context.getScreenWidth(40),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: context.colorPalette.backGroundColor),
                  ));
            }).toList(),
          ),
        )
      ],
    );
  }
}
