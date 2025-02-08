import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';

class RewardPopup extends StatelessWidget {
  const RewardPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: context.colorPalette.accentColor.withOpacity(.5),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: context.colorPalette.blackColor, // Dark background color
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Close Button
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon:
                    Icon(Icons.close, color: context.colorPalette.accentColor),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            /// Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/pngassets/novocard.png',
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "F & B REWARD",
              style: context.textThemeDecoration.titleMedium.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: context.colorPalette.accentColor,
              ),
            ),

            const SizedBox(height: 8),

            /// Divider
            Container(
              width: double.infinity,
              height: 1,
              color: context.colorPalette.accentColor,
            ),

            const SizedBox(height: 20),

            /// Reward Details
            _buildRewardDetail(context, "Expires on 4th March, 2025"),
            _buildRewardDetail(context, "Can be redeemed on first 5 orders"),
            _buildRewardDetail(
                context, "What you get - Fries, Hotdog, and 2 Cokes"),
            _buildRewardDetail(
                context, "Further details: will come here if any"),

            const SizedBox(height: 20),

            /// Redeem Button
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(255, 221, 0, 0.2),
                        Color.fromRGBO(153, 133, 0, 0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: context.colorPalette.accentColor.withOpacity(.20),
                      width: 1,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_upward_outlined,
                        color: context.colorPalette.accentColor),
                    const SizedBox(width: 6),
                    Text(
                      "Redeem Now",
                      style:
                          context.textThemeDecoration.paragraphMedium.copyWith(
                        fontSize: 14,
                        color: context.colorPalette.accentColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper method to create bullet-point reward details
  Widget _buildRewardDetail(BuildContext context, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("• ",
            style: TextStyle(
                color: context.colorPalette.whiteColor, fontSize: 16)),
        Expanded(
          child: Text(
            text,
            style: context.textThemeDecoration.paragraphLarge.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: context.colorPalette.textColor,
            ),
          ),
        ),
      ],
    );
  }
}
