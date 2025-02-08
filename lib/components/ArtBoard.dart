
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';

class ArtBoard extends StatelessWidget {
  Widget? header;
  double? headerHeight;
  double? footerHeight;
  Widget body;
  Widget? footer;
  dynamic footerLocation;
  // bool isScrollable = false  ;
  double? footerPadding;

  ArtBoard({
    super.key,
    this.header,
    this.headerHeight,
    this.footer,
    // this.isScrollable = false,
    this.footerLocation,
    this.footerHeight ,
    this.footerPadding,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.colorPalette.backGroundColor,
      appBar: header != null
          ? AppBar(
              surfaceTintColor: context.colorPalette.successColor.withOpacity(0.2),
              // scrolledUnderElevation: 0.0,
              backgroundColor: context.colorPalette.successColor.withOpacity(0.2),
              automaticallyImplyLeading: false,
              toolbarHeight: headerHeight ?? context.getScreenHeight(8),
              flexibleSpace: SafeArea(
                child: PreferredSize(
                  preferredSize: const Size(0,0),
                  child: header ?? const SizedBox.shrink(),
                ),
              ),
            )
          : null,

      body: Stack(
        children: [
          Container(
              width: context.getScreenWidth(100),
              height: context.getScreenHeight(100),
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.greenAccent.withOpacity(0.2),
                  Colors.deepPurple.withOpacity(0.2),
                ],
                // stops: [0.5,0.5],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6,sigmaY: 6,),
              child: SafeArea(
                child: body,
              ),
            ),
          ),
        ],
      ),
      // body: Container(
      //   // color: Colors.red,
      //   width: context.getScreenWidth(100),
      //   height: context.getScreenHeight(100),
      //   child: SafeArea(
      //     // child: isScrollable ? SingleChildScrollView(child: body,) : body
      //     child: body,
      //   ),
      // ),
      // floatingActionButtonLocation: footerLocation ?? FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: footer != null
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: footerPadding ?? 0.0),
              decoration:  BoxDecoration(
                color: context.colorPalette.transparentColor,
                borderRadius:const BorderRadius.only(topRight: Radius.circular(12) , topLeft: Radius.circular(12) )
              ),
              width: context.getScreenWidth(100),
              height: footerHeight != null ? footerHeight! + 1 : context.getScreenHeight(8),
              child: footer,
            )
          : null,
    );
  }
}
