part of 'GiftCardBloc.dart';

class GiftCardState extends Equatable {
  final CurrentAppState loading;
  final CurrentAppState getAllGiftCardState;
  final CurrentAppState buyGiftCardState;
  final CurrentAppState getGiftCardBalanceState;
  final CurrentAppState sendReceivedGiftCardState;
  final CurrentAppState topUpGiftCardState;
  final SendReceivedGiftCardModel? sendReceivedGiftCardsData;
  final AppException? appException;
  TabBarData<GiftCardType>? selectedGiftCardType;
  final AllGiftCardModel? allGiftCardData;
  final Map<String, dynamic> sendGiftCardRequest;
  final String? reservationId;
  final GetCardBalanceModel? cardBalanceModel;
  Map<String, dynamic>? selectedGiftsType;

  GiftCardState(
      {this.reservationId,
      this.getAllGiftCardState = CurrentAppState.INITIAL,
      this.buyGiftCardState = CurrentAppState.INITIAL,
      this.getGiftCardBalanceState = CurrentAppState.INITIAL,
      this.sendReceivedGiftCardState = CurrentAppState.INITIAL,
      this.topUpGiftCardState = CurrentAppState.INITIAL,
      this.selectedGiftCardType,
      this.loading = CurrentAppState.INITIAL,
      this.appException,
      this.allGiftCardData,
      this.sendGiftCardRequest = const {},
      this.cardBalanceModel,
      this.sendReceivedGiftCardsData,
      this.selectedGiftsType = const {}});

  GiftCardState copyWith({
    AllGiftCardModel? allGiftCardData,
    TabBarData<GiftCardType>? selectedGiftCardType,
    AppException? appException,
    CurrentAppState? loading,
    CurrentAppState? getAllGiftCardState,
    CurrentAppState? buyGiftCardState,
    CurrentAppState? getGiftCardBalanceState,
    CurrentAppState? sendReceivedGiftCardState,
    CurrentAppState? topUpGiftCardState,
    Map<String, dynamic>? sendGiftCardRequest,
    String? reservationId,
    GetCardBalanceModel? cardBalanceModel,
    SendReceivedGiftCardModel? sendReceivedGiftCardsData,
    Map<String, dynamic>? selectedGiftsType,
  }) {
    return GiftCardState(
      appException: appException ?? this.appException,
      selectedGiftCardType: selectedGiftCardType ?? this.selectedGiftCardType,
      loading: loading ?? this.loading,
      getAllGiftCardState: getAllGiftCardState ?? this.getAllGiftCardState,
      getGiftCardBalanceState: getGiftCardBalanceState ?? this.getGiftCardBalanceState,
      buyGiftCardState: buyGiftCardState ?? this.buyGiftCardState,
      sendReceivedGiftCardState: sendReceivedGiftCardState ?? this.sendReceivedGiftCardState,
      allGiftCardData: allGiftCardData ?? this.allGiftCardData,
      sendGiftCardRequest: sendGiftCardRequest ?? this.sendGiftCardRequest,
      reservationId: reservationId ?? this.reservationId,
      cardBalanceModel: cardBalanceModel ?? this.cardBalanceModel,
      sendReceivedGiftCardsData: sendReceivedGiftCardsData ?? this.sendReceivedGiftCardsData,
      selectedGiftsType: selectedGiftsType ?? this.selectedGiftsType,
      topUpGiftCardState: topUpGiftCardState ?? this.topUpGiftCardState,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        getAllGiftCardState,
        buyGiftCardState,
        getGiftCardBalanceState,
        sendReceivedGiftCardState,
        selectedGiftCardType,
        appException,
        allGiftCardData,
        sendGiftCardRequest,
        reservationId,
        cardBalanceModel,
        sendReceivedGiftCardsData,
        selectedGiftsType,
        topUpGiftCardState,
      ];
}
