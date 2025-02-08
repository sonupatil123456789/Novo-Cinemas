

import 'package:flutter/widgets.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:shimmer/shimmer.dart';

class UpcomingBookingShimmer extends StatelessWidget {
  final int? cardCount;
  const UpcomingBookingShimmer({super.key, this.cardCount});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width : context.getScreenWidth(100),
      child: Wrap(
        runSpacing: context.getScreenWidth(5),
        alignment: WrapAlignment.spaceBetween,
        children: List.generate(cardCount ?? 10, (index) {


          return Shimmer.fromColors(
            baseColor: context.colorPalette.shimmerBaseColor,
            highlightColor: context.colorPalette.shimmerHighLightColor,
            enabled: true,
            child: Container(
              width: context.getScreenWidth(100),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: context.colorPalette.cardBackgroundColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Shimmer.fromColors(
                        baseColor: context.colorPalette.shimmerBaseColor,
                        highlightColor: context.colorPalette.shimmerHighLightColor,
                        child: Container(
                          width: context.getScreenWidth(35),
                          height: context.getScreenHeight(3.2),
                          decoration: BoxDecoration(
                            color: context.colorPalette.darkGreyColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: context.colorPalette.shimmerBaseColor,
                        highlightColor: context.colorPalette.shimmerHighLightColor,
                        child: Container(
                          width: context.getScreenWidth(24),
                          height: context.getScreenHeight(2.4),
                          decoration: BoxDecoration(
                            color: context.colorPalette.darkGreyColor,
                            borderRadius: BorderRadius.circular(10),
                          ),

                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: context.getScreenHeight(18),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Shimmer for the Image Placeholder
                        Shimmer.fromColors(
                          baseColor: context.colorPalette.shimmerBaseColor,
                          highlightColor: context.colorPalette.shimmerHighLightColor,
                          child: Container(
                            height: context.getScreenHeight(18),
                            width: context.getScreenWidth(28),
                            decoration: BoxDecoration(
                              color: context.colorPalette.darkGreyColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Shimmer.fromColors(
                                baseColor: context.colorPalette.shimmerBaseColor,
                                highlightColor: context.colorPalette.shimmerHighLightColor,
                                child: Container(
                                  width: context.getScreenWidth(20),
                                  height: context.getScreenHeight(2.2),
                                  decoration: BoxDecoration(
                                    color: context.colorPalette.darkGreyColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Shimmer.fromColors(
                                baseColor: context.colorPalette.shimmerBaseColor,
                                highlightColor: context.colorPalette.shimmerHighLightColor,
                                child: Container(
                                  width: context.getScreenWidth(50),
                                  height: context.getScreenHeight(1.7),
                                  decoration: BoxDecoration(
                                    color: context.colorPalette.darkGreyColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(height: context.getScreenHeight(1.4)),
                              Shimmer.fromColors(
                                baseColor: context.colorPalette.shimmerBaseColor,
                                highlightColor: context.colorPalette.shimmerHighLightColor,
                                child: Container(
                                  width: context.getScreenWidth(28),
                                  height: context.getScreenHeight(2.2),
                                  decoration: BoxDecoration(
                                    color: context.colorPalette.darkGreyColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Shimmer.fromColors(
                                baseColor: context.colorPalette.shimmerBaseColor,
                                highlightColor: context.colorPalette.shimmerHighLightColor,
                                child: Container(
                                  width: context.getScreenWidth(50),
                                  height: context.getScreenHeight(1.7),
                                  decoration: BoxDecoration(
                                    color: context.colorPalette.darkGreyColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),

                              SizedBox(height: context.getScreenHeight(1.4)),
                              Shimmer.fromColors(
                                baseColor: context.colorPalette.shimmerBaseColor,
                                highlightColor: context.colorPalette.shimmerHighLightColor,
                                child: Container(
                                  width: context.getScreenWidth(40),
                                  height: context.getScreenHeight(2.2),
                                  decoration: BoxDecoration(
                                    color: context.colorPalette.darkGreyColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Shimmer.fromColors(
                                baseColor: context.colorPalette.shimmerBaseColor,
                                highlightColor: context.colorPalette.shimmerHighLightColor,
                                child: Container(
                                  width: context.getScreenWidth(30),
                                  height: context.getScreenHeight(1.7),
                                  decoration: BoxDecoration(
                                    color: context.colorPalette.darkGreyColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );

        }).toList(),
      ),
    );
  }
}
