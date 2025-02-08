import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/src/Wallet/provider/wallet_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';

class WalletTransactions extends StatefulWidget {
  const WalletTransactions({super.key});

  @override
  State<WalletTransactions> createState() => _WalletTransactionsState();
}

class _WalletTransactionsState extends State<WalletTransactions>
    with SingleTickerProviderStateMixin {
  final List<String> filters = ['All', 'Additions', 'Deductions'];
  int selectedFilterIndex = 0;

  fetchWalletTransactions() async {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    await walletProvider.getWalletTransactions();
  }

  @override
  void initState() {
    super.initState();
    fetchWalletTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // color: context.colorPalette.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.colorPalette.accentColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TRANSACTION HISTORY',
            style: context.textThemeDecoration.titleMedium,
          ),
          const SizedBox(height: 20),
          // Horizontal Filter List
          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final isSelected = selectedFilterIndex == index;
                return Container(
                  margin: EdgeInsets.only(
                    right: index != filters.length - 1 ? 12 : 0,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedFilterIndex = index;
                        });
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? context.colorPalette.accentColor
                              : context.colorPalette.accentColor
                                  .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            filters[index],
                            style: context.textThemeDecoration.titleSmall
                                ?.copyWith(
                              color: isSelected
                                  ? Colors.black
                                  : context.colorPalette.accentColor,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // Transaction List
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: _buildTransactionsList(
              type: selectedFilterIndex == 0
                  ? null
                  : filters[selectedFilterIndex].toLowerCase(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList({String? type}) {
    return Consumer<WalletProvider>(
      builder: (context, walletProvider, child) {
        if (walletProvider.isFetchingTransactions) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 5, // Show 5 shimmer items while loading
            itemBuilder: (context, index) {
              return _buildShimmerEffect();
            },
          );
        }

        final transactions = walletProvider.transactions;

        // Filter transactions based on type
        final filteredTransactions = type == null
            ? transactions
            : transactions.where((transaction) {
                if (type == 'additions') {
                  return transaction.action == 'credited';
                } else if (type == 'deductions') {
                  return transaction.action == 'debited';
                }
                return true;
              }).toList();

        if (filteredTransactions.isEmpty) {
          return Center(
            child: Text(
              'No transactions found',
              style: context.textThemeDecoration.titleSmall,
            ),
          );
        }

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: filteredTransactions.length,
          itemBuilder: (context, index) {
            final transaction = filteredTransactions[index];
            return _TransactionItem(
              icon: _getTransactionIcon(transaction.action),
              title: _getTransactionTitle(transaction.action),
              date: DateFormat('dd MMM, yyyy').format(transaction.createdAt),
              amount:
                  '${transaction.action == 'credited' ? '+' : '-'}QAR ${transaction.amount.toStringAsFixed(2)}',
            );
          },
        );
      },
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: context.colorPalette.blackColor.withOpacity(0.3),
      highlightColor: context.colorPalette.blackColor.withOpacity(0.1),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.colorPalette.blackColor.withOpacity(0.3),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 20,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 100,
                    height: 16,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Container(
              width: 80,
              height: 20,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getTransactionIcon(String action) {
    switch (action) {
      case 'credited':
        return Icons.arrow_downward;
      case 'debited':
        return Icons.arrow_upward;
      default:
        return Icons.swap_horiz;
    }
  }

  String _getTransactionTitle(String action) {
    switch (action) {
      case 'credited':
        return 'Balance Added';
      case 'debited':
        return 'Amount Debited';
      default:
        return 'Transaction';
    }
  }
}

class _TransactionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String date;
  final String amount;

  const _TransactionItem({
    required this.icon,
    required this.title,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.colorPalette.blackColor.withOpacity(0.3),
        border: Border.all(
          color: context.colorPalette.whiteColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: context.colorPalette.accentColor.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              color: context.colorPalette.accentColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textThemeDecoration.paragraphLarge?.copyWith(
                    color: context.colorPalette.whiteColor,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: context.textThemeDecoration.paragraphLarge?.copyWith(
                      color: context.colorPalette.whiteColor.withOpacity(0.5),
                      fontSize: 16),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: context.textThemeDecoration.titleSmall?.copyWith(
              color: context.colorPalette.accentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
