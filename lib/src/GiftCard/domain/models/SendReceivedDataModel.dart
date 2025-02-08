import 'package:equatable/equatable.dart';

class SendReceivedDataModel extends Equatable {
  final String cardNumber;
  final int balanceInCents;
  final String expiresAt;
  final String createdAt;
  final String createdByEmail;
  final String sharedWithEmail;

  const SendReceivedDataModel({
    this.cardNumber = '',
    this.balanceInCents = 0,
    this.expiresAt = '',
    this.createdAt = '',
    this.createdByEmail = '',
    this.sharedWithEmail = '',
  });

  SendReceivedDataModel copyWith({
    String? cardNumber,
    int? balanceInCents,
    String? expiresAt,
    String? createdAt,
    String? createdByEmail,
    String? sharedWithEmail,
  }) =>
      SendReceivedDataModel(
        cardNumber: cardNumber ?? this.cardNumber,
        balanceInCents: balanceInCents ?? this.balanceInCents,
        expiresAt: expiresAt ?? this.expiresAt,
        createdAt: createdAt ?? this.createdAt,
        createdByEmail: createdByEmail ?? this.createdByEmail,
        sharedWithEmail: sharedWithEmail ?? this.sharedWithEmail,
      );

  @override
  List<Object?> get props => [cardNumber,balanceInCents,expiresAt,createdAt,createdByEmail,sharedWithEmail];

  @override
  String toString() {
    return 'SendReceivedDataModel('
        'cardNumber: $cardNumber,'
        'balanceInCents: $balanceInCents,'
        'expiresAt: $expiresAt,'
        'createdAt: $createdAt,'
        'createdByEmail: $createdByEmail,'
        'sharedWithEmail: $sharedWithEmail,'
        ')';
  }
}
