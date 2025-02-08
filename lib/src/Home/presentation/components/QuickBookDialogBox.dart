import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/core/utils/ListnerUtils.dart';
import 'package:novocinema/src/Home/domain/models/QuickBookCinemaModel.dart';
import 'package:novocinema/src/Home/domain/models/QuickBookMoviesModel.dart';
import '../../../../components/CustomButton.dart';
import '../../../../components/chips/CustomChoiceChips.dart';
import '../../../../core/constants/RoutesName.dart';
import '../../../Auth/presentation/bloc/AuthBloc.dart';
import '../../../Auth/presentation/screens/LoginScreen.dart';
import '../../../SeatLayout/presentation/screens/SeatLayoutScreen.dart';
import '../../domain/models/QuickBookSessionModel.dart';
import '../bloc/HomeBloc.dart';

class QuickBookDialogBox extends StatefulWidget {
  const QuickBookDialogBox({super.key});

  @override
  State<QuickBookDialogBox> createState() => _QuickBookDialogBoxState();
}

// Dialog
class _QuickBookDialogBoxState extends State<QuickBookDialogBox> {
  ChoiceChipData<QuickBookMoviesModel>? selectedMovie;
  ChoiceChipData<QuickBookCinemaModel>? selectedCinema;
  ChoiceChipData<MapEntry<String, List<QuickBookSessionModel>>>? selectedSessionDate;
  ChoiceChipData<QuickBookSessionModel>? selectedSessionTime;

  bool disableCinema = true;
  bool disableSessionDate = true;
  bool disableSessionTime = true;

  // ChoiceChipData<QuickBookMoviesModel>? selectedMovie;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: IntrinsicHeight(
        child: Container(
            width: context.getScreenWidth(80),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: context.colorPalette.backGroundColor,
                borderRadius: BorderRadius.circular(20)),
            child: BlocConsumer<HomeBloc, HomeState>(
              listener: (context, homeState) {
                if (homeState.quickBookData!.cinemas.isNotEmpty && selectedMovie != null) {
                  disableCinema = false;
                } else {
                  disableCinema = true;
                }
                if (homeState.quickBookData!.sessions.isNotEmpty &&
                    selectedMovie != null &&
                    selectedCinema != null) {
                  disableSessionDate = false;
                } else {
                  disableSessionDate = true;
                }
                if (homeState.quickBookData!.sessions.isNotEmpty &&
                    selectedMovie != null &&
                    selectedCinema != null &&
                    selectedSessionDate != null) {
                  disableSessionTime = false;
                } else {
                  disableSessionTime = true;
                }
                setState(() {});
              },
              builder: (context, homeState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Movies",
                      overflow: TextOverflow.ellipsis,
                      style: context.textThemeDecoration.titleSmall,
                    ),
                    SizedBox(
                      width: context.getScreenWidth(100),
                      child: IntrinsicWidth(
                        child: DropdownButton<ChoiceChipData<QuickBookMoviesModel>>(
                          value: selectedMovie,
                          menuMaxHeight: 200,
                          dropdownColor: context.colorPalette.backGroundColor,
                          iconEnabledColor: context.colorPalette.accentColor,
                          iconDisabledColor: context.colorPalette.darkGreyColor,
                          isExpanded: true,
                          items: homeState.quickBookData!.movies.map((value) {
                            ChoiceChipData<QuickBookMoviesModel> data =
                                ChoiceChipData(value.movieId ?? 0, value.movieTitle ?? "", value);
                            return DropdownMenuItem<ChoiceChipData<QuickBookMoviesModel>>(
                              value: data,
                              child: Text(value.movieTitle ?? ""),
                            );
                          }).toList(),
                          disabledHint:
                              dropDownHintText(hintText: 'Select a Movie', isDisabled: true),
                          hint: dropDownHintText(hintText: 'Select a Movie', isDisabled: false),
                          onTap: () {
                            setState(() {
                              selectedCinema = null;
                              selectedSessionDate = null;
                              selectedSessionTime = null;
                            });
                          },
                          onChanged: (ChoiceChipData<QuickBookMoviesModel>? selectedData) {
                            if (selectedData != null) {
                              setState(() {
                                selectedMovie = selectedData;
                              });
                              context
                                  .read<HomeBloc>()
                                  .add(SelectedQuickBookMovieEvent(selectedData));
                            }
                          },
                        ),
                      ),
                    ),
                    // CustomChoiceChips(
                    //   borderColor: context.isDarkMode
                    //       ? context.colorPalette.accentColor
                    //       : context.colorPalette.darkGreyColor,
                    //   bgColor: context.colorPalette.backGroundColor,
                    //   selectColor: context.colorPalette.accentColor,
                    //   selectItem: homeState.selectedQuickBookMovie,
                    //   checkColor: context.colorPalette.darkGreyColor,
                    //   selectedDataOnTap: (ChoiceChipData<QuickBookMoviesModel> selectedData) {
                    //     context.read<HomeBloc>().add(SelectedQuickBookMovieEvent(selectedData));
                    //   },
                    //   dataList: homeState.quickBookData!.movies
                    //       .map((toElement) => ChoiceChipData<QuickBookMoviesModel>(
                    //           toElement.movieId ?? 0, toElement.movieTitle ?? '', toElement))
                    //       .toList(),
                    //   width: context.getScreenHeight(100),
                    //   isWrapable: false,
                    //   textColor: context.colorPalette.darkGreyColor,
                    //   unSelectedTextColor: context.isDarkMode
                    //       ? context.colorPalette.accentColor
                    //       : context.colorPalette.darkGreyColor,
                    // ),
                    // if (homeState.quickBookData!.cinemas.isNotEmpty) ...[
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Select Cinema",
                      overflow: TextOverflow.ellipsis,
                      style: context.textThemeDecoration.titleSmall,
                    ),
                    SizedBox(
                      width: context.getScreenWidth(100),
                      child: IntrinsicWidth(
                        child: DropdownButton<ChoiceChipData<QuickBookCinemaModel>>(
                          value: selectedCinema,
                          menuMaxHeight: 200,
                          dropdownColor: context.colorPalette.backGroundColor,
                          iconEnabledColor: context.colorPalette.accentColor,
                          iconDisabledColor: context.colorPalette.darkGreyColor,
                          isExpanded: true,
                          items: homeState.quickBookData!.cinemas.map((value) {
                            ChoiceChipData<QuickBookCinemaModel> data =
                                ChoiceChipData(value.id ?? 0, value.name ?? "", value);
                            return DropdownMenuItem<ChoiceChipData<QuickBookCinemaModel>>(
                              value: data,
                              child: Text(value.name ?? ""),
                            );
                          }).toList(),
                          disabledHint:dropDownHintText(hintText: 'Select a Cinema', isDisabled: true),
                          hint: dropDownHintText(hintText: 'Select a Cinema', isDisabled: false),
                          onTap: () {
                            setState(() {
                              selectedSessionDate = null;
                              selectedSessionTime = null;
                            });
                          },
                          onChanged: disableCinema
                              ? null
                              : (ChoiceChipData<QuickBookCinemaModel>? selectedData) {
                                  if (selectedData != null) {
                                    setState(() {
                                      selectedCinema = selectedData;
                                    });
                                    context
                                        .read<HomeBloc>()
                                        .add(SelectedQuickBookCinemaEvent(selectedData));
                                  }
                                },
                        ),
                      ),
                    ),
                    // CustomChoiceChips(
                    //   borderColor: context.isDarkMode
                    //       ? context.colorPalette.accentColor
                    //       : context.colorPalette.darkGreyColor,
                    //   bgColor: context.colorPalette.backGroundColor,
                    //   selectColor: context.colorPalette.accentColor,
                    //   selectItem: homeState.selectedQuickBookCinema,
                    //   checkColor: context.colorPalette.darkGreyColor,
                    //   selectedDataOnTap: (ChoiceChipData<QuickBookCinemaModel> selectedData) {
                    //     context.read<HomeBloc>().add(SelectedQuickBookCinemaEvent(selectedData));
                    //   },
                    //   dataList: homeState.quickBookData!.cinemas
                    //       .map((toElement) => ChoiceChipData<QuickBookCinemaModel>(
                    //           toElement.id!, toElement.name!, toElement))
                    //       .toList(),
                    //   width: context.getScreenHeight(100),
                    //   isWrapable: false,
                    //   textColor: context.colorPalette.darkGreyColor,
                    //   unSelectedTextColor: context.isDarkMode
                    //       ? context.colorPalette.accentColor
                    //       : context.colorPalette.darkGreyColor,
                    // ),
                    // ],
                    // if (homeState.quickBookData!.sessions.isNotEmpty) ...[
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Select Date",
                      overflow: TextOverflow.ellipsis,
                      style: context.textThemeDecoration.titleSmall,
                    ),
                    SizedBox(
                      width: context.getScreenWidth(100),
                      child: IntrinsicWidth(
                        child: DropdownButton<
                            ChoiceChipData<MapEntry<String, List<QuickBookSessionModel>>>>(
                          value: selectedSessionDate,
                          menuMaxHeight: 200,
                          dropdownColor: context.colorPalette.backGroundColor,
                          iconEnabledColor: context.colorPalette.accentColor,
                          iconDisabledColor: context.colorPalette.darkGreyColor,
                          isExpanded: true,
                          items: homeState.quickBookData!.sessions.entries.map((value) {
                            ChoiceChipData<MapEntry<String, List<QuickBookSessionModel>>> data =
                                ChoiceChipData(0, value.key, value);
                            return DropdownMenuItem<
                                ChoiceChipData<MapEntry<String, List<QuickBookSessionModel>>>>(
                              value: data,
                              child: Text(value.key),
                            );
                          }).toList(),
                          disabledHint:
                              dropDownHintText(hintText: 'Select a Date', isDisabled: true),
                          hint: dropDownHintText(hintText: 'Select a Date', isDisabled: false),
                          onTap: () {
                            selectedSessionTime = null;
                          },
                          onChanged: disableSessionDate
                              ? null
                              : (ChoiceChipData<MapEntry<String, List<QuickBookSessionModel>>>?
                                  selectedData) {
                                  if (selectedData != null) {
                                    setState(() {
                                      selectedSessionDate = selectedData;
                                    });
                                    context
                                        .read<HomeBloc>()
                                        .add(SelectedQuickBookDateEvent(selectedData));
                                  }
                                },
                        ),
                      ),
                    ),
                    // CustomChoiceChips(
                    //   borderColor: context.isDarkMode
                    //       ? context.colorPalette.accentColor
                    //       : context.colorPalette.darkGreyColor,
                    //   bgColor: context.colorPalette.backGroundColor,
                    //   selectColor: context.colorPalette.accentColor,
                    //   selectItem: homeState.selectedQuickBookDate,
                    //   checkColor: context.colorPalette.darkGreyColor,
                    //   selectedDataOnTap:
                    //       (ChoiceChipData<MapEntry<String, List<QuickBookSessionModel>>>
                    //           selectedData) {
                    //     context.read<HomeBloc>().add(SelectedQuickBookDateEvent(selectedData));
                    //   },
                    //   dataList: homeState.quickBookData!.sessions.entries
                    //       .map((toElement) =>
                    //           ChoiceChipData<MapEntry<String, List<QuickBookSessionModel>>>(
                    //               0, toElement.key, toElement))
                    //       .toList(),
                    //   width: context.getScreenHeight(100),
                    //   isWrapable: false,
                    //   textColor: context.colorPalette.darkGreyColor,
                    //   unSelectedTextColor: context.isDarkMode
                    //       ? context.colorPalette.accentColor
                    //       : context.colorPalette.darkGreyColor,
                    // ),
                    // ],
                    // if (homeState.quickBookData!.sessions.isNotEmpty) ...[
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Select Time",
                      overflow: TextOverflow.ellipsis,
                      style: context.textThemeDecoration.titleSmall,
                    ),
                    SizedBox(
                      width: context.getScreenWidth(100),
                      child: IntrinsicWidth(
                        child: DropdownButton<ChoiceChipData<QuickBookSessionModel>>(
                          value: selectedSessionTime,
                          menuMaxHeight: 200,
                          dropdownColor: context.colorPalette.backGroundColor,
                          iconEnabledColor: context.colorPalette.accentColor,
                          iconDisabledColor: context.colorPalette.darkGreyColor,
                          isExpanded: true,
                          items: (homeState
                                  .quickBookData!.sessions[homeState.selectedQuickBookDate?.title])
                              ?.where((session) => session.sessionDisabled == false)
                              .map((value) {
                            ChoiceChipData<QuickBookSessionModel> data = ChoiceChipData(
                                value.cinemaId ?? 0, value.showTime.toString(), value);
                            return DropdownMenuItem<ChoiceChipData<QuickBookSessionModel>>(
                              value: data,
                              child: Text(value.showTime.toString()),
                            );
                          }).toList(),
                          disabledHint:
                              dropDownHintText(hintText: 'Select a Time Slot', isDisabled: true),
                          hint: dropDownHintText(hintText: 'Select a Time Slot', isDisabled: false),
                          onChanged: disableSessionTime
                              ? null
                              : (ChoiceChipData<QuickBookSessionModel>? selectedData) {
                                  if (selectedData != null) {
                                    setState(() {
                                      selectedSessionTime = selectedData;
                                    });
                                    context
                                        .read<HomeBloc>()
                                        .add(SelectedQuickBookTimeEvent(selectedData));
                                  }
                                },
                        ),
                      ),
                    ),
                    // CustomChoiceChips(
                    //   borderColor: context.isDarkMode
                    //       ? context.colorPalette.accentColor
                    //       : context.colorPalette.darkGreyColor,
                    //   bgColor: context.colorPalette.backGroundColor,
                    //   selectColor: context.colorPalette.accentColor,
                    //   selectItem: homeState.selectedQuickBookTime,
                    //   checkColor: context.colorPalette.darkGreyColor,
                    //   selectedDataOnTap: (ChoiceChipData<QuickBookSessionModel> selectedData) {
                    //     context.read<HomeBloc>().add(SelectedQuickBookTimeEvent(selectedData));
                    //   },
                    //   dataList: (homeState
                    //               .quickBookData!.sessions[homeState.selectedQuickBookDate?.title])
                    //           ?.where((session) => session.sessionDisabled == false)
                    //           .map((toElement) => ChoiceChipData<QuickBookSessionModel>(
                    //               toElement.cinemaId!, toElement.showTime.toString(), toElement))
                    //           .toList() ??
                    //       [],
                    //   width: context.getScreenHeight(100),
                    //   isWrapable: false,
                    //   textColor: context.colorPalette.darkGreyColor,
                    //   unSelectedTextColor: context.isDarkMode
                    //       ? context.colorPalette.accentColor
                    //       : context.colorPalette.darkGreyColor,
                    // ),
                    // ],
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          height: context.getScreenHeight(5),
                          backgroundColor: context.colorPalette.transparentColor,
                          text: 'Clear',
                          textColor: context.colorPalette.accentColor,
                          onTap: () async {
                            context.read<HomeBloc>().add(const ClearQuickBookEvent());
                            setState(() {
                              selectedMovie = null;
                              selectedCinema = null;
                              selectedSessionDate = null;
                              selectedSessionTime = null;
                            });
                            // Navigator.pop(context);
                          },
                          borderColor:
                              Border.all(color: context.colorPalette.accentColor, width: 2.0),
                          width: context.getScreenWidth(20),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CustomButton(
                          height: context.getScreenHeight(5),
                          backgroundColor: context.colorPalette.accentColor,
                          text: 'Book Now',
                          textColor: context.colorPalette.darkGreyColor,
                          onTap: () {
                            if (homeState.selectedQuickBookTime?.data != null &&
                                homeState.selectedQuickBookTime?.data !=
                                    const QuickBookSessionModel()) {
                              context.read<AuthBloc>().add(AuthenticateUserEvent(onSuccess: () {
                                    navigateToSeatLayout(context, homeState, false);
                                  }, onFailure: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            settings:
                                                const RouteSettings(name: RoutesName.loginScreen),
                                            builder: (context) {
                                              return LogInScreen(onLogin: (bool isLogin) {
                                                navigateToSeatLayout(context, homeState, true);
                                              });
                                            }));
                                  }));
                            } else {
                              ListnersUtils.showErrorMessage(
                                  'Please select all the field', 'Booking Error', context);
                            }
                          },
                          width: context.getScreenWidth(30),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    )
                  ],
                );
              },
            )),
      ),
    );
  }

  Widget dropDownHintText({required String hintText, required bool isDisabled}) {
    return Text(
      hintText,
      style: TextStyle(
        color: isDisabled
            ? context.isDarkMode
                ? context.colorPalette.darkGreyColor
                : context.colorPalette.lightGreyColor
            : context.isDarkMode
                ? context.colorPalette.accentColor
                : context.colorPalette.darkGreyColor,
      ),
    );
  }

  void navigateToSeatLayout(BuildContext context, HomeState homeState, bool removeLoginScreen) {
    if (removeLoginScreen == true) {
      Navigator.pushNamedAndRemoveUntil(context, RoutesName.seatLayoutScreen,
          (route) => route.settings.name == RoutesName.mainSection,
          arguments: {
            'cinemaId': homeState.selectedQuickBookTime?.data?.cinemaId.toString() ?? '',
            'sessionId': homeState.selectedQuickBookTime?.data?.sessionId.toString() ?? '',
            'ShowTimeData': MovieSelectionType.QUICK_BOOK
          });
    } else {
      Navigator.popAndPushNamed(context, RoutesName.seatLayoutScreen, arguments: {
        'cinemaId': homeState.selectedQuickBookTime?.data?.cinemaId.toString() ?? '',
        'sessionId': homeState.selectedQuickBookTime?.data?.sessionId.toString() ?? '',
        'ShowTimeData': MovieSelectionType.QUICK_BOOK
      });
    }
  }
}
