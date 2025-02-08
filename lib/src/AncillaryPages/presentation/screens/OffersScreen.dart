import 'package:flutter/material.dart';

import '../../../../components/ArtBoard.dart';

class OffersAndPromoScreen extends StatelessWidget {
  const OffersAndPromoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ArtBoard(
        body: const Center(
          child: Text("OFFERS SECTION"),
        ));
  }
}