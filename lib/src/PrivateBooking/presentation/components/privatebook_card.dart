import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/PrivateBooking/presentation/components/privatescreeningdialog.dart';
import 'package:novocinema/src/PrivateBooking/presentation/screens/privatebooking_steps.dart';

class PrivatebookCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const PrivatebookCard(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(3, 3, 38, 0.50),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  height: 245,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textThemeDecoration.titleMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: context.colorPalette.accentColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: context.textThemeDecoration.titleMedium.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: context.colorPalette.whiteColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const PrivateScreeningDetailDialogBox();
                                });
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: context.colorPalette.accentColor,
                                width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'MORE INFO',
                            style: TextStyle(
                                color: context.colorPalette.accentColor),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return PrivateBookingSteps();
                            }));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.colorPalette.accentColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'BOOK NOW',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
