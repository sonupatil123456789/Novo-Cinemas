import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novocinema/components/CustomButton.dart';
import 'package:novocinema/core/constants/ImageConstants.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/Wallet/provider/wallet_provider.dart';
import 'package:novocinema/src/Wallet/screens/add_money_wallet.dart';
import 'package:novocinema/src/Wallet/screens/wallet_balance.dart';
import 'package:novocinema/src/Wallet/screens/wallet_balance_shimmer.dart';
import 'package:novocinema/src/Wallet/screens/wallet_transactions.dart';
import 'package:provider/provider.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({super.key});

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);
    return Column(
      children: [
        if (walletProvider.isAddMoney) ...[const AddMoneyWallet()],
        if (!walletProvider.isAddMoney) ...[
          walletProvider.isFetchingBalance
              ? const WalletBalanceShimmer()
              : const WalletBalance(),
          const SizedBox(height: 24),
          WalletTransactions()
        ],
      ],
    );
  }
}
