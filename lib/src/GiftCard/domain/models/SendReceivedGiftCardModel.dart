import 'package:equatable/equatable.dart';

import 'SendReceivedDataModel.dart';


class SendReceivedGiftCardModel extends Equatable {
  final List<SendReceivedDataModel> sent;
  final List<SendReceivedDataModel> received;

  const SendReceivedGiftCardModel({
    this.sent = const [],
    this.received = const [],
  });

  SendReceivedGiftCardModel copyWith({
    List<SendReceivedDataModel>? sent,
    List<SendReceivedDataModel>? received,
  }) =>
      SendReceivedGiftCardModel(
        sent: sent ?? this.sent,
        received: received ?? this.received,
      );

  @override
  List<Object?> get props => [sent, received];

  @override
  String toString() {
    return 'SendReceivedGiftCardModel('
        'sent: $sent,'
        'received: $received,'
        ')';
  }
}
