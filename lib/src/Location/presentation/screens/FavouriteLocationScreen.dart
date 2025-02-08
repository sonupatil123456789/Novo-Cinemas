import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/HeaderTextOne.dart';


class FavouriteLocationScreen extends StatelessWidget {
  const FavouriteLocationScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return ArtBoard(
        header: BackButtonNavBar(onBackPress: () {
          Navigator.pop(context);
        }),
        body: const Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              HeaderTextOne( title: 'My Dashboard',),

            ],  
          ),
        ),
    );
  }
}


