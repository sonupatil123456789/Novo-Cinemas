
import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:shimmer/shimmer.dart';

class CrowselShimmer extends StatelessWidget {
  const CrowselShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Shimmer.fromColors(
        baseColor: context.colorPalette.shimmerBaseColor,
        highlightColor: context.colorPalette.shimmerHighLightColor,
        enabled: true,
        child: Container(
          color: context.colorPalette.backGroundColor,
        )
    );
  }
}
