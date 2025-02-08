

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';


class TabBarData<T> extends Equatable {
  num Id;
  String title;
  T? data;


  TabBarData(this.Id, this.title, this.data);

  @override
  // TODO: implement props
  List<Object?> get props => [Id, title];
}



class CustomTabBar<T> extends StatelessWidget {
  Function(TabBarData<T> , int) tabPageIndex;
  List<TabBarData<T>> dataList;
  TabBarData<T>? selectedTab;
  dynamic controller;
  double? height ;

  CustomTabBar({
    super.key,
    required this.tabPageIndex,
    required this.dataList ,
    required this.selectedTab,
    required this.controller,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getScreenWidth(100),
      height: context.getScreenHeight(height ?? 7),
      decoration: ShapeDecoration(
        color: context.colorPalette.accentColor.withOpacity(0.12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: TabBar(
          controller:controller,
          dividerColor: Colors.transparent,
          onTap: (index) {
            final TabBarData<T> data = dataList[index];
            tabPageIndex(data , index);
          },
          indicator: ShapeDecoration(
            color: context.colorPalette.accentColor,
            shape: RoundedRectangleBorder(
              side:  BorderSide(width: 2, color: context.colorPalette.accentColor,),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          indicatorPadding: EdgeInsets.symmetric(horizontal: 6, vertical: context.getScreenHeight(0.8)),
          indicatorColor: context.colorPalette.textColor,
          unselectedLabelColor: context.colorPalette.error,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: context.textThemeDecoration.subTitleMedium,
          tabs: List.generate(dataList.length, (index){
            final data = dataList[index];
            print(selectedTab == data);
            return Text(data.title.toUpperCase(),
              style: context.textThemeDecoration.subTitleSmall.copyWith(
                  color: selectedTab == data ?
                  context.colorPalette.darkGreyColor :
                  context.colorPalette.whiteColor
              ),
              textAlign: TextAlign.center,);
          })
      ),
    );
  }
}
