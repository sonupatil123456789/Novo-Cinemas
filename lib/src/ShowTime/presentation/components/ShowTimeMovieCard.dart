

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/entities/models/ShowTimeDetailsModel.dart';
import 'package:novocinema/src/ShowTime/domain/models/ShowTimeMoviesModel.dart';
import 'package:novocinema/src/ShowTime/presentation/components/ShowDetails.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/ImageConstants.dart';


class ShowTimeMovieCard extends StatelessWidget {
  ShowTimeMovieModel movieData;
  ShowTimeDetailsModel selectedShowTime;

  void Function(BuildContext context, ShowTimeMovieModel movie, ShowTimeDetailsModel showTime) onPressEvent;

  ShowTimeMovieCard({super.key, required this.movieData, required this.onPressEvent , required this.selectedShowTime});




  final double borderRadius = 10;


  @override
  Widget build(BuildContext context) {


    final cardWidth = context.getScreenWidth(100);
    final cardHeight = context.getScreenHeight(16);

    return Container(
      // height: cardHeight,
      width: cardWidth,
      margin: EdgeInsets.only(bottom: context.getScreenHeight(3)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: CachedNetworkImage(
                  imageUrl: movieData.movieImageUrl??'',
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

              Expanded(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20, vertical: context.getScreenHeight(1.5)),
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          movieData.movieTitle ?? '',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: context.textThemeDecoration.titleSmall
                      ),
                      // Text(
                      //     movieData.genres != null ? movieData.genres!.map((genra)=> genra.genreName.toString()).join(", ") : '',
                      //     textAlign: TextAlign.center,
                      //     overflow: TextOverflow.ellipsis,
                      //     style: context.textThemeDecoration.paragraphLarge
                      // ),
                      // const SizedBox(height: 5,),
                      // Text(
                      //     movieData.languages?.langName ??'',
                      //     textAlign: TextAlign.center,
                      //     overflow: TextOverflow.ellipsis,
                      //     style: context.textThemeDecoration.paragraphLarge
                      // ),
                      const SizedBox(height: 10,),
                      // CustomButton(
                      //   height: context.getScreenHeight(4),
                      //   text: 'Book Now',
                      //   textColor: context.colorPalette.darkGreyColor,
                      //   onTap: () {
                      //     // onPressEvent(context , movieData);
                      //   },
                      //   width: context.getScreenWidth(26),
                      // )
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: context.getScreenHeight(2),),


          if (movieData.sessions != null && movieData.sessions!.isNotEmpty)

           ShowTimeDetails(showTimeList: movieData.sessions!, onPressEvent: (showTime) {

             onPressEvent(context, movieData, showTime);

           }, selectedDate: selectedShowTime,)


        ],
      ),
    );
  }
}



// context.read<MovieDetailsBloc>().add(OnMallTimeSelectedEvent(
// showTime: selectedShowTime,
// mallName: mallName,
// ));