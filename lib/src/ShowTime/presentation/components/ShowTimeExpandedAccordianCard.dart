import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';

class ShowTimeExpandedAccordianCard extends StatelessWidget {
  final List<Widget>children ;
  final String title ;


  const ShowTimeExpandedAccordianCard({super.key,
    required this. title,
    required this. children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getScreenWidth(100),
      child:  ExpansionTile(
          title:  Text(title, style: context.textThemeDecoration.subTitleMedium,),
          // leading: const Icon(Icons.arrow_upward),
          minTileHeight: context.getScreenHeight(6 ),
          enableFeedback: true,
          collapsedIconColor: context.colorPalette.accentColor,
          iconColor: context.colorPalette.accentColor,
          childrenPadding:const EdgeInsets.all(15),
          collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(width: 0.5, color: context.colorPalette.accentColor.withOpacity(0.6))
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), side: BorderSide(width: 0.6, color: context.colorPalette.accentColor)
          ),
          clipBehavior: Clip.antiAlias,
          children: children
      ),
    );
  }
}
