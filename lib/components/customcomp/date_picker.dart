

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/core/utils/Logger.dart';

class CoustomDatePicker<T> extends StatefulWidget {
  Function(DateTime) pickedDate;
  Color bgColor;
  String placeHolder;
  Color selectedTextColor;
  Color unSelectedTextColor;
  Color borderColor;
  double width;
  double height;
  double? borderRadius ;
  Widget icon ;

  CoustomDatePicker({
    super.key,
    required this.bgColor,
    required this.borderColor,
    required  this.unSelectedTextColor,
    required this.selectedTextColor,
    required this.height,
    required this.placeHolder ,
    required this.pickedDate,
    required this.width,
    required this.icon,
    this.borderRadius,

  });


  @override
  State<CoustomDatePicker> createState() => _CoustomDatePickerState();
}

class _CoustomDatePickerState extends State<CoustomDatePicker> {
  DateTime? selectedDate ;

  static TextEditingController birthDateController = TextEditingController();

  coustomDatepicker(context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),

        builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme:  ColorScheme.light(
              primary:  context.colorPalette.accentColor,
                // background:context.colorPalette.cardBackgroundColor ,
                // suface: context.colorPalette.cardBackgroundColor
            ),
            // buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                 foregroundColor:  context.colorPalette.blackColor, // Text color
                backgroundColor: context.colorPalette.accentColor// Button background color
              ),
            ),
          ),
          child: child!,
        );
      },
    );



    if (picked != null) {
      selectedDate = picked;
       await widget.pickedDate(selectedDate!);
      setState(() {});
      Logger.customLogData('selected date ', selectedDate.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async {
        await coustomDatepicker(context);
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: widget.bgColor,
            borderRadius: BorderRadius.circular(12),
            border:  Border.all(color: widget.borderColor , width: 0.4)
        ),
        child: Text(
            selectedDate != null ?
            "${selectedDate?.year.toString()}/${selectedDate?.month.toString()}/${selectedDate?.day.toString()}"
                : widget.placeHolder,
          style: context.textThemeDecoration.subTitleLarge.copyWith(
          fontWeight: FontWeight.w400 ,
              color: selectedDate == null ? widget.unSelectedTextColor:widget.selectedTextColor
        ),),
      ),
    );
  }
}
