import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/DirectFnB/presentation/components/DirectFnbMovieDetailsSummaryCard.dart';
import 'package:novocinema/src/DirectFnB/presentation/components/FnbDetailsCard.dart';
import 'package:novocinema/src/F&B/presentation/screens/FAndBScreen.dart';

import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/CustomButton.dart';
import '../../../../core/constants/RoutesName.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/utils/CurrencyFormater.dart';
import '../../../../core/utils/ListnerUtils.dart';
import '../../../F&B/presentation/bloc/F&BBloc.dart';
import '../../../F&B/presentation/components/F&BCartPopup.dart';
import '../../../OrderConfirmation/presentation/bloc/OrderConfirmationBloc.dart';
import '../bloc/DirectF&BBloc.dart';

class DirectFnbSummaryScreen extends StatefulWidget {
  final String reservationId;
  final FAndBType fAndBType;

  const DirectFnbSummaryScreen({super.key, required this.reservationId, required this.fAndBType});

  @override
  State<DirectFnbSummaryScreen> createState() => _DirectFnbSummaryScreenState();
}

class _DirectFnbSummaryScreenState extends State<DirectFnbSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return ArtBoard(
      header: BackButtonNavBar(onBackPress: () {
        Navigator.pop(context);
      }),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          Navigator.pop(context);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.fAndBType == FAndBType.DIRECT_FANDB) ...[
                    Text(context.language.getText('yourOrderSummary'),
                        style: context.textThemeDecoration.titleLarge
                            .copyWith(color: context.colorPalette.accentColor)),
                    const SizedBox(height: 15),
                    Text(context.language.getText('yourOrderDetails'),
                        style: context.textThemeDecoration.subTitleMedium),
                    const SizedBox(height: 20),
                    DirectFnbMovieDetailsSummaryCard(),
                    SizedBox(height: context.getScreenHeight(3)),
                  ],
                  if (widget.fAndBType == FAndBType.TAKEAWAY_FNB) ...[
                    Text(context.language.getText('yourTakeawayCart'),
                        style: context.textThemeDecoration.titleLarge
                            .copyWith(color: context.colorPalette.accentColor)),
                    const SizedBox(height: 15),
                    Text(context.language.getText('yourOrderDetails'),
                        style: context.textThemeDecoration.subTitleMedium),
                    const SizedBox(height: 20),
                    BlocBuilder<DirectFAndBBloc, DirectFAndBState>(
                      builder: (context, state) {
                        return Container(
                          width: context.getScreenWidth(100),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                              color: context.colorPalette.cardBackgroundColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: context.colorPalette.blackColor, width: 0.24)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined,
                                      color: context.colorPalette.darkGreyColor),
                                  const SizedBox(width: 5),
                                  Text(context.language.getText('takeawayLocation'),
                                      style: context.textThemeDecoration.subTitleMedium),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                  context.language.getApiText(
                                      state.selectedCinemaLocation!.name ?? '',
                                      state.selectedCinemaLocation!.nameAr ?? ''),
                                  style: context.textThemeDecoration.titleSmall
                                      .copyWith(color: context.colorPalette.accentColor)),
                              const SizedBox(height: 10),
                              Text(
                                  context.language.getApiText(
                                      state.selectedCinemaLocation!.address ?? '',
                                      state.selectedCinemaLocation!.addressAr ?? ''),
                                  style: context.textThemeDecoration.subTitleMedium),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: context.getScreenWidth(40),
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color:
                                                context.colorPalette.accentColor.withOpacity(0.4))),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("24 Aug, 2024",
                                            style: context.textThemeDecoration.subTitleMedium
                                                .copyWith(color: context.colorPalette.accentColor)),
                                        Icon(Icons.calendar_month_outlined,
                                            color: context.colorPalette.accentColor)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: context.getScreenWidth(40),
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color:
                                            context.colorPalette.accentColor.withOpacity(0.4))),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Now",
                                            style: context.textThemeDecoration.subTitleMedium
                                                .copyWith(color: context.colorPalette.accentColor)),
                                        Icon(Icons.keyboard_arrow_down,
                                            color: context.colorPalette.accentColor)
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: context.getScreenHeight(3)),
                  ],
                  Text(context.language.getText('foodDetails'),
                      style: context.textThemeDecoration.titleSmall),
                  const SizedBox(height: 15),
                  BlocBuilder<FAndBBloc, FAndBState>(
                    builder: (context, state) {
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: context.colorPalette.whiteColor.withOpacity(0.12)),
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.all(12),
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => FnbDetailsCard(
                                  concessionData: state.addConcessionItemList[index],
                                ),
                            separatorBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  child: Divider(
                                      color: context.colorPalette.accentColor.withOpacity(0.2)),
                                ),
                            itemCount: state.addConcessionItemList.length),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      footerHeight: context.getScreenHeight(15),
      footer: Container(
        width: context.getScreenWidth(100),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            border:
                Border.symmetric(horizontal: BorderSide(color: context.colorPalette.accentColor))),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Amount",
                    style: context.textThemeDecoration.subTitleLarge
                        .copyWith(color: context.colorPalette.accentColor)),
                BlocBuilder<FAndBBloc, FAndBState>(
                  builder: (context, state) {
                    return Text(
                        "${currencyCode()} ${priceConverter(getTotalAmount(state.addConcessionItemList))}",
                        style: context.textThemeDecoration.subTitleLarge.copyWith(
                            color: context.isDarkMode
                                ? context.colorPalette.accentColor
                                : context.colorPalette.blackColor));
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            CustomButton(
              height: context.getScreenHeight(6),
              backgroundColor: context.colorPalette.accentColor,
              text: 'Select Payment Method',
              textColor: context.colorPalette.darkGreyColor,
              onTap: () {
                // context.read<OrderConfirmationBloc>().add(CompleteOrderEvent(
                //     reservationId: widget.reservationId,
                //     onFailure: (AppException error) {
                //       ListnersUtils.showErrorMessage(
                //           error.message, 'Reservation Error', context);
                //     },
                //     onSuccess: () {
                //       Navigator.pushNamed(context, RoutesName.ticketListScreen,
                //           arguments: {'reservationId': widget.reservationId});
                //     }));
              },
              width: context.getScreenWidth(90),
              isDisabled: false,
            ),
          ],
        ),
      ),
    );
  }
}
