class WalletBalance {
  final String cardNumber;
  final double balanceAmount;

  WalletBalance({
    required this.cardNumber,
    required this.balanceAmount,
  });

  factory WalletBalance.fromJson(Map<String, dynamic> json) {
    return WalletBalance(
      cardNumber: json['card_number'] ?? '',
      balanceAmount: (json['balance_amount'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'card_number': cardNumber,
      'balance_amount': balanceAmount,
    };
  }

  @override
  String toString() {
    return 'WalletBalance(cardNumber: $cardNumber, balanceAmount: $balanceAmount)';
  }
}
