import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:novocinema/core/theams/Utils.dart';

class ReferAndEarn extends StatelessWidget {
  final String referralCode = "gjh78609";
  final int pointsEarned = 106;

  const ReferAndEarn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(203, 151, 0, 0.12), // rgba(203, 151, 0, 0.12)
              Color.fromRGBO(255, 230, 0, 0.024), // rgba(255, 230, 0, 0.024)
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: context.colorPalette.accentColor.withOpacity(.20),
            width: 1,
          )),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Your referral code",
                style: context.textThemeDecoration.paragraphMedium.copyWith(
                  fontWeight: FontWeight.w500,
                  color: context.colorPalette.whiteColor,
                  fontSize: 16,
                )),
          ),
          SizedBox(height: context.getScreenHeight(2)),
          Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: context.colorPalette.accentColor.withOpacity(.50),
                  width: 1,
                )),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(referralCode,
                    style: context.textThemeDecoration.paragraphMedium.copyWith(
                      fontWeight: FontWeight.w500,
                      color: context.colorPalette.accentColor,
                      fontSize: 14,
                    )),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: referralCode));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Copied to clipboard")),
                    );
                  },
                  child: const Icon(
                    Icons.copy,
                    color: Colors.yellow,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: context.getScreenHeight(2)),
          Divider(
            color: context.colorPalette.accentColor.withOpacity(.4),
            thickness: .5,
          ),
          SizedBox(height: context.getScreenHeight(2)),
          Text(
            "$pointsEarned points earned",
            style: context.textThemeDecoration.paragraphMedium.copyWith(
              fontSize: 16,
              color: context.colorPalette.accentColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: context.getScreenHeight(2)),
          Divider(
            color: context.colorPalette.accentColor.withOpacity(.4),
            thickness: .5,
          ),
          SizedBox(height: context.getScreenHeight(2)),
          Container(
            decoration: BoxDecoration(
                color: context.colorPalette.accentColor.withOpacity(.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: context.colorPalette.accentColor.withOpacity(.20),
                  width: 1,
                )),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.share,
                  size: 18,
                  color: context.colorPalette.accentColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Share",
                  style: context.textThemeDecoration.paragraphMedium.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: context.colorPalette.accentColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
