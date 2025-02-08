import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:shimmer/shimmer.dart';

class BookingHistoryShimmer extends StatelessWidget {
  const BookingHistoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getScreenWidth(100),
      child: Wrap(
        runSpacing: context.getScreenWidth(5),
        alignment: WrapAlignment.spaceBetween,
        children: List.generate(10, (index) {
          return Container(
            width: context.getScreenWidth(100),
            height: context.getScreenHeight(12),
            padding: EdgeInsets.all(context.getScreenHeight(1.2)),
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: context.colorPalette.shimmerBaseColor,
                  highlightColor: context.colorPalette.shimmerHighLightColor,
                  child: Container(
                    width: context.getScreenWidth(18),
                    decoration: BoxDecoration(
                      color: context.colorPalette.darkGreyColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: context.colorPalette.shimmerBaseColor,
                      highlightColor:
                          context.colorPalette.shimmerHighLightColor,
                      child: Container(
                        width: context.getScreenWidth(60),
                        height: context.getScreenHeight(2),
                        decoration: BoxDecoration(
                          color: context.colorPalette.darkGreyColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Shimmer.fromColors(
                      baseColor: context.colorPalette.shimmerBaseColor,
                      highlightColor:
                      context.colorPalette.shimmerHighLightColor,
                      child: Container(
                        width: context.getScreenWidth(50),
                        height: context.getScreenHeight(2),
                        decoration: BoxDecoration(
                          color: context.colorPalette.darkGreyColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Shimmer.fromColors(
                      baseColor: context.colorPalette.shimmerBaseColor,
                      highlightColor:
                      context.colorPalette.shimmerHighLightColor,
                      child: Container(
                        width: context.getScreenWidth(40),
                        height: context.getScreenHeight(2),
                        decoration: BoxDecoration(
                          color: context.colorPalette.darkGreyColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
