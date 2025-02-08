import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/Search/domain/models/SearchCinemaModel.dart';




class SearchLocationCard extends StatelessWidget {
  SearchCinemaModel locationData;
  void Function(BuildContext context, SearchCinemaModel searchLocation) onPressEvent;

  SearchLocationCard({super.key, required this.locationData, required this.onPressEvent});


  @override
  Widget build(BuildContext context) {


    final cardWidth = context.getScreenWidth(100);
    final cardHeight = context.getScreenHeight(5);

    return GestureDetector(
      onTap: () {
        onPressEvent(context, locationData);
      },
      child: Container(
        height: cardHeight, alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.circular(12),
              border: Border.all(color:context.colorPalette.accentColor ,width: 0 )
        ),
        width: cardWidth,
        child: Text(
            locationData.name ?? '',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: context.textThemeDecoration.titleSmall
        ),
      ),
    );
  }
}

