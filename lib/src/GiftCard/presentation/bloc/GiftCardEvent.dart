part of 'GiftCardBloc.dart';

sealed class GiftCardEvent extends Equatable {
  const GiftCardEvent();

  @override
  List<Object> get props => [];
}

class OnSelectedGiftCardEvent extends GiftCardEvent {
  final TabBarData<GiftCardType> giftCardType;

  const OnSelectedGiftCardEvent(this.giftCardType);

  @override
  List<Object> get props => [giftCardType];
}

class OnSelectedGiftTypeEvent extends GiftCardEvent {
  final Map<String, dynamic> giftCardType;

  const OnSelectedGiftTypeEvent(this.giftCardType);

  @override
  List<Object> get props => [giftCardType];
}

class GetAllGiftCardEvent extends GiftCardEvent {
  const GetAllGiftCardEvent();

  @override
  List<Object> get props => [];
}

class GetSendGiftCardRequestEvent extends GiftCardEvent {
  final Map<String, dynamic> requestData;

  GetSendGiftCardRequestEvent(this.requestData);

  @override
  List<Object> get props => [requestData];
}

class BuyGiftCardEvent extends GiftCardEvent {
  final Map<String, dynamic> confirmationDetails;
  final Function(String) onSuccess;

  final Function(AppException) onFailure;

  const BuyGiftCardEvent(
      {required this.confirmationDetails, required this.onSuccess, required this.onFailure});

  @override
  List<Object> get props => [confirmationDetails, onFailure, onSuccess];
}

class GetGiftCardBalanceEvent extends GiftCardEvent {
  final String cardNumber;
  final Function(String) onSuccess;
  final Function(AppException) onFailure;

  const GetGiftCardBalanceEvent(
      {required this.cardNumber, required this.onSuccess, required this.onFailure});

  @override
  List<Object> get props => [cardNumber, onFailure, onSuccess];
}

class GetSendReceivedGiftCardsEvent extends GiftCardEvent {
  const GetSendReceivedGiftCardsEvent();

  @override
  List<Object> get props => [];
}

class TopUpGiftCardEvent extends GiftCardEvent {
  final Map<String, dynamic> confirmationDetails;
  final Function(String) onSuccess;

  final Function(AppException) onFailure;

  const TopUpGiftCardEvent(
      {required this.confirmationDetails, required this.onSuccess, required this.onFailure});

  @override
  List<Object> get props => [confirmationDetails, onFailure, onSuccess];
}
