import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constants/ImageConstants.dart';
import '../../src/Movies/domain/models/MovieCastModel.dart';

class Cast {
  int Id;
  String castName;
  String castImage;
  Cast(this.Id, this.castName, this.castImage);
}

List<Cast> castData = [
  Cast(14567890, "Ryan Reynols", 'assets/pngassets/cast1.png'),
  Cast(22345432, "Hugh Jackman", 'assets/pngassets/cast2.png'),
  Cast(39873215, "Emma Corrin", 'assets/pngassets/cast3.png'),
  Cast(41287432, "Mike Johnson", 'assets/pngassets/cast4.jpeg'),
  Cast(51209812, "Chris Lee", 'assets/pngassets/cast1.png'),
  Cast(69876523, "John Doe", 'assets/pngassets/cast4.jpeg'),
];

class CastCard extends StatelessWidget {
  final MovieCastModel castData;
  final void Function(BuildContext context, MovieCastModel cast) onPressEvent;
  CastCard({super.key, required this.castData,required this.onPressEvent});

  final BorderRadius borderRadius =  BorderRadius.circular(12);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: context.getScreenWidth(24),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child : CachedNetworkImage(
                imageUrl: castData.picture??'',
                height: context.getScreenWidth(20),
                width: context.getScreenWidth(20),
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
                errorWidget: (context, url, error) => SvgPicture.asset(
                  ImageConstants.fallBackImageCast,
                  height: context.getScreenWidth(20),
                  width: context.getScreenWidth(20),
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text("${castData.firstName} ${castData.lastName}" ,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: context.textThemeDecoration.subTitleSmall),
              ),
            )
          ],
        ),
      ),
    );
  }
}
