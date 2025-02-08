


import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:shimmer/shimmer.dart';

class SearchShimmer extends StatelessWidget {
  const SearchShimmer({super.key});



  @override
  Widget build(BuildContext context) {

    final cardWidth = context.getScreenWidth(100);
    final cardHeight = context.getScreenHeight(16);
    final  borderRadius = BorderRadius.circular(10) ;


    return  SingleChildScrollView(
      child:Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: context.getScreenWidth(100),
        child: Wrap(
            runSpacing: context.getScreenWidth(5),
            alignment: WrapAlignment.spaceBetween,
            children:[
              ...(List.generate(20, (index) {

                return  SizedBox(
                  height: cardHeight,
                  width: cardWidth,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: borderRadius,
                        child: Shimmer.fromColors(
                            baseColor: context.colorPalette.shimmerBaseColor,
                            highlightColor: context.colorPalette.shimmerHighLightColor,
                            enabled: true,
                            child :Container(
                              color: Colors.amber,
                              height: context.getScreenHeight(16),
                              width: context.getScreenWidth(25),
                            )
                        )
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment:MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Shimmer.fromColors(
                                baseColor: context.colorPalette.shimmerBaseColor,
                                highlightColor: context.colorPalette.shimmerHighLightColor,
                                enabled: true,
                                child: Container(
                                  width: context.getScreenWidth(100),
                                  height: context.getScreenHeight(2),
                                  decoration: BoxDecoration(borderRadius: borderRadius,color: context.colorPalette.cardBackgroundColor,),

                                ),
                              ),
                              const SizedBox(height: 10,),
                              Shimmer.fromColors(
                                baseColor: context.colorPalette.shimmerBaseColor,
                                highlightColor: context.colorPalette.shimmerHighLightColor,
                                enabled: true,
                                child: Container(
                                  width: context.getScreenWidth(45),
                                  height: context.getScreenHeight(1.5),
                                  decoration: BoxDecoration(borderRadius: borderRadius,color: context.colorPalette.cardBackgroundColor,),

                                ),
                              ),
                              const SizedBox(height: 6,),
                              Shimmer.fromColors(
                                baseColor: context.colorPalette.shimmerBaseColor,
                                highlightColor: context.colorPalette.shimmerHighLightColor,
                                enabled: true,
                                child: Container(
                                  width: context.getScreenWidth(14),
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
                                  height: context.getScreenHeight(4),
                                  width: context.getScreenWidth(26),
                                  decoration: BoxDecoration(borderRadius: borderRadius,color: context.colorPalette.cardBackgroundColor,),

                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );



              }).toList()),
            ]
        ),
      )
    );
  }
}
