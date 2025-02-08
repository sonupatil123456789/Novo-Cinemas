import 'package:equatable/equatable.dart';

class GetCardBalanceModel extends Equatable {
  final String? cardNumber;
  final int? balanceAmount;

  GetCardBalanceModel({
    this.cardNumber = '',
    this.balanceAmount = 0,
  });

  GetCardBalanceModel copyWith({
    String? cardNumber,
    int? balanceAmount,
  }) =>
      GetCardBalanceModel(
        cardNumber: cardNumber ?? this.cardNumber,
        balanceAmount: balanceAmount ?? this.balanceAmount,
      );

  @override
  List<Object?> get props => [cardNumber, balanceAmount];

  @override
  String toString() {
    return 'GetCardBalanceModel('
        'cardNumber: $cardNumber,'
        'balanceAmount: $balanceAmount,'
        ')';
  }
}
