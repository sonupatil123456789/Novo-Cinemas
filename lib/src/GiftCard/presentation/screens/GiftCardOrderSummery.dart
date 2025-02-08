import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';

import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/CustomButton.dart';
import '../components/GitfCardHeaderImage.dart';
import '../components/OrderSummeryCard.dart';
import '../components/PaymentCompletedDialogBox.dart';

class GiftCardOrderSummery extends StatelessWidget {
  const GiftCardOrderSummery({super.key});

  @override
  Widget build(BuildContext context) {
    return ArtBoard(
      header: BackButtonNavBar(
        onBackPress: () {
          Navigator.pop(context);
        },
        center: Container(
          height: double.infinity,
          child: Row(
            children: [
              Text(
                'Checkout',
                style: context.textThemeDecoration.titleSmall
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GiftCardHeaderImage(
                title: context.language.getText('yourOrderSummary'),
                subTitle: context.language.getText('yourOrderDetails')),
            SizedBox(height: context.getScreenHeight(5)),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child:Column(
                  children: [
                    OrderSummeryCard()
                  ],
                )
            ),
          ],
        ),
      ),
      footer:  Container(
        color: context.colorPalette.backGroundColor,
        width: context.getScreenWidth(100),
        height: context.getScreenHeight(8),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButton(
              height: context.getScreenHeight(6),
              backgroundColor: context.colorPalette.accentColor,
              text: 'Next',
              textColor: context.colorPalette.darkGreyColor,
              onTap: () {
                showDialog(context: context,
                  builder: (context) => const PaymentCompletedDialogBox(),);
              },
              width: context.getScreenWidth(100),
            ),
          ],
        ),
      ),
    );
  }
}