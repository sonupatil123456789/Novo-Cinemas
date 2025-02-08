import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:novocinema/components/chips/CustomChoiceChips.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/Home/domain/models/QuickBookSessionModel.dart';
import 'package:novocinema/src/Home/presentation/bloc/HomeBloc.dart';
import 'package:novocinema/src/ShowTime/presentation/bloc/ShowTimeBloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../components/cards/SeatMovieDetailCardDetails.dart';

import '../../../MovieDetails/presentation/bloc/MovieDetailsBloc.dart';
import '../bloc/SeatLayoutBloc.dart';
import '../screens/SeatLayoutScreen.dart';

class ChangeMovieDateTime extends StatefulWidget {
  final MovieSelectionType showTimeData;
  const ChangeMovieDateTime({super.key, required this.showTimeData});

  @override
  State<ChangeMovieDateTime> createState() => _ChangeMovieDateTimeState();
}

class _ChangeMovieDateTimeState extends State<ChangeMovieDateTime> {







  @override
  Widget build(BuildContext context) {

    Widget loadingList (BuildContext context)  => Container(
      height: context.getScreenHeight(5.6),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return Shimmer.fromColors(
            baseColor: context.colorPalette.shimmerBaseColor,
            highlightColor: context.colorPalette.shimmerHighLightColor,
            enabled: true,
            child: Container(
              width: context.getScreenWidth(25),
              margin: EdgeInsets.only(right: context.getScreenWidth(4.5),),
              height: context.getScreenHeight(2),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: context.colorPalette.cardBackgroundColor,),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 10,
          );
        },
      ),
    );


    final isDarkMode = context.isDarkMode;

    if (widget.showTimeData == MovieSelectionType.QUICK_BOOK) {
      return BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            previous.quickBookState != current.quickBookState ||
            previous.selectedQuickBookTime != current.selectedQuickBookTime ||
            previous.selectedQuickBookDate != current.selectedQuickBookDate,
        builder: (context, homeState) {
          final movieDetails = (homeState.selectedQuickBookMovie?.data);

          final timeList = (homeState.quickBookData!
                  .sessions[homeState.selectedQuickBookDate?.title])
              ?.where((session) => session.sessionDisabled == false)
              .toList();

          // .where((session)=>session.sessionDisabled == false)

          return SeatMovieDetailsCardDetails(
            // movieImage: movieDetails?.movieImageUrl,
            movieDate: homeState.selectedQuickBookDate?.title,
            movieName: movieDetails?.movieTitle,
            movieTime: homeState.selectedQuickBookTime?.title,
            movieMallName: homeState.selectedQuickBookCinema?.title,
            selectTimeListComponent: Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: timeList?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  final timingData = timeList![index];
                  final isSelected = ChoiceChipData<QuickBookSessionModel>(
                      timingData.cinemaId!,
                      timingData.showTime.toString(),
                      timingData);

                  return timeCard(
                      context: context,
                      onClick: () {
                        context.read<HomeBloc>().add(
                                BuildSeatLayoutOnQuickBookTimeSelectedEvent( isSelected, (sessionId, cinemaId) {
                              context.read<SeatLayoutBloc>().add(const ClearSeatStateEvent());
                              context.read<SeatLayoutBloc>().add(GetSeatLayoutEvent(sessionId, cinemaId));
                            }));
                      },
                      isDisable:
                          timingData.sessionDisabled == true ? true : false,
                      selected: homeState.selectedQuickBookTime == isSelected ? true: false,
                      text: timingData.showTime,
                      isDarkMode: isDarkMode);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
              ),
            ), showTimeData: widget.showTimeData,
          );
        },
      );
    }

    if (widget.showTimeData == MovieSelectionType.SHOW_TIME) {
      return BlocBuilder<ShowTimeBloc, ShowTimeState>(
        buildWhen: (previous, current) => previous.selectedDate != current.selectedDate ||previous.selectedTiming != current.selectedTiming,
        builder: (context, showTimeState) {
          final movieDetails = (showTimeState.movieDetail);


          return SeatMovieDetailsCardDetails(
            // movieImage: movieDetails?.movieImageUrl,
            movieDate: showTimeState.selectedDate,
            movieName: movieDetails.movieTitle,
            movieTime: showTimeState.selectedTiming?.showTime,
            movieMallName: showTimeState.selectedMallName,
            selectTimeListComponent: Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: movieDetails.sessions?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  final timingData = movieDetails.sessions?[index] ;


                  return timeCard(
                      context: context,
                      onClick: () {
                        context.read<ShowTimeBloc>().add(
                            BuildSeatLayoutOnShowTimeSelectedEvent(timingData, (sessionId, cinemaId) {
                              context.read<SeatLayoutBloc>().add(const ClearSeatStateEvent());
                              context.read<SeatLayoutBloc>().add(GetSeatLayoutEvent(sessionId, cinemaId));
                            }));
                      },
                      isDisable: timingData!.sessionDisabled == true ? true : false,
                      selected: showTimeState.selectedTiming == timingData ? true: false,
                      text: timingData.showTime,
                      isDarkMode: isDarkMode);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
              ),
            ), showTimeData: widget.showTimeData,
          );
        },
      );
    }

    else {
      return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        buildWhen: (previous, current) =>previous.loading != current.loading ||previous.selectedTiming != current.selectedTiming ||
            previous.selectedDate != current.selectedDate || current.showTimeDataState != previous.showTimeDataState,
        builder: (context, movieDetailsState) {
          final showTimingListData = movieDetailsState
              .showTimeData.showTimesData?[movieDetailsState.selectedDate];
          final mallLocation = showTimingListData?.mallLocation?[movieDetailsState.selectedMallName]?.where((session) => session.sessionDisabled == false) .toList();

          return SeatMovieDetailsCardDetails(
            // movieImage: movieDetailsState.movieDetails.movieImageUrl,
            movieDate: movieDetailsState.selectedDate,
            movieName: movieDetailsState.movieDetails.movieTitle,
            movieTime: movieDetailsState.selectedTiming?.showTime,
            selectTimeListComponent: Expanded(
              child: movieDetailsState.showTimeDataState==CurrentAppState.LOADING ? loadingList(context): ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: mallLocation?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  final timingData = mallLocation?[index];
                  return timeCard(
                      context: context,
                      onClick: () {
                        context.read<MovieDetailsBloc>().add(BuildSeatLayoutOnTimeSelectedEvent(timingData!, (sessionId, cinemaId) {
                              context.read<SeatLayoutBloc>().add(const ClearSeatStateEvent());
                              context.read<SeatLayoutBloc>() .add(GetSeatLayoutEvent(sessionId, cinemaId));
                            }));
                      },
                      isDisable: timingData!.sessionDisabled == true ? true : false,
                      selected: movieDetailsState.selectedTiming == timingData
                          ? true
                          : false,
                      text: timingData.showTime,
                      isDarkMode: isDarkMode);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
              ),
            ),
            movieMallName: movieDetailsState.selectedMallName,  showTimeData: widget.showTimeData,
          );
        },
      );
    }
  }
}

Widget timeCard<T>(
    {required BuildContext context,
    required Function onClick,
    required bool isDisable,
    required bool selected,
    required String? text,
    required bool isDarkMode}) {
  return IgnorePointer(
    ignoring: isDisable,
    child: GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: selected == true
              ? context.colorPalette.accentColor
              : isDisable == true
                  ? context.colorPalette.accentColor.withOpacity(0.2)
                  : null,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                  width: 1,
                  color: context.isDarkMode || selected == true ? context.colorPalette.accentColor.withOpacity(0.2)  :context.colorPalette.darkGreyColor)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(text ?? '',
            style: context.textThemeDecoration.subTitleSmall.copyWith(
                // color: getTextColor(selected,isDisable,context)
                color: selected == true && isDarkMode
                    ? context.colorPalette.blackColor
                    : isDisable == true
                        ? context.colorPalette.disabledColor
                        : context.colorPalette.textColor)),
      ),
    ),
  );
}










// CoustomIconDropDown<MallLocationModel>(
// borderColor: context.colorPalette.accentColor,
// bgColor: context.colorPalette.backGroundColor,
// selectItem: DropDownItemData(showTimingListData!, movieState.selectedDate.toString(),movieState.selectedDate),
// dataList: movieState.showTimeData.showTimesData!.keys.map((data)=>  DropDownItemData(showTimingListData,data.toString(),data)).toList(),
// width: context.getScreenHeight(15),
// textColor: context.isDarkMode ? context.colorPalette.accentColor :context.colorPalette.darkGreyColor,
// height: context.getScreenHeight(5),
// selectedDataOnTap: (DropDownItemData selectedItem ,MallLocationModel data ) {
// context.read<MovieBloc>().add(OnDateSelectedEvent(selectedItem.title));
// }, icon:  Icon(Icons.date_range,color: context.isDarkMode ? context.colorPalette.accentColor :context.colorPalette.darkGreyColor,),
// selectedTextColor: context.colorPalette.darkGreyColor,
// selectedDropdownColor: context.colorPalette.accentColor,
// ),
