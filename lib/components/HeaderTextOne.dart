
import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/TextTheamStyle.dart';
import 'package:novocinema/core/theams/Utils.dart';

class HeaderTextOne extends StatelessWidget {
  final String title;

  const HeaderTextOne({super.key, required this.title, });

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: context.getScreenHeight(8),
      width: context.getScreenWidth(100),
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: context.textThemeDecoration.subTitleMedium.copyWith(
              fontFamily: TextThemeDecoration.HamburgerFont,
              color: context.colorPalette.accentColor,
            ),
          ),
          Divider(color: context.colorPalette.accentColor,thickness: 1,)
        ],
      ),
    );
  }
}
