import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/PrivateBooking/presentation/components/privatebook_card.dart';
import 'package:novocinema/src/PrivateBooking/presentation/components/theader_section.dart';

class PrivateBooking extends StatefulWidget {
  const PrivateBooking({super.key});

  @override
  State<PrivateBooking> createState() => _PrivateBookingState();
}

class _PrivateBookingState extends State<PrivateBooking> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const PrivateBookingsHeader(
            title: 'Private Bookings',
            subtitle:
                'Whether you want to host an intimate gathering or a corporate function, Novo Cinemas offers the perfect venue and a dedicated team of trained professionals to help you stage a memorable event.',
          ),
          SizedBox(
            height: context.getScreenHeight(.3),
          ),
          const PrivatebookCard(
            image: 'assets/pngassets/birthday.jpeg',
            title: 'Birthdays and Celebrations',
            subtitle:
                'Movie-themed parties are fun for all ages. You choose a movie; we’ll design your birthday party or celebration around the theme so your special event is exactly that—special.',
          ),
          SizedBox(
            height: context.getScreenHeight(0.2),
          ),
          const PrivatebookCard(
            image: 'assets/pngassets/privatescreening.jpeg',
            title: 'Private Screening',
            subtitle:
                'Everyone loves the gift of movies. Reward your staff, take your business to the next level, or give your campaign that winning edge with movie ticket giveaways.',
          ),
        ],
      ),
    );
  }
}
