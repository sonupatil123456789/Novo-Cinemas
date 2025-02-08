import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/Dashboard/presentation/components/ReferandEarn.dart';
import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/HeaderTextOne.dart';
import '../../../../components/cards/SeatTicketCard.dart';
import '../../../../components/customcomp/RangeSlider.dart';
import '../../../Tickets/domain/models/ReservationDetailsModel.dart';
import '../../../UserProfile/presentation/components/rewardcard.dart';
import '../../../UserProfile/presentation/components/rewardpopup.dart';
import '../components/BenifitsOverview.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderTextOne( title: 'My Dashboard',),



        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: context.getScreenHeight(1)),

            // Membership Card
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                  "assets/pngassets/novocard.png", // Replace with actual path
                  width: context.getScreenWidth(100)
              ),
            ),
            SizedBox(height: context.getScreenHeight(3)),

            // Subtitle: COOL MEMBER
            Text("COOL MEMBER",
                style: context.textThemeDecoration.titleMedium.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: context.colorPalette.accentColor,
                )),

            SizedBox(height: context.getScreenHeight(2)),

            // Tier Points Section
            buildPointsSection("My Tier Points", "1505 pts",
                "Points expiring within 30 days", "0 pts", context),

            const Divider(color: Colors.yellow, thickness: 1),

            // Spend Points Section
            buildPointsSection("My Spend Points", "72 pts",
                "Points expiring within 30 days", "0 pts", context),
            SizedBox(height: context.getScreenHeight(4)),
            BenefitsOverview(),
            SizedBox(height: context.getScreenHeight(4)),
            Text("Your membership status",
                style: context.textThemeDecoration.titleMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: context.colorPalette.accentColor,
                )),
            SizedBox(height: context.getScreenHeight(.5)),
            const Divider(color: Colors.yellow, thickness: 1),
            SizedBox(height: context.getScreenHeight(3)),

            // Membership Card
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/pngassets/edgemembercard.png", // Replace with actual path
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
              ),
            ),
            SizedBox(height: context.getScreenHeight(3)),

            // Subtitle: COOL MEMBER
            Text("NEXT TIER: EDGE MEMBER",
                style: context.textThemeDecoration.titleMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: context.colorPalette.accentColor,
                )),
            SizedBox(height: context.getScreenHeight(2)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You are 1200 points away",
                  style: context.textThemeDecoration.paragraphMedium.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: context.colorPalette.whiteColor,
                  ),
                ),
                SizedBox(height: context.getScreenHeight(2)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    LinearProgressIndicator(
                      minHeight: 12,
                      value: .5,
                      borderRadius: BorderRadius.circular(12),
                      backgroundColor:
                      context.colorPalette.accentColor.withOpacity(.20),
                      color: context.colorPalette.accentColor,
                    ),
                    Text(
                      "2000",
                      style: context.textThemeDecoration.titleLarge.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: context.colorPalette.whiteColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: context.getScreenHeight(4)),
            Text("refer and earn",
                style: context.textThemeDecoration.titleMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: context.colorPalette.accentColor,
                )),
            SizedBox(height: context.getScreenHeight(.5)),
            const Divider(color: Colors.yellow, thickness: 1),
            SizedBox(height: context.getScreenHeight(3)),
            ReferAndEarn(),
            SizedBox(height: context.getScreenHeight(4)),
            Text("upcoming booking",
                style: context.textThemeDecoration.titleMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: context.colorPalette.accentColor,
                )),
            SizedBox(height: context.getScreenHeight(.5)),
            const Divider(color: Colors.yellow, thickness: 1),
            SizedBox(height: context.getScreenHeight(3)),
            SeatTicketCard(
              reservationDetails: const ReservationDetailsModel(), shareTicket: (String data, String value) {  },
            ),
            SizedBox(height: context.getScreenHeight(4)),
            Text("Your Signup reward",
                style: context.textThemeDecoration.titleMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: context.colorPalette.accentColor,
                )),
            SizedBox(height: context.getScreenHeight(.5)),
            const Divider(color: Colors.yellow, thickness: 1),
            SizedBox(height: context.getScreenHeight(3)),
            RewardCard(
              description: 'avail on your first meal booking',
              imagePath: 'assets/pngassets/novocard.png',
              title: 'yOUR f&b Reward',
              expiryDate: 'Expires on 6th March, 2025',
              onRedeem: () {},
              onViewDetails: () {
                // showDialog(
                //     context: context,
                //     builder: (context) {
                //       return const RewardPopup();
                //     });
              },
            ),
          ],
        ),





      ],
    );
  }
}


Widget buildPointsSection(String leftTitle, String leftValue, String rightTitle,
    String rightValue, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Row for Titles
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(leftTitle,
                style: context.textThemeDecoration.subTitleSmall.copyWith(
                )),
          ),
          SizedBox(width: context.getScreenWidth(1)),
          Expanded(
            child: Text(rightTitle,
                textAlign: TextAlign.start,
                maxLines: 2,
                style: context.textThemeDecoration.subTitleSmall.copyWith()),
          ),
        ],
      ),
      const SizedBox(height: 4),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(leftValue,
                style: context.textThemeDecoration.paragraphSmall.copyWith(
                  fontSize: 20,
                  color: context.colorPalette.accentColor,
                  fontWeight: FontWeight.w700,
                )),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(rightValue,
                textAlign: TextAlign.start,
                style: context.textThemeDecoration.paragraphSmall.copyWith(
                  fontSize: 20,
                  color: context.colorPalette.accentColor,
                  fontWeight: FontWeight.w700,
                )),
          ),
        ],
      ),
    ],
  );
}


