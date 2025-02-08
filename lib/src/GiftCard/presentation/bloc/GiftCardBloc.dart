import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novocinema/src/GiftCard/domain/models/AllGiftCardModel.dart';
import 'package:novocinema/src/GiftCard/domain/models/SendReceivedGiftCardModel.dart';
import 'package:novocinema/src/GiftCard/domain/useCases/BuyGiftCardUseCase.dart';
import 'package:novocinema/src/GiftCard/domain/useCases/GetAllGiftCardUseCase.dart';
import 'package:novocinema/src/GiftCard/domain/useCases/SendReceivedGiftCardUseCase.dart';

import '../../../../components/customcomp/coustom_tabbar.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/utils/Logger.dart';
import '../../domain/models/GetCardBalanceModel.dart';
import '../../domain/useCases/GetGiftCardBalanceUseCase.dart';
import '../../domain/useCases/TopUpGiftCardUseCase.dart';
import '../screens/SendGiftCardScreen.dart';

part 'GiftCardEvent.dart';

part 'GiftCardState.dart';

class GiftCardBloc extends Bloc<GiftCardEvent, GiftCardState> {
  final GetAllGiftCardUseCase getAllGiftCardUseCase;
  final BuyGiftCardUseCase buyGiftCardUseCase;
  final GetGiftCardBalanceUseCase qetGiftCardBalanceUseCase;
  final SendReceivedGiftCardUseCase sendReceivedGiftCardUseCase;
  final TopUpGiftCardUseCase topUpGiftCardUseCase;

  GiftCardBloc(this.getAllGiftCardUseCase, this.buyGiftCardUseCase, this.qetGiftCardBalanceUseCase,
      this.sendReceivedGiftCardUseCase, this.topUpGiftCardUseCase)
      : super(GiftCardState(
            selectedGiftCardType: TabBarData<GiftCardType>(GiftCardType.values.first.Id,
                GiftCardType.values.first.name, GiftCardType.SEND_GIFTCARD_TO_SOMEONE),
            selectedGiftsType: const {'Id': 0, 'Name': 'Gift Cards Received'})) {
    on<OnSelectedGiftCardEvent>(_onSelectedGiftCardEvent);
    on<OnSelectedGiftTypeEvent>(_onSelectedGiftTypeEvent);
    on<GetAllGiftCardEvent>(_getAllGiftCardEvent);
    on<GetSendGiftCardRequestEvent>(_getSendGiftCardRequestEvent);
    on<BuyGiftCardEvent>(_buyGiftCardEvent);
    on<GetGiftCardBalanceEvent>(_getGiftCardBalanceEvent);
    on<GetSendReceivedGiftCardsEvent>(_getSendReceivedGiftCardsEvent);
    on<TopUpGiftCardEvent>(_topUpGiftCardEvent);
  }

  _onSelectedGiftCardEvent(OnSelectedGiftCardEvent event, Emitter<GiftCardState> emit) {
    emit(state.copyWith(selectedGiftCardType: event.giftCardType));
    Logger.customLogData("Selected Gift Card", state.selectedGiftCardType);
  }

  _onSelectedGiftTypeEvent(OnSelectedGiftTypeEvent event, Emitter<GiftCardState> emit) {
    Logger.customLogData("sendReceivedGiftCardsData Before", state.sendReceivedGiftCardsData?.sent.toString());
    emit(state.copyWith(selectedGiftsType: event.giftCardType));
    Logger.customLogData("sendReceivedGiftCardsData ", state.sendReceivedGiftCardsData?.sent.toString());
  }

  Future<void> _getAllGiftCardEvent(GetAllGiftCardEvent event, Emitter<GiftCardState> emit) async {
    emit(state.copyWith(getAllGiftCardState: CurrentAppState.LOADING));
    final allGiftCard = await getAllGiftCardUseCase.call(EmptyParams());
    switch (allGiftCard) {
      case Success<AllGiftCardModel>():
        emit(state.copyWith(
            getAllGiftCardState: CurrentAppState.SUCCESS, allGiftCardData: allGiftCard.data));
      case Error<AllGiftCardModel>():
        emit(state.copyWith(
            getAllGiftCardState: CurrentAppState.ERROR, appException: allGiftCard.exception));
    }
  }

  _getSendGiftCardRequestEvent(GetSendGiftCardRequestEvent event, Emitter<GiftCardState> emit) {
    final Map<String, dynamic> data = event.requestData;
    emit(state.copyWith(sendGiftCardRequest: {...state.sendGiftCardRequest ?? {}, ...data}));
    Logger.customLogData("Send Request Gift Card", state.sendGiftCardRequest);
  }

  _buyGiftCardEvent(BuyGiftCardEvent event, Emitter<GiftCardState> emit) async {
    emit(state.copyWith(
        sendGiftCardRequest: {...event.confirmationDetails ?? {}, ...state.sendGiftCardRequest},
        buyGiftCardState: CurrentAppState.LOADING));

    final Map<String, dynamic> requestData = {
      "cinemaId": state.allGiftCardData!.cinemaId ?? '',
      "itemId": state.allGiftCardData!.id ?? '',
      "quantity": state.sendGiftCardRequest['quantity'],
      "variablePriceInCents": state.sendGiftCardRequest['price'],
      "purchasedFor": state.sendGiftCardRequest['email'],
    };

    final buyGiftCardData = await buyGiftCardUseCase.call(requestData);

    switch (buyGiftCardData) {
      case Success<String>():
        emit(state.copyWith(
            buyGiftCardState: CurrentAppState.SUCCESS, reservationId: buyGiftCardData.data));
        event.onSuccess(buyGiftCardData.data);
      case Error<String>():
        emit(state.copyWith(
            buyGiftCardState: CurrentAppState.ERROR, appException: buyGiftCardData.exception));
        event.onFailure(buyGiftCardData.exception);
    }
  }

  _getGiftCardBalanceEvent(GetGiftCardBalanceEvent event, Emitter<GiftCardState> emit) async {
    final getGiftCardBalanceData = await qetGiftCardBalanceUseCase.call(event.cardNumber);

    switch (getGiftCardBalanceData) {
      case Success<GetCardBalanceModel>():
        emit(state.copyWith(
            getGiftCardBalanceState: CurrentAppState.SUCCESS,
            cardBalanceModel: getGiftCardBalanceData.data));
        event.onSuccess('success');
      case Error<GetCardBalanceModel>():
        emit(state.copyWith(
            getGiftCardBalanceState: CurrentAppState.ERROR,
            appException: getGiftCardBalanceData.exception));
        event.onFailure(getGiftCardBalanceData.exception);
    }
  }

  _getSendReceivedGiftCardsEvent(GetSendReceivedGiftCardsEvent event, Emitter<GiftCardState> emit) async {
    emit(state.copyWith(sendReceivedGiftCardState: CurrentAppState.LOADING));
    final sendReceivedGiftCard = await sendReceivedGiftCardUseCase.call(EmptyParams());
    switch (sendReceivedGiftCard) {
      case Success<SendReceivedGiftCardModel>():
        emit(state.copyWith(
            sendReceivedGiftCardState: CurrentAppState.SUCCESS,
            sendReceivedGiftCardsData: sendReceivedGiftCard.data));
        Logger.customLogData("Send ", state.sendReceivedGiftCardsData?.sent ?? []);
        Logger.customLogData("Received ", state.sendReceivedGiftCardsData?.received ?? []);
      case Error<SendReceivedGiftCardModel>():
        emit(state.copyWith(
            sendReceivedGiftCardState: CurrentAppState.ERROR,
            appException: sendReceivedGiftCard.exception));
    }
  }

  _topUpGiftCardEvent(TopUpGiftCardEvent event, Emitter<GiftCardState> emit) async {
    emit(state.copyWith(
        sendGiftCardRequest: {...event.confirmationDetails ?? {}, ...state.sendGiftCardRequest},
        topUpGiftCardState: CurrentAppState.LOADING));

    final Map<String, dynamic> requestData = {
      "cinemaId": state.allGiftCardData!.cinemaId ?? '',
      "itemId": "2975",
      /*state.allGiftCardData!.id ?? '',*/
      //TODO: discuss with Sadil and add dynamic ItemId
      "quantity": 1,
      "variablePriceInCents": state.sendGiftCardRequest['price'],
      "giftCardNumber": state.sendGiftCardRequest['cardNumber'],
    };

    final buyGiftCardData = await topUpGiftCardUseCase.call(requestData);

    switch (buyGiftCardData) {
      case Success<String>():
        emit(state.copyWith(
            topUpGiftCardState: CurrentAppState.SUCCESS, reservationId: buyGiftCardData.data));
        event.onSuccess(buyGiftCardData.data);
      case Error<String>():
        emit(state.copyWith(
            topUpGiftCardState: CurrentAppState.ERROR, appException: buyGiftCardData.exception));
        event.onFailure(buyGiftCardData.exception);
    }
  }
}
