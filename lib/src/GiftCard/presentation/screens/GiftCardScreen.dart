import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/GiftCard/presentation/components/GitfCardHeaderImage.dart';

import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/CustomButton.dart';
import '../../../../core/constants/RoutesName.dart';

class GiftCardScreen extends StatefulWidget {
  const GiftCardScreen({super.key});

  @override
  State<GiftCardScreen> createState() => _GiftCardScreenState();
}

class _GiftCardScreenState extends State<GiftCardScreen> {
  final BorderRadius borderRadius = BorderRadius.circular(12);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ArtBoard(
      header: BackButtonNavBar(
        onBackPress: () {
          Navigator.pop(context);
        },
        center: SizedBox(
          height: double.infinity,
          child: Row(
            children: [
              Text(
                context.language.getText('giftCards'),
                style: context.textThemeDecoration.titleSmall.copyWith(fontWeight: FontWeight.bold),
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
                title: context.language.getText('whoIsThisGiftFor'),
                subTitle: context.language.getText('sendYourLoveGiftCard')),
            SizedBox(height: context.getScreenHeight(5)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data = giftCardData[index];
                    return giftCard(data: data);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 20,
                    );
                  },
                  itemCount: giftCardData.length),
            ),
          ],
        ),
      ),
    );
  }

  Widget giftCard({required Map<String, dynamic> data}) {
    return Container(
      width: context.getScreenWidth(100),
      height: context.getScreenWidth(50),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: context.colorPalette.transparentColor.withOpacity(0.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            context.language.getText(data['Title']),
            style: context.textThemeDecoration.titleLarge
                .copyWith(color: context.colorPalette.accentColor),
          ),
          Text(
            context.language.getText(data['SubTitle']),
            style: context.textThemeDecoration.subTitleLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButton(
            height: context.getScreenHeight(5),
            backgroundColor: context.colorPalette.accentColor,
            text: context.language.getText(data['ButtonText']),
            textColor: context.colorPalette.darkGreyColor,
            onTap: () {
              Navigator.pushNamed(context, data['NavigateTo']);
            },
            width: context.getScreenWidth(40),
          ),
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> giftCardData = [
  <String, dynamic>{
    'Id': 0,
    'Title': 'giftCardTitle1',
    'ButtonText': 'buyNow',
    'NavigateTo': RoutesName.sendGiftCardScreen,
    'SubTitle': 'giftCardSubTitle1'
  },
  <String, dynamic>{
    'Id': 1,
    'Title': 'giftCardTitle2',
    'ButtonText': 'checkBalance',
    'NavigateTo': RoutesName.checkGiftCardsBalanceScreen,
    'SubTitle': 'giftCardSubTitle2'
  },
  <String, dynamic>{
    'Id': 2,
    'Title': 'giftCardTitle3',
    'ButtonText': 'topUp',
    'NavigateTo': RoutesName.topUpGiftCardsScreen,
    'SubTitle': 'giftCardSubTitle3'
  },
];
