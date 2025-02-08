

import 'package:flutter/material.dart';

import 'package:novocinema/core/theams/Utils.dart';
import 'package:shimmer/shimmer.dart';
import '../ListBuilder.dart';

class MovieDetailsShimmer extends StatelessWidget {
  const MovieDetailsShimmer({super.key});




  @override
  Widget build(BuildContext context) {

    final BorderRadius borderRadius = BorderRadius.circular(12);


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Shimmer.fromColors(
                baseColor: context.colorPalette.shimmerBaseColor,
                highlightColor: context.colorPalette.shimmerHighLightColor,
                enabled: true,
                child: Container(
                    width: context.getScreenWidth(45),
                    height: context.getScreenHeight(4),
                    decoration: BoxDecoration(borderRadius: borderRadius,color: context.colorPalette.cardBackgroundColor,),

                ),
              ),
              Shimmer.fromColors(
                baseColor: context.colorPalette.shimmerBaseColor,
                highlightColor: context.colorPalette.shimmerHighLightColor,
                enabled: true,
                child: Container(
                  width: context.getScreenWidth(30),
                  height: context.getScreenHeight(4),
                  decoration: BoxDecoration(borderRadius: borderRadius,color: context.colorPalette.cardBackgroundColor,),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: context.getScreenHeight(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(3, (index){

              return Shimmer.fromColors(
                baseColor: context.colorPalette.shimmerBaseColor,
                highlightColor: context.colorPalette.shimmerHighLightColor,
                enabled: true,
                child: Container(
                  width: context.getScreenWidth(16),
                  margin: EdgeInsets.only(right: context.getScreenWidth(4.5),),
                  height: context.getScreenHeight(3),
                  decoration: BoxDecoration(borderRadius: borderRadius,color: context.colorPalette.cardBackgroundColor,),

                ),
              );

            })
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Shimmer.fromColors(
          baseColor: context.colorPalette.shimmerBaseColor,
          highlightColor: context.colorPalette.shimmerHighLightColor,
          enabled: true,
          child: Container(
            width: context.getScreenWidth(60),
            height: context.getScreenHeight(4.5),
            decoration: BoxDecoration(borderRadius: borderRadius,color: context.colorPalette.cardBackgroundColor,),

          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Shimmer.fromColors(
              baseColor: context.colorPalette.shimmerBaseColor,
              highlightColor: context.colorPalette.shimmerHighLightColor,
              enabled: true,
              child: Container(
                width: context.getScreenWidth(30),
                height: context.getScreenHeight(6),
                decoration: BoxDecoration(borderRadius: borderRadius,color: context.colorPalette.cardBackgroundColor,),

              ),
            ),
            Shimmer.fromColors(
              baseColor: context.colorPalette.shimmerBaseColor,
              highlightColor: context.colorPalette.shimmerHighLightColor,
              enabled: true,
              child: Container(
                width: context.getScreenWidth(50),
                height: context.getScreenHeight(6),
                decoration: BoxDecoration(borderRadius: borderRadius,color: context.colorPalette.cardBackgroundColor,),

              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ListBuilder<int>(
          data: const [0,1,2,3,4,5,6,7,8,9,10],
          width: context.getScreenWidth(100),
          height: context.getScreenHeight(8),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index, int date) {
            return Shimmer.fromColors(
              baseColor: context.colorPalette.shimmerBaseColor,
              highlightColor: context.colorPalette.shimmerHighLightColor,
              enabled: true,
              child: Container(
                width: context.getScreenWidth(15),
                height: context.getScreenHeight(9),
                decoration: BoxDecoration( borderRadius: borderRadius , color: context.colorPalette.cardBackgroundColor,),
              ),
            );
          },
          seprater: const SizedBox(
            width: 15,
          ),
        ),

      ],
    );
  }
}

Widget sessionShimmer(BuildContext context , borderRadius){
  return SizedBox(
    // height: context.getScreenHeight(4),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(3, (index){

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Shimmer.fromColors(
                baseColor: context.colorPalette.shimmerBaseColor,
                highlightColor: context.colorPalette.shimmerHighLightColor,
                enabled: true,
                child: Container(
                  width: context.getScreenWidth(50),
                  margin: EdgeInsets.only(right: context.getScreenWidth(4.5),),
                  height: context.getScreenHeight(2),
                  decoration: BoxDecoration(borderRadius: borderRadius,color: context.colorPalette.cardBackgroundColor,),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                // color: Colors.greenAccent,
                width: context.getScreenWidth(100),
                child: GridView.builder(
                  itemCount: 5,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      mainAxisExtent: context.getScreenHeight(7)),
                  itemBuilder: (BuildContext context, int index) {


                    return Shimmer.fromColors(
                      baseColor: context.colorPalette.shimmerBaseColor,
                      highlightColor: context.colorPalette.shimmerHighLightColor,
                      enabled: true,
                      child: Container(
                        height: context.getScreenHeight(8),
                        width: context.getScreenWidth(26),
                        decoration: ShapeDecoration(
                          color: context.colorPalette.accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: borderRadius,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
           Divider(
          height: 30,
          color: context.colorPalette.reverseBackGroundColor,
          thickness: 0.2,
          )
            ],
          );

        })
    ),
  );
}


Widget buttonShimmer(BuildContext context , borderRadius){
  return SizedBox(
    width: context.getScreenWidth(100),
    height: context.getScreenHeight(10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Shimmer.fromColors(
          baseColor: context.colorPalette.shimmerBaseColor,
          highlightColor: context.colorPalette.shimmerHighLightColor,
          enabled: true,
          child: Container(
            width: context.getScreenWidth(90),
            height: context.getScreenHeight(6),
            decoration: BoxDecoration(borderRadius: borderRadius,color: context.colorPalette.cardBackgroundColor,),

          ),
        ),
      ],
    ),
  );
}