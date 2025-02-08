import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/Movies/domain/models/MovieModel.dart';
import 'package:novocinema/src/Home/presentation/bloc/HomeBloc.dart';
import 'package:novocinema/src/MovieDetails/presentation/bloc/MovieDetailsBloc.dart';
import 'package:novocinema/src/Movies/presentation/bloc/MoviesBloc.dart';

import 'package:shimmer/shimmer.dart';
import '../../core/constants/ApiUrlConstants.dart';
import '../../core/constants/ImageConstants.dart';
import '../../core/constants/RoutesName.dart';
import '../../core/theams/TextTheamStyle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../src/Auth/presentation/bloc/AuthBloc.dart';
import '../../src/Auth/presentation/screens/LoginScreen.dart';
import '../CustomButton.dart';
import '../TimeLanguageRating.dart';
import '../YutubePlayerDilaogBox.dart';

class MovieGridCard extends StatefulWidget {
  MovieModel movieData;
  void Function(BuildContext context, MovieModel movie) onPressEvent;

  MovieGridCard(
      {super.key, required this.movieData, required this.onPressEvent});

  @override
  State<MovieGridCard> createState() => _MovieGridCardState();
}

class _MovieGridCardState extends State<MovieGridCard> {
  final double borderRadius = 10;
  bool focusCard = false;
  bool liked = false;

  @override
  void initState() {
    liked = widget.movieData.isMovieLiked!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String HeroName = widget.movieData.hashCode.toString();
    final cardWidth = context.getScreenWidth(40);
    final cardHeight = context.getScreenHeight(26);

    return GestureDetector(
      onTap: () {
        widget.onPressEvent(context, widget.movieData);
      },
      onLongPress: () {
        setState(() {
          focusCard = !focusCard;
        });
      },
      child: SizedBox(
        height: cardHeight,
        width: cardWidth,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Stack(
            children: [
              Hero(
                tag: HeroName,
                child: CachedNetworkImage(
                  imageUrl: widget.movieData.movieImageUrl ?? '',
                  height: cardHeight,
                  width: cardWidth,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) {
                    return Shimmer.fromColors(
                        baseColor: context.colorPalette.shimmerBaseColor,
                        highlightColor:
                            context.colorPalette.shimmerHighLightColor,
                        enabled: true,
                        child: Container(
                          color: context.colorPalette.accentColor,
                        ));
                  },
                  errorWidget: (context, url, error) => Image.asset(
                    ImageConstants.fallBackImage,
                    height: cardHeight,
                    width: cardWidth,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (widget.movieData.isAdvanceBookingAvailable == true) ...[
                Positioned(
                  top: 10,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: context.getScreenHeight(3),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: context.colorPalette.accentColor,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0)),
                    ),
                    child: Text(
                      "ADVANCE BOOKING",
                      style: context.textThemeDecoration.paragraphSmall
                          .copyWith(
                              color: const Color(0xff000000),
                              fontSize: 8,
                              fontFamily: TextThemeDecoration.HamburgerFont),
                    ),
                  ),
                ),
              ],

              Positioned(
                bottom: 16,
                left: 12,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: context.getScreenWidth(2)),
                  alignment: Alignment.center,
                  height: context.getScreenHeight(4),
                  decoration: BoxDecoration(
                      color: context.colorPalette.whiteColor.withOpacity(0.6),
                      border: Border.all(color: context.colorPalette.whiteColor),
                      borderRadius: const BorderRadius.all(Radius.circular(10),)),
                  child: Text(
                    widget.movieData.movieRating ?? '',
                    style: context.textThemeDecoration.subTitleLarge.copyWith(
                      fontSize: 12
                    ),
                  ),
                ),
              ),


              Positioned(
                  bottom: 16,
                  right: 12,
                  child: InkWell(
                    onTap: () {
                      context
                          .read<AuthBloc>()
                          .add(AuthenticateUserEvent(onSuccess: () {
                            setState(() {
                              liked = !liked;
                            });

                            context.read<MovieDetailsBloc>().add(
                                LikeDislikeEvent(
                                    url: ApiUrlConstants.likeMovie,
                                    data: <String, dynamic>{
                                      "movieId": widget.movieData.vistaFilmId,
                                      "islikedMovie": liked
                                    },
                                    onFailure: (error) {},
                                    onSuccess: (data) {
                                      context.read<MoviesBloc>().add(
                                          LikeMovieEvent(
                                              widget.movieData, liked));
                                    }));
                          }, onFailure: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    settings: const RouteSettings(
                                        name: RoutesName.loginScreen),
                                    builder: (context) {
                                      return LogInScreen(
                                          onLogin: (bool isLogin) {
                                        Navigator.popUntil(
                                            context,
                                            (route) =>
                                                route.settings.name ==
                                                RoutesName.mainSection);
                                      });
                                    }));
                          }));
                    },
                    child: Container(
                      width: context.getScreenWidth(8),
                      height: context.getScreenWidth(8),
                      decoration: BoxDecoration(
                          color: liked
                              ? context.colorPalette.accentColor
                              : context.colorPalette.whiteColor
                                  .withOpacity(0.6),
                          borderRadius: BorderRadius.circular(30)),
                      child: Icon(
                        Icons.favorite,
                        size: 16,
                        color: liked
                            ? context.colorPalette.blackColor
                            : context.colorPalette.whiteColor,
                      ),
                    ),
                  )),
              Visibility(
                visible: focusCard,
                child: ClipRect(
                  clipBehavior: Clip.hardEdge,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      color:
                          context.colorPalette.backGroundColor.withOpacity(0.2),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: context.getScreenWidth(40),
                      height: context.getScreenHeight(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.movieData.movieTitle ?? "",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: context.textThemeDecoration.subTitleLarge),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(widget.movieData.language?.langName ?? '',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  context.textThemeDecoration.paragraphLarge),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: context.getScreenWidth(20),
                            alignment: Alignment.center,
                            height: context.getScreenHeight(4),
                            decoration: BoxDecoration(
                                color: context.colorPalette.backGroundColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Text(
                              widget.movieData.movieRating ?? '',
                              style: context.textThemeDecoration.subTitleSmall,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          CustomButton(
                            height: context.getScreenHeight(4),
                            text: 'Book Now',
                            textColor: context.colorPalette.darkGreyColor,
                            onTap: () {
                              widget.onPressEvent(context, widget.movieData);
                            },
                            width: context.getScreenWidth(26),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieListCard extends StatefulWidget {
  MovieModel movieData;
  void Function(BuildContext context, MovieModel movie) onPressEvent;

  MovieListCard(
      {super.key, required this.movieData, required this.onPressEvent});

  @override
  State<MovieListCard> createState() => _MovieListCardState();
}

class _MovieListCardState extends State<MovieListCard> {
  final double borderRadius = 10;
  bool focusCard = false;
  bool liked = false;

  @override
  void initState() {
    liked = widget.movieData.isMovieLiked!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String HeroName = widget.movieData.hashCode.toString();
    final cardWidth = context.getScreenWidth(100);
    final cardHeight = context.getScreenHeight(35);

    return GestureDetector(
      onTap: () {
        widget.onPressEvent(context, widget.movieData);
      },
      onLongPress: () {
        setState(() {
          focusCard = !focusCard;
        });
      },
      child: Container(
        width: cardWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: HeroName,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: CachedNetworkImage(
                      imageUrl: widget.movieData.movieImageUrl ?? '',
                      width: context.getScreenWidth(100),
                      height: context.getScreenHeight(20),
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) {
                        return Shimmer.fromColors(
                            baseColor: context.colorPalette.shimmerBaseColor,
                            highlightColor:
                                context.colorPalette.shimmerHighLightColor,
                            enabled: true,
                            child: Container(
                              color: context.colorPalette.accentColor,
                            ));
                      },
                      errorWidget: (context, url, error) => Image.asset(
                        ImageConstants.fallBackImage,
                        height: cardHeight,
                        width: cardWidth,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (widget.movieData.isAdvanceBookingAvailable == true) ...[
                    Positioned(
                      top: 10,
                      left: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        height: context.getScreenHeight(3),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: context.colorPalette.accentColor,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                        ),
                        child: Text(
                          "ADVANCE BOOKING",
                          style: context.textThemeDecoration.paragraphSmall
                              .copyWith(
                                  color: const Color(0xff000000),
                                  fontSize: 8,
                                  fontFamily:
                                      TextThemeDecoration.HamburgerFont),
                        ),
                      ),
                    ),
                  ],
                  Positioned(
                      bottom: 16,
                      right: 12,
                      child: InkWell(
                        onTap: () {
                          context
                              .read<AuthBloc>()
                              .add(AuthenticateUserEvent(onSuccess: () {
                                setState(() {
                                  liked = !liked;
                                });

                                context.read<MovieDetailsBloc>().add(
                                    LikeDislikeEvent(
                                        url: ApiUrlConstants.likeMovie,
                                        data: <String, dynamic>{
                                          "movieId":
                                              widget.movieData.vistaFilmId,
                                          "islikedMovie": liked
                                        },
                                        onFailure: (error) {},
                                        onSuccess: (data) {
                                          context.read<MoviesBloc>().add(
                                              LikeMovieEvent(
                                                  widget.movieData, liked));
                                        }));
                              }, onFailure: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        settings: const RouteSettings(
                                            name: RoutesName.loginScreen),
                                        builder: (context) {
                                          return LogInScreen(
                                              onLogin: (bool isLogin) {
                                            Navigator.popUntil(
                                                context,
                                                (route) =>
                                                    route.settings.name ==
                                                    RoutesName.mainSection);
                                          });
                                        }));
                              }));
                        },
                        child: Container(
                          width: context.getScreenWidth(8),
                          height: context.getScreenWidth(8),
                          decoration: BoxDecoration(
                              color: liked
                                  ? context.colorPalette.accentColor
                                  : context.colorPalette.whiteColor
                                      .withOpacity(0.6),
                              borderRadius: BorderRadius.circular(30)),
                          child: Icon(
                            Icons.favorite,
                            size: 16,
                            color: liked
                                ? context.colorPalette.blackColor
                                : context.colorPalette.whiteColor,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: context.getScreenHeight(1),
            ),
            Text(widget.movieData.movieTitle ?? "",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: context.textThemeDecoration.subTitleLarge
                    .copyWith(fontSize: 16)),
            SizedBox(
              height: context.getScreenHeight(1),
            ),
            SizedBox(
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.movieData.language?.langName ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: context.textThemeDecoration.subTitleMedium,
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: context.colorPalette.accentColor),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(widget.movieData.movieRating ?? '',
                          style: context.textThemeDecoration.subTitleLarge
                              .copyWith(
                                  color: context.colorPalette.accentColor)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: context.getScreenHeight(1.2),
            ),
            if (widget.movieData.experience!.isNotEmpty) ...[
              Container(
                padding: EdgeInsets.only(
                    left: context.getScreenWidth(4),
                    right: context.getScreenWidth(4),
                    top: context.getScreenHeight(1),
                    bottom: context.getScreenHeight(1)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    color: context.colorPalette.yellowBackground),
                child: Text(
                    widget.movieData.experience!
                        .map((experience) {
                          return experience.experienceName.toString();
                        })
                        .toList()
                        .join(', '),
                    style: context.textThemeDecoration.subTitleMedium.copyWith(
                        color: context.isDarkMode == true
                            ? context.colorPalette.accentColor
                            : context.colorPalette.darkGreyColor)),
              ),
            ],
            SizedBox(
              height: context.getScreenHeight(1.2),
            ),
            Text(
              widget.movieData.movieDescription ?? '',
              style: context.textThemeDecoration.paragraphLarge
                  .copyWith(fontSize: 14),
            ),
            SizedBox(
              height: context.getScreenHeight(2),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                    text: "Book Now",
                    textColor: context.colorPalette.blackColor,
                    onTap: () {
                      widget.onPressEvent(context, widget.movieData);
                    },
                    width: context.getScreenWidth(42),
                    height: 40),
                CustomButton(
                    text: "Trailer",
                    icon: ImageConstants.playButton,
                    iconSpacing: 10,
                    type: ButtonType.ICON_BUTTON,
                    onTap: () {
                      showDialog(
                        context: context,
                        useRootNavigator: false,
                        builder: (context) {
                          return YutubePlayerDialogBox(
                            title: widget.movieData.movieTitle,
                            trailerUrl:
                                'https://youtu.be/8oIsZEhnqtA?si=IQC1e3IklVgx3MN6',
                          );
                        },
                      );
                    },
                    backgroundColor: context.colorPalette.transparentColor,
                    borderColor:
                        Border.all(color: context.colorPalette.accentColor),
                    width: context.getScreenWidth(42),
                    height: 40)
              ],
            )
          ],
        ),
      ),
    );
  }
}
