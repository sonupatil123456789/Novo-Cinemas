import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/F&B/presentation/bloc/F&BBloc.dart';
import 'package:novocinema/src/Home/presentation/bloc/HomeBloc.dart';
import 'package:novocinema/src/SeatLayout/presentation/bloc/SeatLayoutBloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/ImageConstants.dart';
import '../../../../core/theams/TextTheamStyle.dart';
import '../../../../core/utils/CurrencyFormater.dart';
import '../../../../core/utils/DateFormater.dart';
import '../../../../core/utils/SessionTimer.dart';
import '../../../MovieDetails/presentation/bloc/MovieDetailsBloc.dart';
import '../../../SeatLayout/presentation/screens/SeatLayoutScreen.dart';
import '../../../../components/cards/SeatMovieDetailCardDetails.dart';

class MovieDetailsCard extends StatefulWidget {
  // OffersBloc? offersBloc ;
  SeatLayoutBloc? seatLayoutBloc;
  MovieDetailsBloc? movieDetailsBloc;
  FAndBBloc? fAndBBloc;
  HomeBloc? homeBloc;
  MovieDetailsCard({
    super.key,
    this.homeBloc,
    this.fAndBBloc,
    this.seatLayoutBloc,
    this.movieDetailsBloc,
  });

  @override
  State<MovieDetailsCard> createState() => _MovieDetailsCardState();
}

class _MovieDetailsCardState extends State<MovieDetailsCard> {
  late final SessionTimer _countdownTimer;

  @override
  void initState() {
    _countdownTimer = SessionTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final movieState = widget.movieDetailsBloc?.state;
    final homeState = widget.homeBloc?.state;
    final seatLayoutState = widget.seatLayoutBloc?.state;
    final fAndBState = widget.fAndBBloc?.state;

    final movieDetails = (homeState?.selectedQuickBookMovie?.data);

    return Container(
      width: context.getScreenWidth(90),
      padding: EdgeInsets.all(context.getScreenWidth(4)),
      decoration: BoxDecoration(
          border: Border.all(
              width: 0.5,
              color:
                  context.colorPalette.reverseBackGroundColor.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<Map<String, dynamic>>(
            stream: _countdownTimer.countdownStream,
            builder: (context, snapshot) {
              final time = snapshot.data;

              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  clockContainer(context, "${time?['minutes']} Min"),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.getScreenWidth(3)),
                    child: Text(
                      " : ",
                      style: context.textThemeDecoration.paragraphLarge
                          .copyWith(color: context.colorPalette.accentColor),
                    ),
                  ),
                  clockContainer(context, "${time?['seconds']} Sec"),
                ],
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          if (seatLayoutState?.movieSelectionType ==
              MovieSelectionType.MOVIE_DETAILS) ...[
            movieDetailsCard(
              movieImage: movieState?.movieDetails.movieImageUrl,
              movieDate: movieState?.selectedDate,
              movieName: movieState?.movieDetails.movieTitle,
              movieTime: movieState?.selectedTiming?.showTime,
              movieMallName: movieState?.selectedMallName,
            )
          ],
          if (seatLayoutState?.movieSelectionType ==
              MovieSelectionType.QUICK_BOOK) ...[
            movieDetailsCard(
              movieImage: movieDetails?.movieImageUrl,
              movieDate: homeState?.selectedQuickBookDate?.title,
              movieName: movieDetails?.movieTitle,
              movieTime: homeState?.selectedQuickBookTime?.title,
              movieMallName: homeState?.selectedQuickBookCinema?.title,
            )
          ],
          if (seatLayoutState != null) ...[
            const SizedBox(
              height: 15,
            ),
            Text(
              'Seats',
              style: context.textThemeDecoration.subTitleMedium
                  .copyWith(fontFamily: TextThemeDecoration.HamburgerFont),
            ),
            Divider(
              color: context.colorPalette.reverseBackGroundColor,
              thickness: 0.2,
            ),
            Column(
                children: (seatLayoutState
                            .seatConfirmationDetails['selectedMovieSeatsMap']
                        as Map<String, List<Map<String, dynamic>>>)
                    .entries
                    .map((entries) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: "NOVO",
                        style: context.textThemeDecoration.subTitleSmall
                            .copyWith(
                                color: context.colorPalette.accentColor,
                                fontSize: 14)),
                    const TextSpan(text: " "),
                    TextSpan(
                      text: entries.key,
                      style: context.textThemeDecoration.subTitleSmall
                          .copyWith(fontSize: 14),
                    )
                  ])),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        entries.value
                            .map(
                                (seats) => seats['RowName'] + seats['SeatName'])
                            .join(", "),
                        style: context.textThemeDecoration.subTitleSmall
                            .copyWith(
                                fontFamily: TextThemeDecoration.HamburgerFont),
                      ),
                      Text(
                        '${(entries.value as List).length} X QAR ${priceConverter((entries.value as List).first['PriceInCents'] as num)}',
                        style: context.textThemeDecoration.subTitleSmall
                            .copyWith(fontSize: 14),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              );
            }).toList())
          ],
          if (fAndBState != null &&
              fAndBState.addConcessionItemList.isNotEmpty) ...[
            const SizedBox(
              height: 15,
            ),
            Text(
              'Food & Beverage',
              style: context.textThemeDecoration.subTitleMedium
                  .copyWith(fontFamily: TextThemeDecoration.HamburgerFont),
            ),
            Divider(
              color: context.colorPalette.reverseBackGroundColor,
              thickness: 0.2,
            ),
            Column(
                children: fAndBState.addConcessionItemList.map((fAndBItem) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        (fAndBItem['Name'] as String?) ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textThemeDecoration.subTitleSmall
                            .copyWith(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      width: context.getScreenWidth(10),
                    ),
                    Text(
                      '${(fAndBItem['Quantity'].toString())} X QAR ${priceConverter(((fAndBItem['Price'] as num?) ?? 0)).toString()}',
                      style: context.textThemeDecoration.subTitleSmall
                          .copyWith(fontSize: 14),
                    )
                  ],
                ),
              );
            }).toList())
          ]
        ],
      ),
    );
  }

  Widget clockContainer(BuildContext context, String time) {
    return Container(
      decoration: BoxDecoration(
          color: context.colorPalette.cardBackgroundColor,
          borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(
          horizontal: context.getScreenWidth(4.5),
          vertical: context.getScreenHeight(0.8)),
      // height: context.getScreenHeight(4),
      alignment: Alignment.center,
      child: Text(
        time,
        style: context.textThemeDecoration.paragraphLarge
            .copyWith(color: context.colorPalette.accentColor),
      ),
    );
  }

  Widget movieDetailsCard(
      {required String? movieImage,
      required String? movieDate,
      required String? movieName,
      required String? movieTime,
      required String? movieMallName}) {
    return Container(
      height: context.getScreenHeight(7),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: context.getScreenWidth(20),
              child: CachedNetworkImage(
                imageUrl: movieImage ?? '',
                height: context.getScreenHeight(7),
                width: context.getScreenWidth(26),
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Image.asset(
                  ImageConstants.fallBackImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movieName ?? '',
                style: context.textThemeDecoration.subTitleSmall
                    .copyWith(fontFamily: TextThemeDecoration.HamburgerFont),
              ),
              Text(movieMallName ?? '',
                  style: context.textThemeDecoration.paragraphLarge),
              Text(
                  "${getDay(movieDate ?? '').trim()} ${getMonth(movieDate ?? '').substring(0, 3).trim()}  |  ${movieTime ?? ''}",
                  style: context.textThemeDecoration.paragraphLarge
                      .copyWith(color: context.colorPalette.accentColor)),
            ],
          )
        ],
      ),
    );
  }
}
