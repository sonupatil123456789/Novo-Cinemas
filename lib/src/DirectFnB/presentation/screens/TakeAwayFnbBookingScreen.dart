import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novocinema/components/ArtBoard.dart';
import 'package:novocinema/components/BackButtonNavbar.dart';
import 'package:novocinema/components/shimmerloaders/CinemaLocationShimmer.dart';
import 'package:novocinema/components/shimmerloaders/SearchShimmer.dart';
import 'package:novocinema/components/shimmerloaders/UpcomingBookingShimmer.dart';
import 'package:novocinema/core/constants/ImageConstants.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/DirectFnB/presentation/components/CinemaLocationCard.dart';
import 'package:novocinema/src/Location/presentation/bloc/LocationBloc.dart';

import '../../../../core/resources/enums.dart';

class TakeAwayFnbBookingScreen extends StatefulWidget {
  const TakeAwayFnbBookingScreen({super.key});

  @override
  State<TakeAwayFnbBookingScreen> createState() =>
      _TakeAwayFnbBookingScreenState();
}

class _TakeAwayFnbBookingScreenState extends State<TakeAwayFnbBookingScreen> {
  @override
  void initState() {
    context
        .read<LocationBloc>()
        .add(GetAllCinemaLocationEvent(callback: () {}, cityId: ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ArtBoard(
        header:
            BackButtonNavBar(onBackPress: () => Navigator.of(context).pop()),
        body: body(),
      ),
    );
  }

  Widget body() {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.language.getText('takeaway'),
                style: context.textThemeDecoration.titleLarge),
            const SizedBox(height: 5),
            Text(context.language.getText('selectYourPreferredCinema'),
                style: context.textThemeDecoration.subTitleMedium
                    .copyWith(color: context.colorPalette.accentColor)),
            const SizedBox(height: 15),
            locationSelector(),
            const SizedBox(height: 20),
            Text(context.language.getText('cinemasNearYourLocation'),
                style: context.textThemeDecoration.titleLarge
                    .copyWith(fontSize: 16)),
            const SizedBox(height: 15),
            BlocBuilder<LocationBloc, LocationState>(
              buildWhen: (previous, current) =>
                  previous.cinemaLocationState != current.cinemaLocationState,
              builder: (context, state) {
                if (state.cinemaLocationState == CurrentAppState.SUCCESS) {
                  return Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) => CinemaLocationCard(
                            data: state.cinemaLocations[index]),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 15),
                        itemCount: state.cinemaLocations.length),
                  );
                }

                if (state.cinemaLocationState == CurrentAppState.ERROR) {
                  return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(state.appException!.message.toString()));
                }

                return const CinemaLocationShimmer();
              },
            )
          ],
        ),
      );
    });
  }

  Widget locationSelector() {
    return Builder(builder: (context) {
      return Container(
        width: context.getScreenWidth(100),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: context.colorPalette.blackColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: context.colorPalette.whiteColor.withOpacity(0.12))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(ImageConstants.currentLocation),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your current location",
                      style: context.textThemeDecoration.titleMedium.copyWith(
                          fontSize: 14,
                          color: context.colorPalette.lightGreyColor.withOpacity(0.8))),
                  const SizedBox(height: 5),
                  Text("Square Mall, Mall road, Dubai, 122002",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textThemeDecoration.titleMedium.copyWith(fontSize: 14)),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
