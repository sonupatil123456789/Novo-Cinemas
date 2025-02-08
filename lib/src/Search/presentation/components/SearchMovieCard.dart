import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/Search/domain/models/SearchMovieModel.dart';
import 'package:shimmer/shimmer.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../../../../components/CustomButton.dart';
import '../../../../core/constants/ImageConstants.dart';




class SearchMovieCard extends StatelessWidget {
  SearchMovieModel movieData;
  void Function(BuildContext context, SearchMovieModel movie) onPressEvent;

  SearchMovieCard({super.key, required this.movieData, required this.onPressEvent});




  final double borderRadius = 10;


  @override
  Widget build(BuildContext context) {

    String HeroName = movieData.id.toString();
    final cardWidth = context.getScreenWidth(100);
    final cardHeight = context.getScreenHeight(16);

    return GestureDetector(
      onTap: () {
        onPressEvent(context, movieData);
      },
      child: SizedBox(
        height: cardHeight,
        width: cardWidth,
        child: Row(
          children: [
            Hero(
              tag: HeroName,
              child :ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: CachedNetworkImage(
                  imageUrl: movieData.imageUrl??'',
                  height: context.getScreenHeight(16),
                  width: context.getScreenWidth(25),
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

                  errorWidget: (context, url, error) => Image.asset(
                    ImageConstants.fallBackImage,
                    height: cardHeight,width: cardWidth,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        movieData.name ?? '',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: context.textThemeDecoration.titleSmall
                    ),
                    Text(
                        movieData.genres != null ? movieData.genres!.map((genra)=> genra.genreName.toString()).join(", ") : '',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: context.textThemeDecoration.paragraphLarge
                    ),
                    const SizedBox(height: 5,),
                    Text(
                        movieData.languages?.langName ??'',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: context.textThemeDecoration.paragraphLarge
                    ),
                    const SizedBox(height: 10,),
                    CustomButton(
                      height: context.getScreenHeight(4),
                      text: 'Book Now',
                      textColor: context.colorPalette.darkGreyColor,
                      onTap: () {
                        onPressEvent(context , movieData);
                      },
                      width: context.getScreenWidth(26),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

