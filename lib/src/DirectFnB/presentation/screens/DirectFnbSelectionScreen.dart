import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/components/ArtBoard.dart';
import 'package:novocinema/components/BackButtonNavbar.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/di.dart';
import 'package:novocinema/src/F&B/presentation/bloc/F&BBloc.dart';
import 'package:novocinema/src/F&B/presentation/components/F&BItems.dart';

import '../../../../components/CustomButton.dart';
import '../../../../core/constants/ApiUrlConstants.dart';
import '../../../../core/constants/DatabaseKeyConstants.dart';
import '../../../../core/constants/RoutesName.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/SeassionManager.dart';
import '../../../Auth/presentation/bloc/AuthBloc.dart';
import '../../../Auth/presentation/screens/LoginScreen.dart';
import '../../../F&B/presentation/screens/FAndBScreen.dart';
import '../../../Tickets/domain/models/ReservationDetailsModel.dart';
import '../bloc/DirectF&BBloc.dart';
import '../components/ConfirmBookingPopup.dart';

class DirectFnbSelectionScreen extends StatefulWidget {
  final String reservationId;
  final String sessionId;
  final String cinemaId;
  final String postConcessionUrl;
  final FAndBType fAndBType;
  final Map<String, dynamic>? qrData;

  const DirectFnbSelectionScreen(
      {super.key,
      required this.fAndBType,
      required this.reservationId,
      required this.sessionId,
      required this.cinemaId,
      required this.postConcessionUrl,
      this.qrData});

  @override
  State<DirectFnbSelectionScreen> createState() => _DirectFnbSelectionScreenState();
}

class _DirectFnbSelectionScreenState extends State<DirectFnbSelectionScreen> {
  late final SeassionManager session;
  bool isUserLoggedIn = false;

  void _getUserAuth(BuildContext context) async {
    isUserLoggedIn = await SeassionManager().getAccessToken(TOKEN) != null ? true : false;
    setState(() {});
    if (!isUserLoggedIn) {
      context.read<AuthBloc>().add(AuthenticateUserEvent(onSuccess: () async {
            Navigator.pop(context);
            if (widget.fAndBType == FAndBType.STAR_FNB) {
              await _get7StarBooking();
            } else {
              Navigator.pushNamed(context, RoutesName.directFnBSummaryScreen, arguments: {
                'reservationId': widget.reservationId,
                'cinemaId': widget.cinemaId.toString(),
                'sessionId': widget.sessionId.toString(),
                'postConcessionUrl': ApiUrlConstants.postAllOnlyFoodAndBevRage,
                'fAndBType': widget.fAndBType
              });
            }
          }, onFailure: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    settings: const RouteSettings(name: RoutesName.loginScreen),
                    builder: (context) {
                      return LogInScreen(onLogin: (bool isLogin) {
                        Navigator.pop(context);
                      });
                    }));
          }));
    }
  }

  Future<void> _get7StarBooking() async {
    context.read<DirectFAndBBloc>().add(const GetAllUpcomingBookingsEvent());
    final state = context.read<DirectFAndBBloc>().state;
    if (state.loading == CurrentAppState.SUCCESS) {
      bool matchFound = isSelectedDataMatch(widget.qrData!, state.upcomingBookings ?? []);
      if (matchFound) {
        context
            .read<DirectFAndBBloc>()
            .add(GetUpcomingBookingsDetailsEvent(onSuccess: (upcomingBooking) {
              showDialog(
                context: context,
                builder: (context) {
                  return ConfirmBookingPopup(
                    upcomingBooking: upcomingBooking,
                    onTapNext: () {
                      Navigator.of(context).pop();
                      // Navigator.pushNamed(
                      //     context, RoutesName.directFnBSelectionScreen,
                      //     arguments: {
                      //       'reservationId': upcomingBooking.reservationId,
                      //       'cinemaId': upcomingBooking.cinemaId.toString(),
                      //       'sessionId': upcomingBooking.sessionId.toString(),
                      //       'postConcessionUrl':
                      //           ApiUrlConstants.postAllOnlyFoodAndBevRage,
                      //       'fAndBType': FAndBType.STAR_FNB
                      //     });
                    },
                  );
                },
              );
            }, onFailure: (AppException error) {
              // TODO: handle failure
            }));
      }
    } else {
      // TODO: handle failure
    }
  }

  bool isSelectedDataMatch(Map<String, dynamic> selectedData, List<ReservationDetailsModel> list) {
    for (var item in list) {
      // Check if cinema id, screen, and seat_no match
      if (item.cinemaId == selectedData['cinemaid'] &&
          int.parse(item.screen ?? "") == selectedData['screen'] &&
          item.seatName!.any((element) => element.seats == selectedData['seat_no'])) {
        return true; // Match found
      }
    }
    return false; // No match found
  }

  @override
  Widget build(BuildContext context) {
    return ArtBoard(
      header: BackButtonNavBar(onBackPress: () {
        context.read<FAndBBloc>().add(const ClearFAndBStateEvent());
        Navigator.pop(context);
      }),
      body: body(),
      footerHeight: context.getScreenHeight(10),
      footer: footer(),
    );
  }

  Widget body() {
    return Builder(
        builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [...header(), Expanded(child: FnBItems(cinemaId: widget.cinemaId))],
              ),
            ));
  }

  List<Widget> header() {
    List<Widget> child;
    switch (widget.fAndBType) {
      case FAndBType.BOOKING_FLOW_FANDB:
        // TODO: Handle this case.
        throw UnimplementedError();
      case FAndBType.DIRECT_FANDB:
        child = [
          Text(context.language.getText('orderSnacksDrinksForTakeaway'),
              style: context.textThemeDecoration.titleLarge),
          const SizedBox(height: 2),
          Text(context.language.getText('enterIdOrSelectBooking'),
              style: context.textThemeDecoration.paragraphLarge
                  .copyWith(color: context.colorPalette.accentColor)),
          SizedBox(height: context.getScreenHeight(2)),
        ];
      case FAndBType.TAKEAWAY_FNB:
        child = [
          Text(context.language.getText('orderSnacksDrinksForTakeaway'),
              style: context.textThemeDecoration.titleLarge),
          const SizedBox(height: 2),
          Text(context.language.getText('selectFoodAndBeverage'),
              style: context.textThemeDecoration.paragraphLarge
                  .copyWith(color: context.colorPalette.accentColor)),
          SizedBox(height: context.getScreenHeight(2)),
        ];
      case FAndBType.QR_FNB:
        child = [
          Text("Welcome to Novo Cinemas",
              style: context.textThemeDecoration.titleLarge
                  .copyWith(color: context.colorPalette.accentColor)),
          const SizedBox(height: 2),
          Text("Order your favourite snacks and drinks",
              style: context.textThemeDecoration.paragraphLarge),
          SizedBox(height: context.getScreenHeight(2)),
        ];
      case FAndBType.STAR_FNB:
        child = [
          Text("Seat Delivery", style: context.textThemeDecoration.titleLarge),
          const SizedBox(height: 2),
          Text("Select food and beverage you would like to order",
              style: context.textThemeDecoration.paragraphLarge
                  .copyWith(color: context.colorPalette.accentColor)),
          const SizedBox(height: 25),
          Container(
            decoration: BoxDecoration(
              color: context.colorPalette.accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                RotatedBox(
                    quarterTurns: 1,
                    child: Icon(Icons.discount, color: context.colorPalette.accentColor)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text("Get QAR 50 on us — indulge freely, pay only for extras!",
                      overflow: TextOverflow.clip,
                      style: context.textThemeDecoration.paragraphLarge
                          .copyWith(color: context.colorPalette.accentColor, fontSize: 14)),
                ),
              ],
            ),
          ),
          SizedBox(height: context.getScreenHeight(2)),
        ];
    }
    return child;
  }

  Widget footer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          border:
              Border.symmetric(horizontal: BorderSide(color: context.colorPalette.accentColor))),
      child: Row(
        children: [
          const Spacer(),
          BlocBuilder<FAndBBloc, FAndBState>(
            builder: (context, state) {
              return Text("${state.addConcessionItemList.length} item added",
                  style: context.textThemeDecoration.paragraphLarge
                      .copyWith(color: context.colorPalette.accentColor, fontSize: 16));
            },
          ),
          const Spacer(),
          CustomButton(
            height: context.getScreenHeight(5),
            backgroundColor: context.colorPalette.accentColor,
            text: context.language.getText('viewCart'),
            textColor: context.colorPalette.darkGreyColor,
            onTap: () {
              if (!isUserLoggedIn) {
                _getUserAuth(context);
              } else {
                Navigator.pushNamed(context, RoutesName.directFnBSummaryScreen, arguments: {
                  'reservationId': widget.reservationId,
                  'cinemaId': widget.cinemaId.toString(),
                  'sessionId': widget.sessionId.toString(),
                  'postConcessionUrl': ApiUrlConstants.postAllOnlyFoodAndBevRage,
                  'fAndBType': widget.fAndBType
                });
              }
            },
            width: context.getScreenWidth(40),
            isDisabled: false,
          ),
        ],
      ),
    );
  }
}
