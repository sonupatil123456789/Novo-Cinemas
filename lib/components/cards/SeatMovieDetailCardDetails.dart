import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/Home/presentation/bloc/HomeBloc.dart';
import 'package:novocinema/src/MovieDetails/presentation/bloc/MovieDetailsBloc.dart';
import 'package:novocinema/src/MovieDetails/presentation/bloc/MovieDetailsBloc.dart' as movieDetailBloc;
import 'package:novocinema/src/ShowTime/presentation/bloc/ShowTimeBloc.dart' as showTimeBloc;
import '../../core/constants/ImageConstants.dart';
import '../../core/theams/TextTheamStyle.dart';
import '../../core/utils/DateFormater.dart';
import '../../src/MovieDetails/domain/models/MallLocationModel.dart';
import '../../src/SeatLayout/presentation/screens/SeatLayoutScreen.dart';
import '../../src/ShowTime/domain/models/ShowTimeMallLocationModel.dart';
import '../../src/ShowTime/presentation/bloc/ShowTimeBloc.dart';
import '../dropdown/coustom_icon_dropdown.dart';

class SeatMovieDetailsCardDetails extends StatelessWidget {
  String? movieName;
  MovieSelectionType showTimeData;

  String? movieMallName;
  String? movieDate;
  String? movieTime;
  Widget selectTimeListComponent;

  SeatMovieDetailsCardDetails(
      {super.key,
      // required this.movieImage,
      required this.showTimeData,
      required this.movieDate,
      required this.movieName,
      required this.movieTime,
      required this.selectTimeListComponent,
      required this.movieMallName});

  String getFormatedDate(movieDate) {
    return "${getDay(movieDate ?? '')} ${getMonth(movieDate ?? '').substring(0, 3)}";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: SizedBox(
        height: context.getScreenHeight(5.6),
        child: Row(
          children: [
            // context.read<MovieDetailsBloc>().add(OnDateSelectedEvent(date));

            if (showTimeData == MovieSelectionType.MOVIE_DETAILS) ...[
              BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
                builder: (context, movieDetailState) {
                  return CoustomIconDropDown<String>(
                    borderColor: context.colorPalette.transparentColor,
                    bgColor: context.colorPalette.transparentColor,
                    width: context.getScreenWidth(23),
                    itemWidth: context.getScreenWidth(24),
                    textColor: context.colorPalette.textColor,
                    height: context.getScreenHeight(6),
                    paddingValue: 0,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 15,
                      color: context.isDarkMode
                          ? context.colorPalette.accentColor
                          : context.colorPalette.darkGreyColor,
                    ),
                    selectedTextColor: context.colorPalette.darkGreyColor,
                    selectedDropdownColor: context.colorPalette.accentColor,
                    dataList: movieDetailState.showTimeDateList!.map((value) => DropDownItemData<String>( value, getFormatedDate(value), value)).toList(),
                    unSelectedTextColor:
                    context.colorPalette.textColor.withOpacity(0.6),
                    placeHolder: 'Select Your Nationality',
                    selectItem: DropDownItemData<String>(movieDetailState.selectedDate!, movieDetailState.selectedDate!, movieDetailState.selectedDate),
                    customWidget: (data) {
                      return SizedBox(
                        // width: context.getScreenWidth(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(getWeek(movieDate ?? ''),
                                style: context.textThemeDecoration.subTitleSmall),
                            Text(
                                "${getDay(movieDate ?? '')} ${getMonth(movieDate ?? '').substring(0, 3)}",
                                style: context.textThemeDecoration.subTitleLarge),
                          ],
                        ),
                      );
                    }, selectedDataOnTap: (DropDownItemData<String> dropDownData , String data ) {
                    context.read<MovieDetailsBloc>().add(movieDetailBloc.OnDateSelectedEvent(data));
                    context.read<MovieDetailsBloc>().add(GetMovieSessionEvent(movieId: movieDetailState.movieDetails.movieId.toString(), pageType: DetailPageType.BOOKING_FLOW, sessionDate: data)
                    );

                  },

                  );
                },
              )
            ]

            else if (showTimeData == MovieSelectionType.SHOW_TIME) ...[
              BlocBuilder<ShowTimeBloc, ShowTimeState>(
                builder: (context, showTimeState) {
                  return CoustomIconDropDown<MapEntry<String, ShowTimeMallLocationModel>>(
                    borderColor: context.colorPalette.transparentColor,
                    bgColor: context.colorPalette.transparentColor,
                    width: context.getScreenWidth(23),
                    itemWidth: context.getScreenWidth(24),
                    textColor: context.colorPalette.textColor,
                    height: context.getScreenHeight(6),
                    paddingValue: 0,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 15,
                      color: context.isDarkMode
                          ? context.colorPalette.accentColor
                          : context.colorPalette.darkGreyColor,
                    ),
                    selectedTextColor: context.colorPalette.darkGreyColor,
                    selectedDropdownColor: context.colorPalette.accentColor,
                    dataList: showTimeState.showTimeData.showTimesData?.entries
                        .map((value) => DropDownItemData(
                        value, getFormatedDate(value.key), value.key))
                        .toList() ?? [],
                    unSelectedTextColor:
                    context.colorPalette.textColor.withOpacity(0.6),
                    placeHolder: 'Select Your Nationality',
                    selectItem: null,
                    customWidget: (data) {
                      return SizedBox(
                        // width: context.getScreenWidth(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(getWeek(movieDate ?? ''),
                                style: context.textThemeDecoration.subTitleSmall),
                            Text(
                                "${getDay(movieDate ?? '')} ${getMonth(movieDate ?? '').substring(0, 3)}",
                                style: context.textThemeDecoration.subTitleLarge),
                          ],
                        ),
                      );
                    }, selectedDataOnTap: ( DropDownItemData<MapEntry<String, ShowTimeMallLocationModel>> dropDownData,MapEntry<String, ShowTimeMallLocationModel> data) {
                      context.read<ShowTimeBloc>().add(showTimeBloc.OnDateSelectedEvent(data.key));
                  },

                  );
                },
              )
            ]

            else ...[],

            // SizedBox(
            //   width: context.getScreenWidth(19),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(getWeek(movieDate ?? ''),
            //           style: context.textThemeDecoration.subTitleSmall),
            //       Text(
            //           "${getDay(movieDate ?? '')} ${getMonth(movieDate ?? '').substring(0, 3)}",
            //           style: context.textThemeDecoration.subTitleLarge),
            //     ],
            //   ),
            // ),
            const SizedBox(
              width: 10,
            ),
            selectTimeListComponent
          ],
        ),
      ),
    );
  }
}
