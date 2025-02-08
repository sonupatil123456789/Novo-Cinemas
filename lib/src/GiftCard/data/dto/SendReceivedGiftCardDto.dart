import 'package:equatable/equatable.dart';

import '../../domain/models/SendReceivedGiftCardModel.dart';
import 'SendReceivedDataDto.dart';

class SendReceivedGiftCardDto extends Equatable {
  final List<SendReceivedDataDto> sent;
  final List<SendReceivedDataDto> received;

  const SendReceivedGiftCardDto({
    this.sent = const [],
    this.received = const [],
  });

  factory SendReceivedGiftCardDto.fromJson(Map<String, dynamic> json) =>
      SendReceivedGiftCardDto(
        sent: (json['sent'] as List?)
                ?.map((item) => SendReceivedDataDto.fromJson(item))
                .toList() ??
            [],
        received: (json['received'] as List?)
                ?.map((item) => SendReceivedDataDto.fromJson(item))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        "sent": sent.map((item) => item.toJson()).toList(),
        "received": received.map((item) => item.toJson()).toList(),
      };

  SendReceivedGiftCardDto copyWith({
    List<SendReceivedDataDto>? sent,
    List<SendReceivedDataDto>? received,
  }) =>
      SendReceivedGiftCardDto(
        sent: sent ?? this.sent,
        received: received ?? this.received,
      );

  static SendReceivedGiftCardModel toDomainModel(
      SendReceivedGiftCardDto sendReceivedGiftCardDto) {
    return SendReceivedGiftCardModel(
      sent: sendReceivedGiftCardDto.sent
          .map((toElement) => SendReceivedDataDto.toDomainModel(toElement))
          .toList(),
      received: sendReceivedGiftCardDto.received
          .map((toElement) => SendReceivedDataDto.toDomainModel(toElement))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [sent, received];

  @override
  String toString() {
    return 'SendReceivedGiftCardDto('
        'sent: $sent,'
        'received: $received,'
        ')';
  }
}
