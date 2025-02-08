import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/core/utils/DateFormater.dart';
import 'package:novocinema/core/utils/ListnerUtils.dart';
import 'package:novocinema/src/DirectFnB/presentation/bloc/DirectF&BBloc.dart';
import 'package:novocinema/src/DirectFnB/presentation/components/ConfirmBookingPopup.dart';
import 'package:novocinema/src/DirectFnB/presentation/components/UpcomingBookingCard.dart';
import '../../../../components/CustomButton.dart';
import '../../../../components/CustomTextField.dart';
import '../../../../components/shimmerloaders/UpcomingBookingShimmer.dart';
import '../../../../core/constants/ApiUrlConstants.dart';
import '../../../../core/constants/DatabaseKeyConstants.dart';
import '../../../../core/constants/RoutesName.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/SeassionManager.dart';
import '../../../Auth/presentation/bloc/AuthBloc.dart';
import '../../../Auth/presentation/screens/LoginScreen.dart';
import '../../../F&B/presentation/screens/FAndBScreen.dart';

class DirectFnbBookingScreen extends StatefulWidget {
  final FAndBType fAndBType;

  const DirectFnbBookingScreen({super.key, required this.fAndBType});

  @override
  State<DirectFnbBookingScreen> createState() => _DirectFnbBookingScreenState();
}

class _DirectFnbBookingScreenState extends State<DirectFnbBookingScreen> {
  late final SeassionManager session;
  bool isUserLoggedIn = false;
  TextEditingController bookingID = TextEditingController();

  void _getUpcomingDataOnAuth(BuildContext context) async {
    isUserLoggedIn = await SeassionManager().getAccessToken(TOKEN) != null ? true : false;
    setState(() {});
    if (isUserLoggedIn) {
      context.read<DirectFAndBBloc>().add(const GetAllUpcomingBookingsEvent());
    }
  }

  void _getUpcomingBookingDetails(BuildContext context) {
    context.read<DirectFAndBBloc>().add(const OnBookingIdError(''));
    context
        .read<DirectFAndBBloc>()
        .add(GetUpcomingBookingsDetailsEvent(onSuccess: (upcomingBooking) {
          if (upcomingBooking.showDateTime != null) {
            if (isDateTimeBeforeToday(upcomingBooking.showDateTime.toString())) {
              context.read<DirectFAndBBloc>().add(OnBookingIdError(context.language.getText('enterBookingIdForUpcomingBookings')));
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return ConfirmBookingPopup(
                    upcomingBooking: upcomingBooking,
                    onTapNext: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, RoutesName.directFnBSelectionScreen, arguments: {
                        'reservationId': upcomingBooking.reservationId,
                        'cinemaId': upcomingBooking.cinemaId.toString(),
                        'sessionId': upcomingBooking.sessionId.toString(),
                        'postConcessionUrl': ApiUrlConstants.postAllOnlyFoodAndBevRage,
                        'fAndBType': FAndBType.DIRECT_FANDB
                      });
                    },
                  );
                },
              );
            }
          }
        }, onFailure: (AppException error) {
          context.read<DirectFAndBBloc>().add(OnBookingIdError(error.message));
        }));
  }

  @override
  void initState() {
    _getUpcomingDataOnAuth(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(context.language.getText('orderSnacksDrinksForTakeaway'),
                  style: context.textThemeDecoration.titleLarge),
              Text(context.language.getText('enterIdOrSelectBooking'),
                  style: context.textThemeDecoration.paragraphLarge
                      .copyWith(color: context.colorPalette.accentColor)),
              SizedBox(height: context.getScreenHeight(2)),
              bookingIDField(),
              if (isUserLoggedIn)
                Expanded(
                  child: BlocBuilder<DirectFAndBBloc, DirectFAndBState>(
                      buildWhen: (previous, current) =>
                          current.loading != previous.loading ||
                          current.selectedReservationDetail != previous.selectedReservationDetail,
                      builder: (BuildContext context, DirectFAndBState state) {
                        if (state.loading == CurrentAppState.SUCCESS) {
                          if (state.upcomingBookings != null && state.upcomingBookings!.isEmpty) {
                            return SizedBox(
                              width: context.getScreenWidth(100),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(context.language.getText('noUpcomingBooking')),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomButton(
                                    height: context.getScreenHeight(5),
                                    backgroundColor: context.colorPalette.accentColor,
                                    text: context.language.getText('bookNow'),
                                    textColor: context.colorPalette.darkGreyColor,
                                    onTap: () {
                                      Navigator.pushNamed(context, RoutesName.moviesScreen);
                                    },
                                    width: context.getScreenWidth(30),
                                    isDisabled: false,
                                  ),
                                ],
                              ),
                            );
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(context.language.getText('upcomingBookings'),
                                  style: context.textThemeDecoration.subTitleLarge
                                      .copyWith(fontSize: 16)),
                              SizedBox(height: context.getScreenHeight(2)),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Wrap(
                                    runSpacing: context.getScreenWidth(5),
                                    alignment: WrapAlignment.spaceBetween,
                                    children:
                                        List.generate(state.upcomingBookings?.length ?? 0, (index) {
                                      final upcomingBooking = state.upcomingBookings?[index];
                                      return UpcomingBookingCard(
                                        isSelected:
                                            state.selectedReservationDetail == upcomingBooking
                                                ? true
                                                : false,
                                        upcomingBooking: upcomingBooking!,
                                        onClick: (upcomingBooking) {
                                          context
                                              .read<DirectFAndBBloc>()
                                              .add(SelectedUpcomingBooking(
                                                  upcomingBooking: upcomingBooking,
                                                  callback: () {
                                                    context.read<DirectFAndBBloc>().add(
                                                            GetUpcomingBookingsDetailsEvent(
                                                                onSuccess: (upcomingCinema) {
                                                          Navigator.pushNamed(context,
                                                              RoutesName.directFnBSelectionScreen,
                                                              arguments: {
                                                                'reservationId':
                                                                    upcomingCinema.reservationId,
                                                                'cinemaId': upcomingCinema.cinemaId
                                                                    .toString(),
                                                                'sessionId': upcomingCinema
                                                                    .sessionId
                                                                    .toString(),
                                                                'postConcessionUrl': ApiUrlConstants
                                                                    .postAllOnlyFoodAndBevRage,
                                                                'fAndBType': FAndBType.DIRECT_FANDB
                                                              });
                                                        }, onFailure: (AppException error) {
                                                          ListnersUtils.showErrorMessage(
                                                              error.message, 'Error', context);
                                                        }));
                                                  }));
                                        },
                                      );
                                    }),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        }
                        if (state.loading == CurrentAppState.ERROR) {
                          return Center(
                            child: Text(state.appException?.message ?? ''),
                          );
                        }
                        return const UpcomingBookingShimmer(cardCount: 1);
                      }),
                ),
              // const Spacer(),
              if (!isUserLoggedIn) unauthorizedUserContent(),
              if (!isUserLoggedIn) const Spacer(),
              navButtons(),
            ],
          ),
        ),
      ],
    );
  }

  Widget unauthorizedUserContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: context.colorPalette.accentColor)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("OR",
                  style: context.textThemeDecoration.paragraphLarge
                      .copyWith(color: context.colorPalette.accentColor)),
            ),
            Expanded(child: Divider(color: context.colorPalette.accentColor)),
          ],
        ),
        SizedBox(height: context.getScreenHeight(2)),
        Center(
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                WidgetSpan(
                    child: GestureDetector(
                        onTap: () {
                          context.read<AuthBloc>().add(AuthenticateUserEvent(onSuccess: () {
                                Navigator.pop(context);
                              }, onFailure: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        settings: const RouteSettings(name: RoutesName.loginScreen),
                                        builder: (context) {
                                          return LogInScreen(onLogin: (bool isLogin) {
                                            Navigator.pop(context);
                                            _getUpcomingDataOnAuth(context);
                                          });
                                        }));
                              }));
                        },
                        child: Text(context.language.getText('logIn'),
                            style: context.textThemeDecoration.subTitleMedium
                                .copyWith(color: context.colorPalette.accentColor)))),
                TextSpan(
                    text: " ${context.language.getText('seeYourUpcomingBookings')}",
                    style: context.textThemeDecoration.subTitleMedium)
              ])),
        ),
        SizedBox(height: context.getScreenHeight(4)),
      ],
    );
  }

  Widget bookingIDField() {
    return BlocBuilder<DirectFAndBBloc, DirectFAndBState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.language.getText('enterBookingId'),
                style: context.textThemeDecoration.subTitleLarge.copyWith(fontSize: 16)),
            SizedBox(height: context.getScreenHeight(2)),
            CustomTextField(
              controller: bookingID,
              width: context.getScreenWidth(100),
              getTextFieldValue: (value) {
                context.read<DirectFAndBBloc>().add(const OnBookingIdError(''));
                context.read<DirectFAndBBloc>().add(OnBookingIdChanged(value.trim()));
              },
              coustomInputFormatters: [],
              lable: context.language.getText('enterValidBookingId'),
            ),
            Text(state.bookingIDError,
                style: context.textThemeDecoration.subTitleLarge
                    .copyWith(fontSize: 14, color: context.colorPalette.error)),
            if (state.bookingIDError.isNotEmpty) SizedBox(height: context.getScreenHeight(2)),
          ],
        );
      },
    );
  }

  Widget navButtons() {
    return BlocBuilder<DirectFAndBBloc, DirectFAndBState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              height: context.getScreenHeight(6),
              backgroundColor: context.colorPalette.accentColor.withOpacity(0.1),
              borderColor: Border.all(color: context.colorPalette.accentColor.withOpacity(0.2)),
              text: context.language.getText('skip'),
              textColor: context.colorPalette.accentColor,
              onTap: () {
                Navigator.of(context).pushNamed(RoutesName.directFnBTakeawayScreen);
              },
              width: context.getScreenWidth(40),
              isDisabled: false,
            ),
            CustomButton(
              height: context.getScreenHeight(6),
              backgroundColor: context.colorPalette.accentColor,
              text: state.upcomingBookingDetailsState == CurrentAppState.LOADING
                  ? context.language.getText('loading')
                  : context.language.getText('next'),
              textColor: context.colorPalette.darkGreyColor,
              onTap: () {
                _getUpcomingBookingDetails(context);
              },
              width: context.getScreenWidth(40),
              isDisabled: bookingID.text.isEmpty ||
                      state.upcomingBookingDetailsState == CurrentAppState.LOADING
                  ? true
                  : false,
            ),
          ],
        );
      },
    );
  }
}
