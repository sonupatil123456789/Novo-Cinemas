import 'package:flutter/material.dart';

import 'package:novocinema/core/theams/Utils.dart';

class PrivateBookingsHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const PrivateBookingsHeader(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textThemeDecoration.titleLarge.copyWith(
              color: context.colorPalette.accentColor,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: context.textThemeDecoration.titleMedium.copyWith(
              color: context.colorPalette.whiteColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
