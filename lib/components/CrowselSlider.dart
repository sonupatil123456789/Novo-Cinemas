import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novocinema/core/constants/PrivateEnvConstants.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:novocinema/src/Home/domain/models/BannerModel.dart';
import 'package:novocinema/src/Home/domain/models/BannerMovieDetailModel.dart';
import 'package:shimmer/shimmer.dart';
import '../core/constants/ImageConstants.dart';

import '../core/constants/RoutesName.dart';
import '../core/nativeServices/DeepLinkServices.dart';
import 'AnimatedDotIndicator.dart';
import 'CustomButton.dart';
import 'TimeLanguageRating.dart';
import 'YutubePlayerDilaogBox.dart';

class CrowselSlider extends StatefulWidget {
  Function onClick;
  double? width;
  double? height;
  List<BannerModel> data;

  CrowselSlider(
      {super.key,
      required this.onClick,
      required this.data,
      this.width,
      this.height});

  @override
  State<CrowselSlider> createState() => _CrowselSliderState();
}

class _CrowselSliderState extends State<CrowselSlider> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final width = context.getScreenWidth(widget.width ?? 100);
    final height = context.getScreenHeight(widget.height ?? 33);

    return Stack(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
              aspectRatio: 57 / 23,
              autoPlay: true,
              height: height,
              enlargeCenterPage: false,
              // enableInfiniteScroll: true,
              viewportFraction: 1.0,
              onPageChanged: (index, value) {
                setState(() {
                  currentIndex = index;
                });
              },
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayCurve: Curves.easeIn),
          items: List.generate(widget.data.length, (index) {
            final BannerModel carouselData = widget.data[index];
            return Stack(
              children: [
                SizedBox(
                  height: height,
                  width: width,
                  child: CachedNetworkImage(
                    imageUrl: carouselData.bannerMobileImage ?? '',
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, downloadProgress) {
                      return Shimmer.fromColors(
                          baseColor: context.colorPalette.shimmerBaseColor,
                          highlightColor:
                              context.colorPalette.shimmerHighLightColor,
                          enabled: true,
                          child: SizedBox(
                            height: height,
                            width: width,
                          ));
                    },
                    errorWidget: (context, url, error) => Image.asset(
                      ImageConstants.fallBackImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      if (carouselData.fkBannerTypeId == '1') {
                        Navigator.pushNamed(
                            context, RoutesName.movieDetailScreen,
                            arguments: {
                              MOVIE_KEY: carouselData.movieDetails!.movieId.toString(),
                              MOVIE_IMAGE_URL: s3ImagePath + carouselData.movieDetails!.imageUrl!,
                              'isDeepLinking' :false
                            });
                      }
                      // else {
                      //   Navigator.pushNamed(
                      //       context, RoutesName.customWebViewScreen,
                      //       arguments: {
                      //         "Url": "https://pub.dev/packages/webview_flutter"
                      //       });
                      // }
                    },
                    child: Container(
                      width: width,
                      height: height / 1,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      foregroundDecoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            context.colorPalette.transparentColor,
                            context.colorPalette.backGroundColor
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.3, 1.0],
                        ),
                        // color: Colors.amberAccent
                      ),
                    ),
                  ),
                ),
                if (carouselData.fkBannerTypeId == '1') ...[
                  movieBanner(
                      context: context,
                      height: height,
                      width: width,
                      data: carouselData.movieDetails!)
                ],
              ],
            );
          }).toList(),
        ),
        Positioned(
          bottom: context.getScreenHeight(18),
          left: 10,
          child: IconButton(
            icon:  Icon(Icons.arrow_back_ios_new, size: 22, color: context.colorPalette.whiteColor),
            onPressed: () => _carouselController.previousPage(),
          ),
        ),
        Positioned(
          bottom: context.getScreenHeight(18),
          right: 10,
          child: IconButton(
            icon:  Icon(Icons.arrow_forward_ios, size: 22, color: context.colorPalette.whiteColor),
            onPressed: () => _carouselController.nextPage(),
          ),
        ),
        Positioned(
          // top: context.getScreenHeight(40),
          bottom: context.getScreenHeight(3),
          child: Container(
            width: width,
            height: 20,
            alignment: Alignment.bottomCenter,
            child: AnimatedDotIndicator(
              count: widget.data.length,
              currentIndex: currentIndex,
              activeColor: context.colorPalette.accentColor,
              inactiveColor: context.colorPalette.cardBackgroundColor,
            ),
          ),
        ),
      ],
    );
  }
}

Widget movieBanner(
    {required context,
    required width,
    required height,
    required BannerMovieDetailsModel data}) {
  return StatefulBuilder(builder: (context, state) {
    return Positioned(
      bottom: context.getScreenHeight(5),
      right: 0,
      child: Container(
        width: width,
        height: height / 2,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          SizedBox(
              width: context.getScreenWidth(100),
              child: Text(
                context.language.getApiText(data.title, data.titleAr),
                overflow: TextOverflow.ellipsis,
                style: context.textThemeDecoration.titleSmall,
              )),
          SizedBox(
            height: context.getScreenHeight(1),
          ),
          TimeLanguageRating(
            time: data.duration ?? 0,
            languages: data.language?.langName,
            rating: data.rating ?? '',
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         showDialog(
          //           context: context,
          //           useRootNavigator: false,
          //           builder: (context) {
          //             return YutubePlayerDialogBox(
          //               title: data.title,
          //               trailerUrl:
          //                   'https://youtu.be/8oIsZEhnqtA?si=IQC1e3IklVgx3MN6',
          //             );
          //           },
          //         );
          //       },
          //       child: Container(
          //         width: context.getScreenWidth(10),
          //         height: context.getScreenWidth(10),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             SvgPicture.asset(
          //               ImageConstants.playButton,
          //               height: 24,
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 25,
          //     ),
          //     CustomButton(
          //       height: context.getScreenHeight(5),
          //       width: context.getScreenWidth(33),
          //       backgroundColor: context.colorPalette.accentColor,
          //       text: 'Book Now',
          //       textColor: context.colorPalette.blackColor,
          //       onTap: () {
          //         Navigator.pushNamed(context, RoutesName.movieDetailScreen,
          //             arguments: {
          //               MOVIE_KEY: data.movieId.toString(),
          //               MOVIE_IMAGE_URL: s3ImagePath + data.imageUrl!
          //             });
          //       },
          //     ),
          //   ],
          // ),
        ]),
      ),
    );
  });
}
