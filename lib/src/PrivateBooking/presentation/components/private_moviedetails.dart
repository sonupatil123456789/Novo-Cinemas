import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novocinema/core/constants/ApiUrlConstants.dart';

import 'package:novocinema/src/MovieDetails/presentation/bloc/MovieDetailsBloc.dart';
import 'package:novocinema/src/MovieDetails/presentation/components/DateCard.dart';
import 'package:novocinema/src/MovieDetails/presentation/components/ExpendAccordian.dart';
import 'package:novocinema/src/MovieDetails/presentation/components/ShowDetails.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../components/TimeLanguageRating.dart';
import '../../../../components/YutubePlayerDilaogBox.dart';
import '../../../../components/shimmerloaders/MovieDetailsShimmer.dart';
import '../../../../core/constants/ImageConstants.dart';
import '../../../../core/constants/RoutesName.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/theams/Utils.dart';
import '../../../../entities/models/ShowTimeDetailsModel.dart';
import '../../../SeatLayout/presentation/screens/SeatLayoutScreen.dart';

class PrivateMovieDetailScreen extends StatefulWidget {
  final String movieId;
  final String imageUrl;

  const PrivateMovieDetailScreen(
      {super.key, required this.movieId, required this.imageUrl});

  @override
  State<PrivateMovieDetailScreen> createState() =>
      _PrivateMovieDetailScreenState();
}

class _PrivateMovieDetailScreenState extends State<PrivateMovieDetailScreen> {
  @override
  void initState() {
    // context.read<MovieDetailsBloc>().add(GetMovieDetailsEvent(
    //     movieId: widget.movieId, url: ApiUrlConstants.getPrivateSessions, sessionDate: '', pageType: null));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String HeroName = widget.movieId.toString();
    final BorderRadius borderRadius = BorderRadius.circular(12);

    return SingleChildScrollView(
        child: Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          width: context.getScreenWidth(100),
          height: context.getScreenHeight(36),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(borderRadius: borderRadius),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: Hero(
              tag: HeroName,
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl,
                width: context.getScreenWidth(100),
                height: context.getScreenHeight(36),
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
                  width: context.getScreenWidth(100),
                  height: context.getScreenHeight(36),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          buildWhen: (previous, current) =>
              previous.loading != current.loading ||
              previous.selectedTiming != current.selectedTiming ||
              previous.selectedDate != current.selectedDate,
          builder: (context, movieState) {
            if (movieState.loading == CurrentAppState.LOADING ||
                movieState.loading == CurrentAppState.INITIAL) {
              return const MovieDetailsShimmer();
            }
            if (movieState.loading == CurrentAppState.ERROR) {
              return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(movieState.appException!.message.toString()));
            }

            final showTimingListData =
                movieState.showTimeData.showTimesData?[movieState.selectedDate];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        movieState.movieDetails.movieTitle ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: context.textThemeDecoration.titleLarge,
                      )),
                      Container(
                        width: context.getScreenWidth(28),
                        height: context.getScreenHeight(4),
                        decoration: BoxDecoration(
                            color: context.colorPalette.cardBackgroundColor,
                            borderRadius: borderRadius),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              ImageConstants.filledStar,
                              width: 10,
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0, left: 7),
                              child: Text.rich(
                                TextSpan(
                                  style: context
                                      .textThemeDecoration.subTitleMedium,
                                  children: [
                                    TextSpan(
                                      text: '9/10',
                                      style: context
                                          .textThemeDecoration.subTitleSmall,
                                    ),
                                    TextSpan(
                                      text: 'Rating',
                                      style: context
                                          .textThemeDecoration.subTitleSmall
                                          .copyWith(
                                              fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TimeLanguageRating(
                    time: movieState.movieDetails.movieDuration ?? 0,
                    languages: movieState.movieDetails.language?.langName,
                    rating: movieState.movieDetails.movieRating ?? '',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: EdgeInsets.only(
                        left: context.getScreenWidth(4),
                        right: context.getScreenWidth(4),
                        top: context.getScreenHeight(1),
                        bottom: context.getScreenHeight(1)),
                    decoration: BoxDecoration(
                        borderRadius: borderRadius,
                        color: context.colorPalette.cardBackgroundColor),
                    child: Text(
                        movieState.movieDetails.experience!
                            .map((experience) {
                              return experience.experienceName.toString();
                            })
                            .toList()
                            .join(', '),
                        style: context.textThemeDecoration.subTitleMedium
                            .copyWith(
                                color: context.isDarkMode == true
                                    ? context.colorPalette.accentColor
                                    : context.colorPalette.darkGreyColor)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ExpendAccordian(
                  width: context.getScreenWidth(100),
                  height: context.getScreenHeight(6),
                  expandedHeight: context.getScreenHeight(80),
                  onTapHandler: () {},
                  movie: movieState.movieDetails,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    margin: const EdgeInsets.only(left: 20),
                    width: context.getScreenWidth(100),
                    height: context.getScreenHeight(8),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        // if (movieState.showTimeData.showTimesData?.entries !=
                          //   null)
                          // for (var date
                          //     in movieState.showTimeData.showTimesData!.entries)
                          //   DateCard(
                          //     date: date,
                          //     selectedDate: movieState.selectedDate,
                          //     onPressEvent: (String date) {
                          //       context
                          //           .read<MovieDetailsBloc>()
                          //           .add(OnDateSelectedEvent(date));
                          //     },
                          //   )
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),

                if (showTimingListData?.mallLocation?.entries != null)
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final showtimeEntry = showTimingListData!
                          .mallLocation!.entries
                          .toList()[index];

                      return ShowTimeDetails(
                        data: showtimeEntry,
                        onPressEvent: (ShowTimeDetailsModel selectedShowTime,
                            String mallName) {
                          context.read<MovieDetailsBloc>().add(
                                OnMallTimeSelectedEvent(
                                  showTime: selectedShowTime,
                                  mallName: mallName, callback: (ShowTimeDetailsModel selectedTiming) {  },
                                ),
                              );
                        },
                        selectedDate: movieState.selectedTiming,
                      );
                    },
                    itemCount: showTimingListData!.mallLocation!.entries
                        .toList()
                        .length,
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        height: 30,
                        color: context.colorPalette.reverseBackGroundColor,
                        thickness: 0.2,
                      );
                    },
                  )

                // if (showTimingListData?.mallLocation?.entries != null)
                //   for (var showtimeEntry in showTimingListData!.mallLocation!.entries)
                //     ShowTimeDetails(data: showtimeEntry, onPressEvent: (ShowTimeDetailsModel showTime) {
                //       context.read<MovieBloc>().add(OnTimeSelectedEvent(showTime));
                //     }, selectedDate: movieState.selectedTiming, ),

                // if (movieState.showTimeData.showTimesData?.entries != null)
                //   for (var dates in movieState.showTimeData.showTimesData!.entries)
                //
                //
                //     if (dates.value.mallLocation?.entries != null)
                //       for (var showtimeEntry in dates.value!.mallLocation!.entries)
                //         ShowTimeDetails(data: showtimeEntry),
              ],
            );
          },
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    ));
  }

  void navigateToSeatLayout(
      BuildContext context, MovieDetailsState movieState) {
    Navigator.pushNamedAndRemoveUntil(context, RoutesName.seatLayoutScreen,
        (route) => route.settings.name == RoutesName.movieDetailScreen,
        arguments: {
          'cinemaId': movieState.selectedTiming?.cinemaId.toString(),
          'sessionId': movieState.selectedTiming?.sessionId,
          'ShowTimeData': MovieSelectionType.MOVIE_DETAILS
        });
  }
}
