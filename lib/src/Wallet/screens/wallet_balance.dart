import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novocinema/components/CustomButton.dart';
import 'package:novocinema/core/constants/ImageConstants.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/Wallet/provider/wallet_provider.dart';
import 'package:provider/provider.dart';

class WalletBalance extends StatefulWidget {
  const WalletBalance({super.key});

  @override
  State<WalletBalance> createState() => _WalletBalanceState();
}

class _WalletBalanceState extends State<WalletBalance> {
  fetchWalletBalance() async {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    await walletProvider.getWalletBalance();
  }

  @override
  void initState() {
    super.initState();
    fetchWalletBalance();
  }

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.yellow.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Wallet Icon and Title Row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.colorPalette.accentColor.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: SvgPicture.asset(
                  ImageConstants.walletIcon,
                  color: context.colorPalette.accentColor,
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Your Wallet Balance',
                style: context.textThemeDecoration.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Balance Amount
          Text(
            'QAR ${(walletProvider.balance?.balanceAmount ?? 0) / 100}',
            style: context.textThemeDecoration.titleLarge.copyWith(
              color: context.colorPalette.accentColor,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 24),
          // Add Money Button

          CustomButton(
            gradient: LinearGradient(
              colors: [
                context.colorPalette.accentColor,
                context.colorPalette.accentColor.withOpacity(0.5),
              ],
            ),
            textStyle: context.textThemeDecoration.titleSmall.copyWith(
              color: context.colorPalette.accentColor,
              fontSize: 16,
            ),
            height: context.getScreenHeight(6),
            backgroundColor: context.colorPalette.transparentColor,
            iconSpacing: 10,
            text: 'Add Money',
            textColor: context.colorPalette.accentColor,
            onTap: () async {
              walletProvider.setIsAddMoney(true);
            },
            borderColor: Border.all(
                color: context.colorPalette.accentColor.withOpacity(0.5),
                width: 1.0),
            width: context.getScreenWidth(100),
            type: ButtonType.ICON_BUTTON,
            icon: ImageConstants.addMoney,
          ),
        ],
      ),
    );
  }
}
