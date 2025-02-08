

import 'package:flutter/cupertino.dart';
import 'package:novocinema/components/chips/CustomChoiceChips.dart';
import 'package:novocinema/core/theams/Utils.dart';

class CustomChip<T> extends StatelessWidget {
  ChoiceChipData<T> data;
  ChoiceChipData<T> selectedDate ;
  void Function(ChoiceChipData<T>) onPressEvent;
  Color? backgroundColour ;
  Color? textColour ;
  CustomChip({super.key,required this.data, required this.selectedDate , required this.onPressEvent,this.backgroundColour, this.textColour});
  final BorderRadius borderRadius = BorderRadius.circular(12);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        onPressEvent(data);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: context.getScreenWidth(3)),
        decoration: BoxDecoration(
            color: data == selectedDate ? context.colorPalette.accentColor: backgroundColour ?? context.colorPalette.transparentColor,
            border: Border.all(width: 1, color: data == selectedDate || context.isDarkMode ? context.colorPalette.accentColor.withOpacity(0.2) : context.colorPalette.darkGreyColor),
            borderRadius: borderRadius  ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(data.title.toString(), style: context.textThemeDecoration.paragraphMedium.copyWith(
                color: data == selectedDate && context.isDarkMode ? context.colorPalette.blackColor : textColour
            )),
          ],
        ),
      ),
    );
  }
}
