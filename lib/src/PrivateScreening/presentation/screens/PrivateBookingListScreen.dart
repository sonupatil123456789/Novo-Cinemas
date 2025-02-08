

import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';

import '../../../../components/cards/PrivateScreeningCard.dart';


class PrivateBookingListScreen extends StatelessWidget {
  const PrivateBookingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
              height: context.getScreenHeight(8),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Private Bookings",
                    overflow: TextOverflow.ellipsis,
                    style: context.textThemeDecoration.titleLarge.copyWith(
                      color: context.colorPalette.accentColor
                    ),
                  ),
                  Text(
                    "Whether you want to host an intimate gathering or a corporate function, Novo Cinemas offers the perfect venue and a dedicated team of trained professionals to help you stage a memorable event.",
                    overflow: TextOverflow.ellipsis,
                    style: context.textThemeDecoration.paragraphLarge,
                  ),
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: privateScreening.length,
              itemBuilder: (BuildContext context, int index) {

                final data = privateScreening[index];
                return PrivateScreeningCard(
                  privateScreeningData: data,
                  onPressEvent: (BuildContext context, Map<String, dynamic> privateScreeningData) {

                  },);
              }, separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 15,);
            },
            ),
          ),
          const SizedBox(height: 5,)
        ],
      ),
    );
  }
}



List<Map<String, String>> privateScreening = [
  {
    "title": "Birthdays and Celebrations",
    "subtitle": "Movie-themed parties are fun for all ages. You choose a movie; we’ll design your birthday party or celebration around the theme so your special event is exactly that—special.",
    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRc5p21Q2GBiuZ57Sxr_aA9-qD-qiwxaCMlTA&s"
  },
  {
    "title": "Private Screening",
    "subtitle": "Everyone loves the gift of movies. Reward your staff, take your business to the next level, or give your campaign that winning edge with movie ticket giveaways.",
    "image": "https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Ftheatre&psig=AOvVaw2EhHTBk-9r45MiwUSIz8XM&ust=1738310691982000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCMCDs47-nIsDFQAAAAAdAAAAABAE"
  },
  {
    "title": "Corporate Screening",
    "subtitle": "Take your next corporate event to the big screen",
    "image": "https://www.google.com/imgres?q=corporate&imgurl=https%3A%2F%2Fwww.blockadvisors.com%2Fresource-center%2Fwp-content%2Fuploads%2F2023%2F08%2FCorporate-Transparency-Act-Beneficial-Ownership-Report-Text.jpg&imgrefurl=https%3A%2F%2Fwww.blockadvisors.com%2Fresource-center%2Fmanage-your-business%2Fcorporate-transparency-act%2F&docid=OzvFTt0fb_5NlM&tbnid=znx_Fr0S15fa7M&vet=12ahUKEwjhl5Wh_pyLAxXa2jQHHWaZLkEQM3oECBUQAA..i&w=966&h=628&hcb=2&ved=2ahUKEwjhl5Wh_pyLAxXa2jQHHWaZLkEQM3oECBUQAA"
  },
];

