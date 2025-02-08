import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';

class RewardCard extends StatelessWidget {
  final String imagePath;
  final String expiryDate;
  final String title;
  final String description;
  final VoidCallback onViewDetails;
  final VoidCallback onRedeem;

  const RewardCard({
    Key? key,
    required this.imagePath,
    required this.expiryDate,
    required this.title,
    required this.description,
    required this.onViewDetails,
    required this.onRedeem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.colorPalette.accentColor.withOpacity(.2),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reward Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath, // Dynamic Image Path
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: context.getScreenHeight(2),
          ),
          // Expiry Date
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(7),
              border:
                  Border.all(color: Colors.white.withOpacity(.20), width: 1),
            ),
            child: Text(
              expiryDate,
              style: context.textThemeDecoration.paragraphMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: context.colorPalette.whiteColor,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(height: context.getScreenHeight(2)),
          // Reward Title
          Text(
            title,
            style: context.textThemeDecoration.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: context.colorPalette.accentColor,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            description,
            style: context.textThemeDecoration.paragraphMedium.copyWith(
              fontWeight: FontWeight.w500,
              color: context.colorPalette.whiteColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          // View Details Button
          GestureDetector(
            onTap: onViewDetails,
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                    color: context.colorPalette.accentColor.withOpacity(.20),
                    width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "View details",
                  style: context.textThemeDecoration.paragraphMedium.copyWith(
                    fontSize: 14,
                    color: context.colorPalette.accentColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Redeem Now Button
          GestureDetector(
            onTap: onRedeem,
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
                    style: context.textThemeDecoration.paragraphMedium.copyWith(
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
    );
  }
}
