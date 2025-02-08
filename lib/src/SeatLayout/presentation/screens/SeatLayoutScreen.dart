
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novocinema/components/CircularLoader.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/core/utils/ListnerUtils.dart';
import 'package:novocinema/src/OrderConfirmation/presentation/bloc/OrderConfirmationBloc.dart';

import 'package:novocinema/src/MovieDetails/presentation/bloc/MovieDetailsBloc.dart';
import 'package:novocinema/src/SeatLayout/presentation/components/BookingStepper.dart';
import 'package:novocinema/src/SeatLayout/presentation/components/SeatLayoutFooterDetails.dart';
import 'package:novocinema/src/ShowTime/presentation/bloc/ShowTimeBloc.dart';
import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/CustomButton.dart';
import '../../../../core/constants/ImageConstants.dart';
import '../../../../core/constants/RoutesName.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/theams/TextTheamStyle.dart';
import '../../../../core/utils/CurrencyFormater.dart';
import '../../../../core/utils/DateFormater.dart';
import '../../../../core/utils/SessionTimer.dart';
import '../../../Home/presentation/bloc/HomeBloc.dart';
import '../../../Offers/presentation/bloc/OffersBloc.dart';
import '../../domain/models/SeatModel.dart';
import '../bloc/SeatLayoutBloc.dart';
import '../components/ChangeMovieDateTime.dart';
import '../components/CustomSeatLayout.dart';
import '../components/TimeUpDialogBox.dart';
import 'TestSeat.dart';

enum MovieSelectionType { QUICK_BOOK, MOVIE_DETAILS, SHOW_TIME }

class SeatLayoutScreen extends StatefulWidget {
  final String sessionId;
  final String cinemaId;
  final MovieSelectionType movieSelectionType;

  const SeatLayoutScreen(
      {super.key,
      required this.sessionId,
      required this.cinemaId,
      required this.movieSelectionType});

  @override
  State<SeatLayoutScreen> createState() => _SeatLayoutScreenState();
}

class _SeatLayoutScreenState extends State<SeatLayoutScreen> {
  final BorderRadius borderRadius = BorderRadius.circular(12);

  late final SessionTimer _countdownTimer;
  late SeatLayoutBloc _seatLayoutBloc;
  late HomeBloc _homeBloc;
  late MovieDetailsBloc _movieDetailBloc;
  late ShowTimeBloc _showTimeBloc;



  @override
  void initState() {
    _seatLayoutBloc = context.read<SeatLayoutBloc>();
    _homeBloc = context.read<HomeBloc>();
    _movieDetailBloc = context.read<MovieDetailsBloc>();
    _showTimeBloc = context.read<ShowTimeBloc>();

    _seatLayoutBloc.add(GetSeatLayoutEvent(widget.sessionId, widget.cinemaId));

    _countdownTimer = SessionTimer();
    super.initState();
  }

  @override
  void dispose() {
    _seatLayoutBloc.add(const ClearSeatStateEvent());

    if (widget.movieSelectionType == MovieSelectionType.QUICK_BOOK) {
      _homeBloc.add(const ClearQuickBookEvent());
    }
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final movieDetailState = _movieDetailBloc?.state;
    final showTimeState = _showTimeBloc?.state;

    return BlocBuilder<SeatLayoutBloc, SeatLayoutState>(
      builder: (context, seatState) {
    return ArtBoard(
      header: BackButtonNavBar(
        onBackPress: () {
          Navigator.pop(context);
        },
        center: SizedBox(
          height: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.movieSelectionType ==MovieSelectionType.MOVIE_DETAILS) ...[
                      Text(
                        movieDetailState?.movieDetails.movieTitle ?? "",
                        style: context.textThemeDecoration.subTitleSmall.copyWith(fontFamily: TextThemeDecoration.HamburgerFont),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                          "${movieDetailState?.selectedMallName}  |  ${getDay(movieDetailState?.selectedDate ?? '').trim()} ${getMonth(movieDetailState?.selectedDate ?? '').substring(0, 3).trim()}  ${movieDetailState?.selectedTiming?.showTime ?? ''}",
                          style: context.textThemeDecoration.paragraphMedium.copyWith(  color: context.isDarkMode ? context.colorPalette.accentColor : context.colorPalette.darkGreyColor)),
                    ]
                    else if (widget.movieSelectionType ==MovieSelectionType.SHOW_TIME) ...[
                      Text(
                        showTimeState?.movieDetail.movieTitle ?? "",
                        style: context.textThemeDecoration.subTitleSmall.copyWith(fontFamily: TextThemeDecoration.HamburgerFont),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                          "${showTimeState?.selectedMallName}  |  ${getDay(showTimeState?.selectedDate ?? '').trim()} ${getMonth(showTimeState?.selectedDate ?? '').substring(0, 3).trim()}  ${showTimeState?.selectedTiming?.showTime ?? ''}",
                          style: context.textThemeDecoration.paragraphMedium.copyWith(  color: context.isDarkMode ? context.colorPalette.accentColor : context.colorPalette.darkGreyColor)),
                    ]

                    else...[

                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: context.getScreenHeight(2),
            ),
            BlocBuilder<OrderConfirmationBloc,OrderConfirmationState>(
              builder: (BuildContext context,  orderConfirmationState) {
                return BookingStepper(
                  initialStep:orderConfirmationState.bookingFlowSteps ,
                  onStepChanged: (BookingFlowSteps data) {
                    print(data.toString());
                  });
            },),
            SizedBox(
              height: context.getScreenHeight(1),
            ),
            ChangeMovieDateTime(
              showTimeData: widget.movieSelectionType,
            ),
            SizedBox(
              height: context.getScreenHeight(2),
            ),

            SvgPicture.asset(ImageConstants.theaterScreen,),

            BlocBuilder<SeatLayoutBloc, SeatLayoutState>(
              buildWhen: (previous, current) =>
              previous.loading != current.loading ||
                  previous.seatLayout != current.seatLayout,
              builder: (context, seatState) {
                if (seatState.loading == CurrentAppState.LOADING ||
                    seatState.loading == CurrentAppState.INITIAL) {
                  return const SizedBox(
                      height: 50,
                      width: 50,
                      child: Center(child: CircularLoader()));
                }
                if (seatState.loading == CurrentAppState.ERROR) {
                  return Container(
                      alignment: Alignment.center,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                          seatState.appException!.message.toString()));
                }
                return Flexible(
                  child: Container(
                    // color: Colors.greenAccent,
                    child: CinemaSeatLayout(
                      seatLayout: seatState.seatLayout,
                    ),
                  ),
                );
              },
            ),

            Container(height:  context.getScreenHeight(seatState.selectedSeat.isEmpty ? 1 :1),)
          ],
        ),
      ),
      // footerHeight: context.getScreenHeight(0),
      footerHeight: context.getScreenHeight(seatState.selectedSeat.isEmpty ? 10 :18),
      footer: SeatLayoutFooterDetails(movieSelectionType: widget.movieSelectionType,
         onContinueClick: (){
           navigateOnSeatSelected((String reservationId)=>Navigator.pushNamed(context, RoutesName.offersScreen));
           context.read<OrderConfirmationBloc>().add(const SetBookingStepperEvent(step: BookingFlowSteps.OFFERS));
        },
        onQuickPayClick: (){
          navigateOnSeatSelected((String reservationId)=>Navigator.pushNamed(context, RoutesName.orderConfirmationScreen,arguments: {
            'reservationId':reservationId,
            'navigateToScreen':RoutesName.seatLayoutScreen,
          }));
        },),
    );
  },
);
  }

  void navigateOnSeatSelected(Function(String) navigateTo) {
    Map<String, dynamic> details = {};

    if (widget.movieSelectionType == MovieSelectionType.QUICK_BOOK) {
      final homeState = _homeBloc.state.selectedQuickBookTime!.data;
      details = {
        "CinemaId": homeState!.cinemaId.toString(),
        "SessionId": homeState.sessionId.toString(),
      };
    } else {
      final moviesState = _movieDetailBloc.state.selectedTiming;
      details = {
        "CinemaId": moviesState!.cinemaId.toString(),
        "SessionId": moviesState.sessionId.toString(),
      };
    }

    context.read<SeatLayoutBloc>().add(BookSelectedSeatsEvent(
      confirmationDetails: details,
      onSuccess: (String reservationId) {
        _countdownTimer.startTimer(
            duration: SEASSION_TIMER_DURATION,
            context: context,
            onSessionExpired: (int time) {
              context.read<OffersBloc>().add(CancelBookedSelectedSeatsEvent(
                    (p0) {
                  _countdownTimer.stopTimer();
                  Navigator.popUntil(
                    context,
                        (route) =>
                    route.settings.name == RoutesName.seatLayoutScreen,
                  );
                },
              ));
            },
            sessionTime: (int time) {
              showDialog(
                context: context,
                useRootNavigator: false,
                builder: (context) {
                  return TimeUpDialogBox(
                    reservationId: reservationId,
                    countdownTimer: _countdownTimer,
                  );
                },
              );
            },
            remainingTimerAlert: 20);

        navigateTo(reservationId);
      },
      onFailure: (AppException error) {
        ListnersUtils.showErrorMessage(
            error.message, 'Seat Reservation Error', context);
      },
      movieSelectionType: widget.movieSelectionType,
    ));
  }


}


