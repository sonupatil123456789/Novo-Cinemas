import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:novocinema/core/theams/Utils.dart';

import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/CustomButton.dart';
import '../../../../components/CustomTextField.dart';
import '../../../../core/constants/RoutesName.dart';
import '../bloc/GiftCardBloc.dart';
import '../components/GitfCardHeaderImage.dart';

class TopUpGiftCard extends StatefulWidget {
  const TopUpGiftCard({super.key});

  @override
  State<TopUpGiftCard> createState() => _TopUpGiftCardState();
}

class _TopUpGiftCardState extends State<TopUpGiftCard> {
  TextEditingController email = TextEditingController();

  @override
  void initState() {
    context.read<GiftCardBloc>().add(const GetAllGiftCardEvent());
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
                "TopUp Gift Card",
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
              child: Column(
                children: [
                  Container(
                    width: context.getScreenWidth(100),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: context.colorPalette.transparentColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: context.colorPalette.accentColor.withOpacity(0.4), width: 0.5)),
                    child: CustomTextField(
                      width: context.getScreenWidth(80),
                      controller: email,
                      validateTextField: [
                        FormBuilderValidators.required(
                          errorText: 'Enter Gift Card Number',
                        )
                      ],
                      getTextFieldValue: (value) {},
                      lable: 'Gift Card Number',
                    ),
                    // child: Column(
                    //   children: [
                    //     BlocBuilder<GiftCardBloc, GiftCardState>(
                    //       builder: (context, giftCardState) {
                    //         return isUserLoggedIn
                    //             ? CustomTabBar<GiftCardType>(
                    //           tabPageIndex:
                    //               (TabBarData<GiftCardType> selected,
                    //               int int) {
                    //             context.read<GiftCardBloc>().add(
                    //                 OnSelectedGiftCardEvent(selected));
                    //           },
                    //           dataList: GiftCardType.values
                    //               .map((giftCard) =>
                    //               TabBarData<GiftCardType>(
                    //                   giftCard.Id,
                    //                   giftCard.name,
                    //                   giftCard))
                    //               .toList(),
                    //           selectedTab:
                    //           giftCardState.selectedGiftCardType,
                    //           controller: _languageTabController,
                    //           height: 7,
                    //         )
                    //             : Container(
                    //           width: context.getScreenWidth(100),
                    //           padding: EdgeInsets.symmetric(
                    //               horizontal: 6,
                    //               vertical: context.getScreenHeight(2)),
                    //           decoration: BoxDecoration(
                    //             color: context.colorPalette.accentColor,
                    //             borderRadius: BorderRadius.circular(12),
                    //           ),
                    //           child: Text(
                    //             GiftCardType.values.first.name
                    //                 .toUpperCase(),
                    //             style: context
                    //                 .textThemeDecoration.subTitleSmall
                    //                 .copyWith(
                    //                 color: context
                    //                     .colorPalette.darkGreyColor),
                    //             textAlign: TextAlign.center,
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //     const SizedBox(
                    //       height: 20,
                    //     ),
                    //     CustomTextField(
                    //       width: context.getScreenWidth(80),
                    //       controller: email,
                    //       validateTextField: (value) {
                    //         FormBuilderValidators.email(
                    //           errorText: 'Enter valid email',
                    //         );
                    //       },
                    //       getTextFieldValue: (value) {},
                    //       lable: 'Email Address',
                    //     ),
                    //     BlocBuilder<GiftCardBloc, GiftCardState>(
                    //       builder: (context, giftCardState) {
                    //         if (giftCardState.selectedGiftCardType?.data ==
                    //             GiftCardType.SEND_GIFTCARD_TO_SOMEONE) {
                    //           return CustomTextField(
                    //             width: context.getScreenWidth(80),
                    //             controller: name,
                    //             validateTextField: (value) {},
                    //             getTextFieldValue: (value) {},
                    //             lable: 'Your Name',
                    //           );
                    //         } else {
                    //           return const SizedBox.shrink();
                    //         }
                    //       },
                    //     ),
                    //     CustomTextField(
                    //       width: context.getScreenWidth(80),
                    //       controller: phoneNumber,
                    //       validateTextField: (value) {},
                    //       getTextFieldValue: (value) {},
                    //       lable: 'Mobile Number',
                    //     ),
                    //   ],
                    // ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      footerHeight: context.getScreenHeight(12),
      footer: Container(
        width: context.getScreenWidth(100),
        height: context.getScreenHeight(8),
        decoration: BoxDecoration(
            color: context.colorPalette.backGroundColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            border:
                Border.symmetric(horizontal: BorderSide(color: context.colorPalette.accentColor))),
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
                if(email.text.isEmpty) {
                  return;
                }
                final Map<String, dynamic> data = {
                  'cardNumber': email.text.trim(),
                };
                context.read<GiftCardBloc>().add(GetSendGiftCardRequestEvent(data));
                Navigator.pushNamed(context, RoutesName.addGiftCardsBalanceScreen, arguments: {
                  'appBarTitle': 'gift card details',
                  'title': 'customizeYourGiftCard',
                  'subTitle': 'sendYourLoveGiftCard',
                  'showQuantity': false,
                });
              },
              width: context.getScreenWidth(100),
            ),
          ],
        ),
      ),
    );
  }
}
