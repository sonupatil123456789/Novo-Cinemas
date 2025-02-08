import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/core/utils/CurrencyFormater.dart';
import 'package:novocinema/src/GiftCard/presentation/bloc/GiftCardBloc.dart';
import 'package:novocinema/src/GiftCard/presentation/components/PaymentCompletedDialogBox.dart';

import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/CustomButton.dart';
import '../../../../components/CustomTextField.dart';
import '../../../../core/constants/RoutesName.dart';
import '../components/GitfCardHeaderImage.dart';

class CheckGiftCardBalanceScreen extends StatefulWidget {
  const CheckGiftCardBalanceScreen({super.key});

  @override
  State<CheckGiftCardBalanceScreen> createState() => _CheckGiftCardBalanceScreenState();
}

class _CheckGiftCardBalanceScreenState extends State<CheckGiftCardBalanceScreen> {
  bool showBalanceDetails = false;
  final TextEditingController cardNumber = TextEditingController();

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
                'Check balance',
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
                title: context.language.getText('checkYourGiftCardBalance'), subTitle: ''),
            SizedBox(height: context.getScreenHeight(3)),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomTextField(
                          width: context.getScreenWidth(100),
                          controller: cardNumber,
                          keyboardType: TextInputType.number,
                          height: context.getScreenHeight(7),
                          getTextFieldValue: (value) {},
                          lable: 'Enter gift card number',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: context.getScreenHeight(20),
                    ),
                    if (showBalanceDetails)
                      BlocBuilder<GiftCardBloc, GiftCardState>(
                        builder: (context, state) {
                          return Container(
                              width: context.getScreenWidth(100),
                              padding: const EdgeInsets.all(20),
                              height: context.getScreenHeight(20),
                              decoration: BoxDecoration(
                                color: context.colorPalette.darkGreyColor.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Balance',
                                    style: context.textThemeDecoration.subTitleSmall,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${currencyCode()} ${priceConverter(state.cardBalanceModel!.balanceAmount ?? 0)}',
                                    style: context.textThemeDecoration.titleMedium.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: context.colorPalette.accentColor),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      balanceCardInfoTile(context, 'Purchased Date',
                                          '24th Dec 2023', TextDecoration.none),
                                      balanceCardInfoTile(context, 'Invoice Details',
                                          'Download Invoice', TextDecoration.underline)
                                    ],
                                  )
                                ],
                              ));
                        },
                      )
                  ],
                )),
          ],
        ),
      ),
      footer: BlocBuilder<GiftCardBloc, GiftCardState>(
        builder: (context, state) {
          return Container(
            width: context.getScreenWidth(100),
            height: context.getScreenHeight(8),
            decoration: BoxDecoration(
                color: context.colorPalette.backGroundColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                border: Border.symmetric(
                    horizontal: BorderSide(color: context.colorPalette.accentColor))),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  height: context.getScreenHeight(6),
                  backgroundColor: context.colorPalette.accentColor,
                  text: state.getGiftCardBalanceState == CurrentAppState.LOADING
                      ? 'Loading....'
                      : showBalanceDetails
                          ? 'Next'
                          : 'Check Balance Now',
                  textColor: context.colorPalette.darkGreyColor,
                  onTap: () {
                    if (showBalanceDetails) {
                    } else {
                      context.read<GiftCardBloc>().add(GetGiftCardBalanceEvent(
                          cardNumber: cardNumber.text.trim(),
                          onSuccess: (success) {
                            setState(() {
                              showBalanceDetails = true;
                            });
                          },
                          onFailure: (failure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(failure.message)),
                            );
                          }));
                    }
                    // Navigator.pushNamed(context, RoutesName.addGiftCardsBalanceScreen);
                  },
                  width: context.getScreenWidth(100),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget balanceCardInfoTile(
      BuildContext context, String title, String subtitle, TextDecoration decoration) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textThemeDecoration.subTitleMedium,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            subtitle,
            style: context.textThemeDecoration.subTitleLarge.copyWith(decoration: decoration),
          )
        ],
      ),
    );
  }
}
