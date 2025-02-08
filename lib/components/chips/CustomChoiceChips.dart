import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';

class ChoiceChipData<T> extends Equatable {
  num Id;
  String title;
  T? data;


  ChoiceChipData(this.Id, this.title, this.data);

  @override
  // TODO: implement props
  List<Object?> get props => [Id, title];
}

class CustomChoiceChips extends StatelessWidget {
  List<ChoiceChipData> dataList;
  Color bgColor;
  Function selectedDataOnTap;
  Color selectColor;
  Color textColor;
  Color unSelectedTextColor;
  ChoiceChipData? selectItem;
  Color checkColor;
  Color borderColor;
  double width;
  bool isWrapable;
  double? borderRadius ;

  CustomChoiceChips({
    super.key,
    required this.bgColor,
    required this.borderColor,
    required this.textColor,
    required this.selectColor,
    required this.unSelectedTextColor,
    required this.selectItem,
    required this.checkColor,
    required this.selectedDataOnTap,
    required this.dataList,
    required this.width,
    required this.isWrapable,
    this.borderRadius
  });

  @override
  Widget build(BuildContext context) {
    if (isWrapable == true) {
      return SizedBox(
        width: width,
        child: Wrap(
            children: List.generate(dataList.length, (index) {
          ChoiceChipData data = dataList[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 14, 0),
            child: ChoiceChip(
              selectedColor: selectColor,
              checkmarkColor: selectItem == data
                  ? checkColor
                  : context.colorPalette.cardBackgroundColor,
              showCheckmark: true,
              backgroundColor: bgColor,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1, color: selectItem == data ? context.colorPalette.transparentColor :borderColor),
                  borderRadius: BorderRadius.circular(borderRadius ?? 20)),
              label: Text(data.title,
                  style: context.textThemeDecoration.paragraphMedium.copyWith(
                    color: selectItem == data
                        ? textColor
                        : unSelectedTextColor,
                  )),
              selected: selectItem == data ? true : false,
              onSelected: (bool selected) {
                selectedDataOnTap(data);
              },
            ),
          );
        }).toList()),
      );
    }

    return SizedBox(
      width: width,
      height: context.getScreenHeight(6),
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(dataList.length, (index) {
            ChoiceChipData data = dataList[index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 14, 0),
              child: ChoiceChip(
                selectedColor: selectColor,
                checkmarkColor: selectItem == data
                    ? checkColor
                    : context.colorPalette.cardBackgroundColor,
                showCheckmark: true,
                backgroundColor: bgColor,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1, color: selectItem == data ? context.colorPalette.transparentColor :borderColor),
                    borderRadius: BorderRadius.circular(borderRadius ?? 20)),
                label: Text(data.title,
                    style: context.textThemeDecoration.paragraphMedium.copyWith(
                      color: selectItem == data
                          ? textColor
                          : unSelectedTextColor,
                    )),
                selected: selectItem == data ? true : false,
                onSelected: (bool selected) {
                  selectedDataOnTap(data);
                },
              ),
            );
          }).toList()),
    );
  }
}

