class WalletTransactionModel {
  final String action;
  final int amountInCents;
  final DateTime createdAt;

  WalletTransactionModel({
    required this.action,
    required this.amountInCents,
    required this.createdAt,
  });

  // Convert amount from cents to dollars/main currency unit
  double get amount => amountInCents / 100;

  // Factory constructor to create a WalletTransactionModel from JSON
  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) {
    return WalletTransactionModel(
      action: json['action'] ?? '',
      amountInCents: json['amount_in_cents'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'action': action,
      'amount_in_cents': amountInCents,
      'created_at': createdAt.toIso8601String(),
    };
  }

  // Static method to parse a list of transactions
  static List<WalletTransactionModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => WalletTransactionModel.fromJson(json))
        .toList();
  }
}
