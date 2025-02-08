
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:novocinema/components/AppBarSection.dart';
import 'package:novocinema/core/theams/Utils.dart';


class DropDownItemData<T> extends Equatable{
  String title;
  dynamic ID;
  T data ;

  DropDownItemData(this.data,this.title,this.ID);

  @override
  // TODO: implement props
  List<Object?> get props => [ID, title];

}

class CoustomIconDropDown<T> extends StatelessWidget {
  List<DropDownItemData<T>> dataList;
  Color bgColor;
  Function(DropDownItemData<T> ,T) selectedDataOnTap;
  Color textColor;
  String placeHolder;
  Color selectedTextColor;
  Widget Function(String)? customWidget ;
  Color unSelectedTextColor;
  Color selectedDropdownColor;
  DropDownItemData<T>? selectItem;
  Color borderColor;
  double width;
  double height;
  double? borderRadius ;
  double? itemHeight ;
  double? itemWidth ;
  Widget icon ;
  double? paddingValue ;

  CoustomIconDropDown({
        super.key,
        required this.bgColor,
        required this.borderColor,
        required this.textColor,
        required  this.unSelectedTextColor,
        required this.selectedTextColor,
        required this.selectedDropdownColor,
        required this.height,
         this.paddingValue,

        this.customWidget,
        required this.selectItem,
        required this.placeHolder ,
        this.itemHeight,
        required this.selectedDataOnTap,
        required this.dataList,
        required this.width,
        required this.icon,
        this.borderRadius,
        this.itemWidth
      });


  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        
        alignment: AlignmentDirectional.bottomStart,
        customButton: Container(
          width: width,
          height: height,
          padding:  EdgeInsets.symmetric(horizontal: paddingValue ?? 20),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            border:  Border.all(color: borderColor, width: 0.4)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              if(customWidget != null )...[
                Builder(builder: (BuildContext context) {
                  return customWidget!(selectItem?.title ?? '');
                },),

              ]else...[
                Text(selectItem?.title ?? placeHolder ,
                  overflow: TextOverflow.ellipsis,
                  style: context.textThemeDecoration.subTitleLarge.copyWith(
                      fontWeight: FontWeight.w400,
                      color: (selectItem?.title ?? '').isEmpty ? unSelectedTextColor : textColor
                  ),),
              ],

              icon
            ],
          ),
        ),
        items: List.generate(dataList.length,(index) {
          final data = dataList[index];



          return DropdownMenuItem(
            value: data,
            child: Container(
              height: context.getScreenHeight(6),
              padding: const  EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: selectItem==data ? selectedDropdownColor: bgColor
              ),
              child: Row(
                children: [
                  Text(data.title ,
                  style: context.textThemeDecoration.subTitleMedium.copyWith(
                    color: selectItem==data ? selectedTextColor: unSelectedTextColor,
                    fontWeight:selectItem==data ?  FontWeight.w500:FontWeight.w400
                  ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        onChanged: (value) { // Explicitly type the parameter
          if (value != null) {
            selectedDataOnTap(value, value.data); // Call the original method
          }
        },
        dropdownStyleData: DropdownStyleData(
          
          width: itemWidth ?? context.getScreenWidth(80),
          maxHeight: itemHeight ?? context.getScreenHeight(20),
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: context.colorPalette.backGroundColor,
          ),
          offset: const Offset(0, -10),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding:  EdgeInsets.only(left: 10, right: 10),
        ),
      ),
    );
  }
}


