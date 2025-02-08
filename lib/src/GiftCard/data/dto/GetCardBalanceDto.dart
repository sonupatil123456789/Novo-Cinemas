import 'package:equatable/equatable.dart';

import '../../domain/models/AllGiftCardModel.dart';
import '../../domain/models/GetCardBalanceModel.dart';

class GetCardBalanceDto extends Equatable {
  final String? cardNumber;
  final int? balanceAmount;

  GetCardBalanceDto({
    this.cardNumber = '',
    this.balanceAmount = 0,
  });

  factory GetCardBalanceDto.fromJson(Map<String, dynamic> json) =>
      GetCardBalanceDto(
        cardNumber: json["card_number"] ?? '',
        balanceAmount: json["balance_amount"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "cardNumber": cardNumber,
        "balanceAmount": balanceAmount,
      };

  GetCardBalanceDto copyWith({
    String? cardNumber,
    int? balanceAmount,
  }) =>
      GetCardBalanceDto(
        cardNumber: cardNumber ?? this.cardNumber,
        balanceAmount: balanceAmount ?? this.balanceAmount,
      );

  static GetCardBalanceModel toDomainModel(
      GetCardBalanceDto getCardBalanceDto) {
    return GetCardBalanceModel(
        cardNumber: getCardBalanceDto.cardNumber,
        balanceAmount: getCardBalanceDto.balanceAmount);
  }

  @override
  List<Object?> get props => [cardNumber, balanceAmount];

  @override
  String toString() {
    return 'GetCardBalanceDto('
        'cardNumber: $cardNumber,'
        'balanceAmount: $balanceAmount,'
        ')';
  }
}
