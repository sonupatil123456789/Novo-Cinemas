

import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';

import '../../../../core/utils/DateFormater.dart';
import '../../domain/models/MallLocationModel.dart';

class DateCard extends StatelessWidget {
  String date;
  String? selectedDate ;
  void Function(String date) onPressEvent;
   DateCard({super.key,required this.date, required this.selectedDate , required this.onPressEvent});
  final BorderRadius borderRadius = BorderRadius.circular(12);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        onPressEvent(date);
      },
      child: Container(
        width: context.getScreenWidth(15),
        height: context.getScreenHeight(9),
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
            color: date==selectedDate ? context.colorPalette.accentColor:  context.colorPalette.transparentColor,
            border: Border.all(width: 1, color: context.colorPalette.accentColor.withOpacity(0.2)),
            borderRadius: borderRadius  ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(getWeek(date).substring(0,3), style: context.textThemeDecoration.subTitleSmall.copyWith(
                color: date==selectedDate && context.isDarkMode ? context.colorPalette.blackColor : null
            )),
            Text(getDay(date).toString(),style: context.textThemeDecoration.subTitleLarge.copyWith(
             fontSize: 22 , color: date==selectedDate && context.isDarkMode ? context.colorPalette.blackColor : null)),
          ],
        ),
      ),
    );
  }
}
