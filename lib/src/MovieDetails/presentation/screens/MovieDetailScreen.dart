import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novocinema/src/Auth/presentation/bloc/AuthBloc.dart';
import 'package:novocinema/src/Auth/presentation/screens/LoginScreen.dart';
import 'package:novocinema/src/MovieDetails/presentation/bloc/MovieDetailsBloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/CustomButton.dart';
import '../../../../components/TimeLanguageRating.dart';
import '../../../../components/YutubePlayerDilaogBox.dart';
import '../../../../components/shimmerloaders/MovieDetailsShimmer.dart';
import '../../../../core/constants/ImageConstants.dart';
import '../../../../core/constants/RoutesName.dart';
import '../../../../core/nativeServices/DeepLinkServices.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/theams/Utils.dart';
import '../../../SeatLayout/presentation/screens/SeatLayoutScreen.dart';
import '../../../../entities/models/ShowTimeDetailsModel.dart';
import '../components/DateCard.dart';
import '../components/ExpendAccordian.dart';
import '../components/ShowDetails.dart';

class MovieDetailScreen extends StatefulWidget {
  final String movieId;
  final String imageUrl;
  final bool isDeepLinking;
  final String? url;

  const MovieDetailScreen({super.key, required this.movieId, required this.imageUrl, required this.isDeepLinking, this.url});


  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {


  bool toggleExpandable = false ;

  @override
  void initState() {
    context
        .read<MovieDetailsBloc>()
        .add(GetMovieDetailsEvent(movieId: widget.movieId, pageType: DetailPageType.BOOKING_FLOW,));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {



    final String HeroName = widget.movieId.toString();
    final BorderRadius borderRadius = BorderRadius.circular(12);

    return ArtBoard(
      header: BackButtonNavBar(
          center: SizedBox(
            height: double.infinity,
            // color: Colors.green,
            child: Row(
              children: [
                Text('Movie Details', style: context.textThemeDecoration.titleSmall.copyWith(
                    fontWeight: FontWeight.bold
                ),),
                const Spacer(),
                BlocBuilder<MovieDetailsBloc,MovieDetailsState>(builder: (BuildContext context, movieDetailState) {
                  return IgnorePointer(
                    ignoring:movieDetailState.loading== CurrentAppState.SUCCESS ? false :true ,
                    child: GestureDetector(
                      onTap: () {
                        DeepLinkServices.shareDeepLink(title:movieDetailState.movieDetails.movieTitle ?? '' ,
                            discription: movieDetailState.movieDetails.movieDescription ?? '',
                            data: BranchContentMetaData()
                              ..addCustomMetadata(MOVIE_KEY, widget.movieId)
                              ..addCustomMetadata(MOVIE_IMAGE_URL, widget.imageUrl)
                        );
                      },
                      child:  Icon(Icons.share,size: context.getScreenWidth(4.5),),
                    ),
                  );

                },),

                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          onBackPress: () {
            context.read<MovieDetailsBloc>().add(const ClearSessionStateEvent());

            if(widget.isDeepLinking){
              Navigator.pushNamedAndRemoveUntil(context, RoutesName.mainSection, (route) => false);
            }else {
              Navigator.pop(context);
            }
          }),
      body: PopScope(
        onPopInvokedWithResult: (didPop, result) {
          context.read<MovieDetailsBloc>().add(const ClearSessionStateEvent());
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: context.getScreenWidth(100),
                  height: context.getScreenHeight(20),
                  decoration: BoxDecoration(borderRadius: borderRadius),
                  child: ClipRRect(
                    borderRadius: borderRadius,
                    child: Hero(
                      tag: HeroName,
                      child: CachedNetworkImage(
                        imageUrl: widget.imageUrl,
                        width: context.getScreenWidth(100),
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                         return  Shimmer.fromColors(
                            baseColor: context.colorPalette.shimmerBaseColor,
                            highlightColor: context.colorPalette.shimmerHighLightColor,
                            enabled: true,
                            child: Container(
                              decoration: BoxDecoration(borderRadius: borderRadius,color: context.colorPalette.cardBackgroundColor,),
                            ),
                          );
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
                  buildWhen: (previous, current) =>previous.loading != current.loading ||previous.selectedTiming != current.selectedTiming || previous.selectedDate != current.selectedDate || current.selectedMallName != previous.selectedMallName,
                  builder: (context, movieState) {
                      // return const MovieDetailsShimmer();


                    if (movieState.loading == CurrentAppState.LOADING || movieState.loading == CurrentAppState.INITIAL) {
                      return const MovieDetailsShimmer();
                    }
                    if (movieState.loading == CurrentAppState.ERROR ||movieState.showTimeDataState == CurrentAppState.ERROR ) {
                      return Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(movieState.appException!.message.toString()));
                    }



                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
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
                                    color:
                                        context.colorPalette.cardBackgroundColor,
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
                                      padding:
                                          const EdgeInsets.only(top: 0, left: 7),
                                      child: Text.rich(
                                        TextSpan(
                                          style: context.textThemeDecoration.subTitleMedium,
                                          children: [
                                            TextSpan(
                                              text: '9/10',
                                              style: context.textThemeDecoration.subTitleSmall,
                                            ),
                                            TextSpan(
                                              text: 'Rating',
                                              style: context.textThemeDecoration
                                                  .subTitleSmall.copyWith(fontWeight:FontWeight.w400),
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
                        TimeLanguageRating(
                          time: movieState.movieDetails.movieDuration ?? 0,
                          languages: movieState.movieDetails.language?.langName,
                          rating: movieState.movieDetails.movieRating ?? '',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
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
                              }).toList().join(', '),
                              style: context.textThemeDecoration.subTitleMedium.copyWith( color: context.isDarkMode == true ? context.colorPalette.accentColor: context.colorPalette.darkGreyColor)),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        StatefulBuilder(
                          builder: (context, setMovieState) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomButton(
                                      height: context.getScreenHeight(6),
                                      backgroundColor:
                                      context.colorPalette.transparentColor,
                                      iconSpacing: 10,
                                      text: 'Trailer',
                                      textColor: context.colorPalette.accentColor,
                                      onTap: () async {
                                        showDialog(
                                          context: context,
                                          useRootNavigator: false,
                                          builder: (context) {
                                            return YutubePlayerDialogBox(
                                              title: movieState.movieDetails.movieTitle,
                                              trailerUrl:'https://youtu.be/8oIsZEhnqtA?si=IQC1e3IklVgx3MN6',
                                            );
                                          },
                                        );
                                      },
                                      borderColor: Border.all(color: context.colorPalette.accentColor.withOpacity(0.5),  width: 1.0),
                                      width: context.getScreenWidth(30),
                                      type: ButtonType.ICON_BUTTON,
                                      icon: ImageConstants.playButton,
                                    ),
                                    CustomButton(
                                        text: "Movie Details",
                                        textColor: context.colorPalette.blackColor,
                                        onTap: () {
                                          setMovieState(() {
                                            toggleExpandable = !toggleExpandable;
                                          });
                                        },
                                        width: context.getScreenWidth(50),
                                        height: context.getScreenHeight(6)),
                                  ],
                                ),

                                Visibility(
                                  visible :toggleExpandable ,
                                  child: ExpendAccordian(
                                    width:  context.getScreenWidth(100),
                                    height: context.getScreenHeight(6),
                                    expandedHeight: context.getScreenHeight(80),
                                    onTapHandler: () {},
                                    movie: movieState.movieDetails,
                                  ),
                                )



                              ],
                            );
                          }
                        ),
                        const SizedBox(
                          height: 15,
                        ),


                        SizedBox(
                            width: context.getScreenWidth(100),
                            height: context.getScreenHeight(8),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,

                              itemBuilder: (BuildContext context, int index) {
                                final date = movieState.showTimeDateList![index];
                                return  DateCard(
                                  date: date,
                                  selectedDate: movieState.selectedDate,
                                  onPressEvent: (String date) {
                                    context.read<MovieDetailsBloc>().add(OnDateSelectedEvent(date));
                                    context.read<MovieDetailsBloc>().add(GetMovieSessionEvent(
                                        movieId: widget.movieId,
                                        pageType: DetailPageType.BOOKING_FLOW,
                                        sessionDate: date));
                                  },
                                );

                              },
                              itemCount: movieState.showTimeDateList?.length ?? 0,
                            )),

                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),

                BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
                  builder: (BuildContext context,  movieState) {
                    // return  sessionShimmer(context, borderRadius);

                  if(movieState.showTimeDataState == CurrentAppState.LOADING||movieState.showTimeDataState == CurrentAppState.INITIAL ){
                      return  sessionShimmer(context, borderRadius);
                  }else{
                    final showTimingListData = movieState.showTimeData.showTimesData?[movieState.selectedDate];
                    if (showTimingListData?.mallLocation?.entries !=null) {
                      return  ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final showtimeEntry = showTimingListData!
                              .mallLocation!.entries.toList()[index];

                          return ShowTimeDetails(
                            data: showtimeEntry,
                            onPressEvent: (
                                ShowTimeDetailsModel selectedShowTime,
                                String mallName) {
                              context.read<MovieDetailsBloc>().add(
                                  OnMallTimeSelectedEvent(
                                    showTime: selectedShowTime,
                                    mallName: mallName,
                                    callback: (selectedTiming) {
                                      context.read<AuthBloc>().add(
                                          AuthenticateUserEvent(
                                              onSuccess: () {
                                                navigateToSeatLayout(context, selectedTiming);
                                              }, onFailure: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    settings: const RouteSettings( name: RoutesName.loginScreen),
                                                    builder: (context) {
                                                      return LogInScreen( onLogin: ( bool isLogin) {
                                                            navigateToSeatLayout(context, selectedTiming);
                                                          });
                                                    }));
                                          }));
                                    },
                                  ));
                            },
                            selectedDate: movieState.selectedTiming,
                          );
                        },
                        itemCount: showTimingListData!.mallLocation!.entries.toList() .length,
                        shrinkWrap: true,
                        separatorBuilder: (BuildContext context,
                            int index) {
                          return Divider(
                            height: 30,
                            color: context.colorPalette.reverseBackGroundColor,
                            thickness: 0.2,
                          );
                        },
                      );
                    }
                    else {
                      return const SizedBox.shrink();
                    }
                  }
                },),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateToSeatLayout(BuildContext context, ShowTimeDetailsModel selectedTiming) {
    Navigator.pushNamedAndRemoveUntil(context, RoutesName.seatLayoutScreen,
        (route) => route.settings.name == RoutesName.movieDetailScreen,
        arguments: {
          'cinemaId': selectedTiming?.cinemaId.toString(),
          'sessionId': selectedTiming?.sessionId,
          'ShowTimeData': MovieSelectionType.MOVIE_DETAILS
        });
  }
}
