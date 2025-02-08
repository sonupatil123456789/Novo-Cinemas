import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:novocinema/components/CustomButton.dart';
import 'package:novocinema/components/cards/SeatTicketCard.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/Home/presentation/bloc/HomeBloc.dart';
import 'package:novocinema/src/Tickets/presentation/bloc/TicketBloc.dart';
import '../../../../components/AnimatedDotIndicator.dart';
import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/CircularLoader.dart';
import '../../../../components/cards/FAndBTicketCard.dart';
import '../../../../core/constants/RoutesName.dart';
import '../../../../core/nativeServices/DeepLinkServices.dart';
import '../../../../core/utils/SessionTimer.dart';
import '../../../F&B/presentation/bloc/F&BBloc.dart';
import '../../../MovieDetails/presentation/bloc/MovieDetailsBloc.dart';
import '../../../SeatLayout/presentation/bloc/SeatLayoutBloc.dart';
import '../../domain/models/ReservationDetailsModel.dart';

class TicketListScreen extends StatefulWidget {
  final String reservationId;
  final bool isDeepLinking;

  TicketListScreen({super.key, required this.reservationId, required this.isDeepLinking});

  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  final _controller = PageController();
  late final SessionTimer _countdownTimer;
  int _currentPage = 0;

  @override
  void initState() {
    _countdownTimer = SessionTimer();
    context
        .read<TicketBloc>()
        .add(GetReservationDetailsEvent(widget.reservationId));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int _getTotalPages(ReservationDetailsModel? details) {
    if (details == null) return 0;

    int pages = 0;
    if (details.concessionData?.isNotEmpty ?? false) pages++;
    if (details.seatName?.isNotEmpty ?? false) pages++;
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return ArtBoard(
      body: PopScope(
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          clearBookingFlowStateAndNavigate(context, widget.isDeepLinking);
        },
        child: BlocBuilder<TicketBloc, TicketState>(
          builder: (context, ticketState) {
            final totalPages = _getTotalPages(ticketState.reservationDetails);

            if (ticketState.loading == CurrentAppState.SUCCESS) {
              _countdownTimer.stopTimer();
              return Column(
                children: [
                  Expanded(
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      controller: _controller,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      //according to new ui
                      children: [

                        if (ticketState.reservationDetails != null && ticketState .reservationDetails!.seatName!.isNotEmpty) ...[
                          SeatTicketCard( reservationDetails: ticketState.reservationDetails!, shareTicket: (title , discription)async {
                            DeepLinkServices.shareDeepLink(title: title, discription: discription,
                                data: BranchContentMetaData()..addCustomMetadata(TICKETRESERVATION, widget.reservationId)
                            );
                          },),
                        ],

                        if (ticketState.reservationDetails != null && ticketState.reservationDetails!.concessionData! .isNotEmpty) ...[
                          FAndBTicketCard(
                            reservationDetails: ticketState.reservationDetails!, shareTicket: (title , discription){
                            DeepLinkServices.shareDeepLink(title: title, discription: discription,
                                data: BranchContentMetaData()..addCustomMetadata(TICKETRESERVATION, widget.reservationId)
                            );},

                          ),

                        ],
                      ],
                    ),
                  ),
                  if (totalPages > 1) ...[
                    Container(
                      width: context.getScreenWidth(100),
                      height: 20,
                      alignment: Alignment.bottomCenter,
                      child: AnimatedDotIndicator(
                        count: totalPages,
                        currentIndex: _currentPage,
                        activeColor: context.colorPalette.accentColor,
                        inactiveColor: context.colorPalette.cardBackgroundColor,
                      ),
                    ),
                  ],
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            }

            if (ticketState.loading == CurrentAppState.ERROR) {
              return Container(
                  alignment: Alignment.center,
                  height: context.getScreenHeight(50),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(ticketState.appException!.message.toString()));
            }

            return Container(
                alignment: Alignment.center,
                height: context.getScreenHeight(50),
                child: const CircularLoader());
          },
        ),
      ),
      footerHeight: context.getScreenHeight(10),
      footer: Container(
        width: context.getScreenWidth(100),
        height: context.getScreenHeight(10),
        padding: const EdgeInsets.symmetric(horizontal: 22),
        decoration: BoxDecoration(
            color: context.colorPalette.backGroundColor,
            borderRadius:
            const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            border: Border(
                top: BorderSide(color: context.colorPalette.accentColor)
            )),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomButton(
              height: context.getScreenHeight(6),
              backgroundColor: context.colorPalette.accentColor,
              text: 'Home Page',
              textColor: context.colorPalette.darkGreyColor,
              onTap: () {
                clearBookingFlowStateAndNavigate(context,widget.isDeepLinking);
              },
              width: context.getScreenWidth(90),
            ),
          ],
        )
      ),

    );
  }

  void clearBookingFlowStateAndNavigate(BuildContext context, bool isDeepLinking) {
    context.read<SeatLayoutBloc>().add(const ClearSeatStateEvent());
    context.read<FAndBBloc>().add(const ClearFAndBStateEvent());
    context.read<HomeBloc>().add(const ClearQuickBookEvent());
    context.read<MovieDetailsBloc>().add(const ClearSessionStateEvent());
    if(isDeepLinking){
      Navigator.pushNamedAndRemoveUntil(context, RoutesName.mainSection, (route) => false);
    }else{
      Navigator.popUntil(context, (route) => route.settings.name ==RoutesName.mainSection,);
    }

  }
}
