import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:novocinema/core/theams/Utils.dart';

import '../dartassets/novoHeaderLogo.dart';

class BackButtonNavBar extends StatelessWidget {
  final Function onBackPress;
  final Widget? center;
  final Color? backgroundColor;

  const BackButtonNavBar(
      {super.key,
      required this.onBackPress,
      this.center,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.getScreenWidth(4)),
      height: context.getScreenHeight(20),
      color: backgroundColor,
      // color: Colors.greenAccent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              onBackPress();
            },
            child: SizedBox(
              width: context.getScreenWidth(10),
              height: context.getScreenHeight(16),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 21,
              ),
            ),
          ),
          SizedBox(
            width: context.getScreenWidth(5),
          ),
          Expanded(child: center ?? const SizedBox.shrink())
        ],
      ),
    );
  }
}
