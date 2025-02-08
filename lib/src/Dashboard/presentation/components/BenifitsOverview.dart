import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';

class BenefitsOverview extends StatelessWidget {
  final List<String> benefits = const [
    "Earn 1 point for every QAR spent at Novo Cinemas",
    "10% bonus spend points on concession purchases",
    "10% bonus spend points on online Bookings",
    "10% off Cool Tickets (Sun-Tue only)",
    "Birthday surprise",
    "Points redeemable for tickets",
  ];

  const BenefitsOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Section Title
        Text(
          "CURRENT BENEFITS OVERVIEW",
          textAlign: TextAlign.center,
          style: context.textThemeDecoration.titleMedium.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: context.colorPalette.accentColor,
          ),
        ),
        SizedBox(height: context.getScreenHeight(2)),
        Divider(color: Colors.yellow, thickness: 1),
        SizedBox(height: context.getScreenHeight(2)),
        // Benefits List
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: benefits.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: context.colorPalette.accentColor.withOpacity(.4)),
                  color: context.colorPalette.accentColor.withOpacity(.20),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    benefits[index],
                    textAlign: TextAlign.center,
                    style: context.textThemeDecoration.paragraphMedium.copyWith(
                      color: context.colorPalette.accentColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
