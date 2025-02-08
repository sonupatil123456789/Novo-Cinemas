import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:novocinema/core/theams/Utils.dart';
import '../../../../core/constants/ImageConstants.dart';
import '../../../../entities/models/ShowTimeDetailsModel.dart';


class ShowTimeDetails extends StatelessWidget {
  List<ShowTimeDetailsModel> showTimeList;
  ShowTimeDetailsModel? selectedDate;
  void Function(ShowTimeDetailsModel) onPressEvent;

  ShowTimeDetails({
    super.key,
    required this.showTimeList,
    required this.onPressEvent,
    required this.selectedDate,
  });

  final BorderRadius borderRadius = BorderRadius.circular(12);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.greenAccent,
      width: context.getScreenWidth(100),
      child: GridView.builder(
        itemCount: showTimeList.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            mainAxisExtent: context.getScreenHeight(7)),
        itemBuilder: (BuildContext context, int index) {
          final ShowTimeDetailsModel seatTiming = showTimeList[index];

          return IgnorePointer(
            ignoring: seatTiming.sessionDisabled == true ? true : false,
            child: GestureDetector(
              onTap: () {
                onPressEvent(seatTiming);
              },
              child: Container(
                height: context.getScreenHeight(8),
                width: context.getScreenWidth(26),
                decoration: ShapeDecoration(
                  color: selectedDate == seatTiming
                      ? context.colorPalette.accentColor
                      : seatTiming.sessionDisabled == true
                      ? context.colorPalette.accentColor
                      .withOpacity(0.07)
                      : null,
                  shape: RoundedRectangleBorder(
                      borderRadius: borderRadius,
                      side: BorderSide(
                          width: 2,
                          color: context.colorPalette.accentColor
                              .withOpacity(0.2))),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (seatTiming.isMidnightShow == true) ...[
                          SvgPicture.asset(
                            ImageConstants.nightTimeShow,
                            width: context.getScreenWidth(3.5),
                            height: context.getScreenWidth(3.5),
                          )
                        ],
                        const SizedBox(
                          width: 4,
                        ),
                        Text(seatTiming.showTime ?? '',
                            style: context
                                .textThemeDecoration.subTitleSmall
                                .copyWith(
                                color: selectedDate == seatTiming &&
                                    context.isDarkMode
                                    ? context.colorPalette.blackColor
                                    : seatTiming.sessionDisabled ==
                                    true
                                    ? context.colorPalette
                                    .disabledColor
                                    : null)),
                      ],
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Text(seatTiming.experience ?? '',
                        style: context.textThemeDecoration.paragraphLarge
                            .copyWith(
                            fontSize: 13,
                            color: selectedDate == seatTiming &&
                                context.isDarkMode
                                ? context.colorPalette.blackColor
                                : seatTiming.sessionDisabled == true
                                ? context
                                .colorPalette.disabledColor
                                : null)),
                    // const SizedBox(
                    //   height: 6,
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
