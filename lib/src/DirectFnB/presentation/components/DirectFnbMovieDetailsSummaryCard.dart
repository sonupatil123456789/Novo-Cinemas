import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/core/utils/CurrencyFormater.dart';

import '../../../../di.dart';
import '../bloc/DirectF&BBloc.dart';
import 'DirectFnbMovieDetailsCard.dart';

class DirectFnbMovieDetailsSummaryCard extends StatefulWidget {
  DirectFnbMovieDetailsSummaryCard({super.key});

  @override
  State<DirectFnbMovieDetailsSummaryCard> createState() =>
      _DirectFnbMovieDetailsSummaryCardState();
}

class _DirectFnbMovieDetailsSummaryCardState
    extends State<DirectFnbMovieDetailsSummaryCard> {
  late DirectFAndBBloc directFAndBBloc;

  @override
  void initState() {
    directFAndBBloc = getIt<DirectFAndBBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final directFAndBState = directFAndBBloc.state;
    final details = directFAndBState.selectedReservationDetail;
    return Container(
      width: context.getScreenWidth(100),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
          color: context.colorPalette.cardBackgroundColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border:
              Border.all(color: context.colorPalette.accentColor, width: 0.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DirectFnbMovieDetailsCard(data: details!, showDetails: false),
          const SizedBox(height: 20),
          Text(context.language.getText('seats'),
              style: context.textThemeDecoration.titleSmall),
          Divider(color: context.colorPalette.accentColor, thickness: 0.2),
          Text(details.seatName!.map((seat) => seat.areaName).join('|'),
              style: context.textThemeDecoration.titleSmall),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                    details.seatName!.map((seat) => seat.seats).join('|'),
                    overflow: TextOverflow.clip,
                    style: context.textThemeDecoration.titleSmall.copyWith(
                        color:
                            context.colorPalette.whiteColor.withOpacity(0.6))),
              ),
              Text(
                  "${details.totalSeats} X ${currencyCode()} ${((priceConverter(details.ticketPriceInCents ?? 0)) / details.totalSeats!).toStringAsFixed(0)}",
                  style: context.textThemeDecoration.titleSmall.copyWith(
                      fontSize: 14, color: context.colorPalette.whiteColor)),
            ],
          )
        ],
      ),
    );
  }
}
