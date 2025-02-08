import 'package:flutter/material.dart';
import 'package:novocinema/core/constants/ImageConstants.dart';
import 'package:novocinema/core/theams/Utils.dart';

class GiftCardHeaderImage extends StatelessWidget {
  final String title;
  final String subTitle;

  const GiftCardHeaderImage({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(ImageConstants.giftCardHeader,
            fit: BoxFit.cover, height: context.getScreenHeight(20)),
        Positioned(
          bottom: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textThemeDecoration.titleLarge
                      .copyWith(color: context.colorPalette.accentColor),
                ),
                const SizedBox(height: 5),
                Text(
                  subTitle,
                  style: context.textThemeDecoration.titleSmall.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
