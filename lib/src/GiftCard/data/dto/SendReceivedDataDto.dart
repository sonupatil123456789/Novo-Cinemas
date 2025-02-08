import 'package:equatable/equatable.dart';
import 'package:novocinema/src/GiftCard/domain/models/SendReceivedDataModel.dart';

class SendReceivedDataDto extends Equatable {
  final String cardNumber;
  final int balanceInCents;
  final String expiresAt;
  final String createdAt;
  final String createdByEmail;
  final String sharedWithEmail;

  const SendReceivedDataDto({
    this.cardNumber = '',
    this.balanceInCents = 0,
    this.expiresAt = '',
    this.createdAt = '',
    this.createdByEmail = '',
    this.sharedWithEmail = '',
  });

  factory SendReceivedDataDto.fromJson(Map<String, dynamic> json) =>
      SendReceivedDataDto(
        cardNumber: json["card_number"] ?? '',
        balanceInCents: json["balance_in_cents"] ?? 0,
        expiresAt: json["expires_at"] ?? '',
        createdAt: json["created_at"] ?? '',
        createdByEmail: json["created_by_email"] ?? '',
        sharedWithEmail: json["shared_with_email"] ?? '',
      );

  Map<String, dynamic> toJson() => {
    "card_number": cardNumber,
    "balance_in_cents": balanceInCents,
    "expires_at": expiresAt,
    "created_at": createdAt,
    "created_by_email": createdByEmail,
    "shared_with_email": sharedWithEmail,
  };

  SendReceivedDataDto copyWith({
    String? cardNumber,
    int? balanceInCents,
    String? expiresAt,
    String? createdAt,
    String? createdByEmail,
    String? sharedWithEmail,
  }) =>
      SendReceivedDataDto(
        cardNumber: cardNumber ?? this.cardNumber,
        balanceInCents: balanceInCents ?? this.balanceInCents,
        expiresAt: expiresAt ?? this.expiresAt,
        createdAt: createdAt ?? this.createdAt,
        createdByEmail: createdByEmail ?? this.createdByEmail,
        sharedWithEmail: sharedWithEmail ?? this.sharedWithEmail,
      );

  static SendReceivedDataModel toDomainModel(
      SendReceivedDataDto sendReceivedDataDto) {
    return SendReceivedDataModel(
        cardNumber: sendReceivedDataDto.cardNumber,
        balanceInCents: sendReceivedDataDto.balanceInCents,
        expiresAt: sendReceivedDataDto.expiresAt,
        createdAt: sendReceivedDataDto.createdAt,
        createdByEmail: sendReceivedDataDto.createdByEmail,
        sharedWithEmail: sendReceivedDataDto.sharedWithEmail,
    );
  }

  @override
  List<Object?> get props => [cardNumber,balanceInCents,expiresAt,createdAt,createdByEmail,sharedWithEmail];

  @override
  String toString() {
    return 'SendReceivedDataDto('
        'cardNumber: $cardNumber,'
        'balanceInCents: $balanceInCents,'
        'expiresAt: $expiresAt,'
        'createdAt: $createdAt,'
        'createdByEmail: $createdByEmail,'
        'sharedWithEmail: $sharedWithEmail,'
        ')';
  }
}
