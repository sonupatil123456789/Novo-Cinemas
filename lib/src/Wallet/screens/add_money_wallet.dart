import 'package:flutter/material.dart';
import 'package:novocinema/components/CustomButton.dart';
import 'package:novocinema/core/constants/ImageConstants.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/Wallet/provider/wallet_provider.dart';
import 'package:provider/provider.dart';

class AddMoneyWallet extends StatefulWidget {
  const AddMoneyWallet({super.key});

  @override
  State<AddMoneyWallet> createState() => _AddMoneyWalletState();
}

class _AddMoneyWalletState extends State<AddMoneyWallet> {
  double amount = 950;
  final List<double> quickAmounts = [150, 250, 550, 1000];

  void _incrementAmount() {
    setState(() {
      amount += 50;
    });
  }

  void _decrementAmount() {
    if (amount >= 50) {
      setState(() {
        amount -= 50;
      });
    }
  }

  void _setAmount(double value) {
    setState(() {
      amount = value;
    });
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: context.colorPalette.blackColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: context.colorPalette.accentColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colorPalette.accentColor.withOpacity(0.2),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check_circle_outline,
                      size: 40,
                      color: context.colorPalette.accentColor,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Success Message
                Text(
                  'MONEY ADDED SUCCESSFULLY!',
                  style: context.textThemeDecoration.titleLarge?.copyWith(
                    color: context.colorPalette.whiteColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Back to Main Page Button
                CustomButton(
                  width: double.infinity,
                  height: 50,
                  text: 'BACK TO MAIN PAGE',
                  textStyle:
                      context.textThemeDecoration.paragraphLarge?.copyWith(
                    color: context.colorPalette.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);
    return Container(
      child: Container(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: context.colorPalette.accentColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Button and Title
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    walletProvider.setIsAddMoney(false);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: context.colorPalette.accentColor,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Add money to your wallet',
                  style: context.textThemeDecoration.paragraphLarge?.copyWith(
                    color: context.colorPalette.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Amount Input Section
            Text(
              'ENTER AMOUNT',
              style: context.textThemeDecoration.titleMedium,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircularButton(
                  icon: Icons.remove,
                  onTap: _decrementAmount,
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color:
                            context.colorPalette.accentColor.withOpacity(0.3),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'QAR ${amount.toStringAsFixed(0)}',
                        style: context.textThemeDecoration.paragraphLarge
                            ?.copyWith(
                          color: context.colorPalette.whiteColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                _buildCircularButton(
                  icon: Icons.add,
                  onTap: _incrementAmount,
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Quick Amount Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 2.5,
              children: quickAmounts.map((quickAmount) {
                return InkWell(
                  onTap: () => _setAmount(quickAmount),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color:
                            context.colorPalette.accentColor.withOpacity(0.3),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'QAR ${quickAmount.toStringAsFixed(0)}',
                        style:
                            context.textThemeDecoration.titleMedium?.copyWith(
                          color: context.colorPalette.whiteColor,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 40),

            // Terms & Conditions
            Text(
              'Terms & conditions',
              style: context.textThemeDecoration.titleMedium,
            ),
            const SizedBox(height: 16),
            _buildTermItem(
              'Wallet money cannot be transferred to a bank account as per guidelines',
              context,
            ),
            const SizedBox(height: 8),
            _buildTermItem(
              'Wallet money is useable for purchasing gift cards, movie tickets booking etc',
              context,
            ),
            const SizedBox(height: 8),
            _buildTermItem(
              'Wallet money is useable for purchasing gift cards, movie tickets booking etc',
              context,
            ),
            // const Spacer(),

            const SizedBox(height: 20),

            // // Pay Button
            CustomButton(
              width: double.infinity,
              height: 50,
              text: 'Pay',
              type: ButtonType.ICON_BUTTON,
              icon: ImageConstants.walletIcon,
              iconColor: context.colorPalette.blackColor,
              textStyle: context.textThemeDecoration.titleLarge?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: context.colorPalette.blackColor,
              ),
              onTap: () {
                walletProvider
                    .topUpWallet(amount.toInt(), "3", "2975")
                    .then((value) {
                  if (value) {
                    _showSuccessDialog(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Failed to top up wallet"),
                      ),
                    );
                  }
                });
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: context.colorPalette.accentColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: context.colorPalette.accentColor.withOpacity(0.3),
          ),
        ),
        child: Icon(
          icon,
          color: context.colorPalette.accentColor,
        ),
      ),
    );
  }

  Widget _buildTermItem(String text, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: context.colorPalette.whiteColor.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: context.textThemeDecoration.paragraphMedium?.copyWith(
              color: context.colorPalette.whiteColor.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
