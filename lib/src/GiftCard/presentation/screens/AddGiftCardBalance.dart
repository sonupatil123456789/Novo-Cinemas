import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/di.dart';
import 'package:novocinema/src/GiftCard/presentation/bloc/GiftCardBloc.dart';
import 'package:novocinema/src/GiftCard/presentation/components/AddBalanceCounter.dart';
import '../../../../components/ArtBoard.dart';
import '../../../../components/BackButtonNavbar.dart';
import '../../../../components/CustomButton.dart';
import '../../../../components/CustomTextField.dart';
import '../../../../core/constants/RoutesName.dart';
import '../components/GitfCardHeaderImage.dart';

class AddGiftCardBalance extends StatefulWidget {
  final String appBarTitle;
  final String title;
  final String subTitle;
  final bool showQuantity;

  AddGiftCardBalance(
      {super.key,
      required this.appBarTitle,
      required this.title,
      required this.subTitle,
      this.showQuantity = true});

  @override
  State<AddGiftCardBalance> createState() => _AddGiftCardBalanceState();
}

class _AddGiftCardBalanceState extends State<AddGiftCardBalance> {
  TextEditingController quantity = TextEditingController();

  // num addBalance = 10;

  @override
  void initState() {
    quantity.text = '1';
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
                widget.appBarTitle,
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
                title: context.language.getText(widget.title),
                subTitle: context.language.getText(widget.subTitle)),
            SizedBox(height: context.getScreenHeight(5)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: context.getScreenWidth(100),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: context.colorPalette.transparentColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: context.colorPalette.accentColor.withOpacity(0.4), width: 0.5)),
                child: BlocBuilder<GiftCardBloc, GiftCardState>(builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Custom Gift Card',
                        style: context.textThemeDecoration.subTitleSmall,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Price',
                        style: context.textThemeDecoration.subTitleSmall,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AddBalanceCounter(
                          initialCount: state.allGiftCardData!.minPrice ?? 0,
                          disabledAddButton: false,
                          iconSize: 10,
                          onClickPlus: (int value) {
                            print("gift card increment ${value}");
                            final Map<String, dynamic> data = {'price': value * 100};
                            context.read<GiftCardBloc>().add(GetSendGiftCardRequestEvent(data));
                          },
                          onClickMinus: (int value) {
                            print(value);
                            final Map<String, dynamic> data = {'price': value * 100};
                            context.read<GiftCardBloc>().add(GetSendGiftCardRequestEvent(data));
                          },
                          disabledRemoveButton: false),
                      const SizedBox(
                        height: 20,
                      ),
                      if (widget.showQuantity)
                        CustomTextField(
                          width: context.getScreenWidth(80),
                          controller: quantity,
                          keyboardType: TextInputType.number,
                          getTextFieldValue: (value) {},
                          lable: 'Quantity',
                        ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      footerHeight: context.getScreenHeight(12),
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
                  text: state.buyGiftCardState == CurrentAppState.LOADING ? 'Loading...' : 'Next',
                  isDisabled: state.buyGiftCardState == CurrentAppState.LOADING,
                  textColor: context.colorPalette.darkGreyColor,
                  onTap: () {
                    if(widget.showQuantity) {
                      final Map<String, dynamic> data = {
                        'quantity': int.parse(quantity.text.trim()),
                      };
                      context.read<GiftCardBloc>().add(BuyGiftCardEvent(
                          confirmationDetails: data,
                          onSuccess: (success) {
                            Navigator.pushNamed(context, RoutesName.giftCardOrderSummeryScreen);
                          },
                          onFailure: (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error.message)),
                            );
                          }));
                    } else {
                      context.read<GiftCardBloc>().add(TopUpGiftCardEvent(
                          confirmationDetails: {},
                          onSuccess: (success) {
                            Navigator.pushNamed(context, RoutesName.giftCardOrderSummeryScreen);
                          },
                          onFailure: (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error.message)),
                            );
                          }));
                    }
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
}
