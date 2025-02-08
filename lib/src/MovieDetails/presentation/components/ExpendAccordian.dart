import 'package:flutter/material.dart';
import 'package:novocinema/components/cards/ReviewCard.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/Movies/domain/models/MovieCastModel.dart';
import 'package:novocinema/src/Movies/domain/models/MovieModel.dart';

import '../../../../components/ListBuilder.dart';
import '../../../../components/cards/CastCard.dart';

class ExpendAccordian extends StatefulWidget {
  Function onTapHandler;
  double width;
  double height;
  double expandedHeight;
  MovieModel movie;

  ExpendAccordian(
      {super.key,
      required this.width,
      required this.height,
      required this.expandedHeight,
      required this.onTapHandler,
      required this.movie});

  @override
  State<ExpendAccordian> createState() => _ExpendAccordianState();
}

class _ExpendAccordianState extends State<ExpendAccordian> {
  // int selectedIconIndex = 0;
  final BorderRadius borderRadius = BorderRadius.circular(12);

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: context.getScreenWidth(100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Synopsis",
                style: context.textThemeDecoration.titleSmall,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.movie.movieDescription ?? '',
                style: context.textThemeDecoration.paragraphLarge
                    .copyWith(fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        SizedBox(
          width: context.getScreenWidth(100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Cast",
                style: context.textThemeDecoration.titleSmall,
              ),
              const SizedBox(
                height: 20,
              ),
              ListBuilder<MovieCastModel>(
                  seprater: const SizedBox(
                    width: 15,
                  ),
                  width: context.getScreenWidth(100),
                  height: context.getScreenHeight(16),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index,
                      MovieCastModel castModel) {
                    if (widget.movie.cast!.isEmpty) {
                      return const Text("No cast data avalable");
                    }

                    return CastCard(
                      castData: castModel,
                      onPressEvent:
                          (BuildContext context, MovieCastModel cast) {},
                    );
                  },
                  data: widget.movie.cast ?? [])
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: context.getScreenWidth(100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Reviews",
                style: context.textThemeDecoration.titleSmall,
              ),
              const SizedBox(
                height: 20,
              ),
              ListBuilder(
                data: const [1, 2, 3, 4, 5, 6],
                width: context.getScreenWidth(100),
                height: context.getScreenHeight(20),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index, value) {
                  return ReviewCard();
                },
                seprater: const SizedBox(
                  width: 15,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
