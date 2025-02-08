import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:novocinema/components/ArtBoard.dart';
import 'package:novocinema/core/constants/RoutesName.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/GiftCard/presentation/bloc/GiftCardBloc.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/CustomButton.dart';
import '../../../../components/CustomTextField.dart';
import '../../../../components/customcomp/coustom_tabbar.dart';
import '../../../../core/constants/DatabaseKeyConstants.dart';
import '../../../../core/resources/SeassionManager.dart';
import '../components/GitfCardHeaderImage.dart';

class SendGiftCardScreen extends StatefulWidget {
  const SendGiftCardScreen({super.key});

  @override
  State<SendGiftCardScreen> createState() => _SendGiftCardScreenState();
}

enum GiftCardType {
  SEND_GIFTCARD_TO_SOMEONE(0, 'For Someone'),
  SEND_GIFTCARD_TO_ME(1, 'For me');

  final int Id;
  final String name;

  const GiftCardType(this.Id, this.name);
}

class _SendGiftCardScreenState extends State<SendGiftCardScreen>
    with TickerProviderStateMixin {
  late TabController _languageTabController;
  late final SeassionManager session;
  bool isUserLoggedIn = false;
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  void initState() {
    _getUserAuth(context);
    _languageTabController =
        TabController(length: GiftCardType.values.length, vsync: this);
    context.read<GiftCardBloc>().add(const GetAllGiftCardEvent());
    if (context.read<GiftCardBloc>().state.sendGiftCardRequest.isNotEmpty) {
      name.text = context
          .read<GiftCardBloc>()
          .state
          .sendGiftCardRequest['name']
          .toString()
          .trim();
      email.text = context
          .read<GiftCardBloc>()
          .state
          .sendGiftCardRequest['email']
          .toString()
          .trim();
      phoneNumber.text = context
          .read<GiftCardBloc>()
          .state
          .sendGiftCardRequest['phoneNumber']
          .toString()
          .trim();
    }
    super.initState();
  }

  void _getUserAuth(BuildContext context) async {
    isUserLoggedIn =
        await SeassionManager().getAccessToken(TOKEN) != null ? true : false;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]")
        .hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    } else if (value.length < 9) {
      return 'Enter a valid mobile number';
    }
    return null;
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
                context.language.getText('sendGiftCard'),
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
                        color: context.colorPalette.transparentColor
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: context.colorPalette.accentColor
                                .withOpacity(0.4),
                            width: 0.5)),
                    child: Column(
                      children: [
                        BlocBuilder<GiftCardBloc, GiftCardState>(
                          builder: (context, giftCardState) {
                            return isUserLoggedIn
                                ? CustomTabBar<GiftCardType>(
                                    tabPageIndex:
                                        (TabBarData<GiftCardType> selected,
                                            int int) {
                                      context.read<GiftCardBloc>().add(
                                          OnSelectedGiftCardEvent(selected));
                                    },
                                    dataList: GiftCardType.values
                                        .map((giftCard) =>
                                            TabBarData<GiftCardType>(
                                                giftCard.Id,
                                                giftCard.name,
                                                giftCard))
                                        .toList(),
                                    selectedTab:
                                        giftCardState.selectedGiftCardType,
                                    controller: _languageTabController,
                                    height: 7,
                                  )
                                : Container(
                                    width: context.getScreenWidth(100),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: context.getScreenHeight(2)),
                                    decoration: BoxDecoration(
                                      color: context.colorPalette.accentColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      GiftCardType.values.first.name
                                          .toUpperCase(),
                                      style: context
                                          .textThemeDecoration.subTitleSmall
                                          .copyWith(
                                              color: context
                                                  .colorPalette.darkGreyColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          width: context.getScreenWidth(80),
                          controller: email,
                          validateTextField: [
                            FormBuilderValidators.email(errorText: 'Enter valid email',)
                          ],
                          getTextFieldValue: (value) {},
                          lable: 'Email Address',
                        ),
                        BlocBuilder<GiftCardBloc, GiftCardState>(
                          builder: (context, giftCardState) {
                            if (giftCardState.selectedGiftCardType?.data ==
                                GiftCardType.SEND_GIFTCARD_TO_SOMEONE) {
                              return CustomTextField(
                                width: context.getScreenWidth(80),
                                controller: name,
                                getTextFieldValue: (value) {},
                                lable: 'Your Name',
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                        CustomTextField(
                          width: context.getScreenWidth(80),
                          controller: phoneNumber,
                          getTextFieldValue: (value) {},
                          lable: 'Mobile Number',
                        ),
                      ],
                    ),
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
            border: Border.symmetric(
                horizontal:
                    BorderSide(color: context.colorPalette.accentColor))),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButton(
              height: context.getScreenHeight(6),
              backgroundColor: context.colorPalette.accentColor,
              text: 'Pick a gift card',
              textColor: context.colorPalette.darkGreyColor,
              onTap: () {
                final Map<String, dynamic> data = {
                  'name': name.text.trim(),
                  'email': email.text.trim(),
                  'phoneNumber': phoneNumber.text.trim()
                };
                context
                    .read<GiftCardBloc>()
                    .add(GetSendGiftCardRequestEvent(data));
                Navigator.pushNamed(
                    context, RoutesName.addGiftCardsBalanceScreen,
                    arguments: {
                      'appBarTitle': 'gift card details',
                      'title': 'customizeYourGiftCard',
                      'subTitle': 'sendYourLoveGiftCard',
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
