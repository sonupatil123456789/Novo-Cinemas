

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/resources/DataResult.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../../domain/useCases/CancelFAndBUseCase.dart';
import '../../domain/useCases/CompleteOrderUseCase.dart';
part 'OrderConfirmationEvent.dart';
part 'OrderConfirmationState.dart';

class OrderConfirmationBloc extends Bloc<OrderConfirmationEvent, OrderConfirmationState> {

  final CompleteOrderUseCase completeOrderUseCase;
  final CancelFAndBUseCase cancelFAndBUseCase;

  OrderConfirmationBloc(this.completeOrderUseCase, this.cancelFAndBUseCase): super(const OrderConfirmationState()) {
    on<CompleteOrderEvent>(_completeOrderEvent);
    on<CancelFAndBEvent>(_cancelFAndBEvent);

  }

  _cancelFAndBEvent(CancelFAndBEvent event,Emitter<OrderConfirmationState> emit) async {
    emit(state.copyWith(cancelFAndBState: CurrentAppState.LOADING));
    final cancelOrderData = await cancelFAndBUseCase.call(event.reservationId);

    switch (cancelOrderData) {
      case Success<dynamic>():
        emit(state.copyWith(cancelFAndBState: CurrentAppState.SUCCESS));
        event.onSuccess();
      case Error<dynamic>():
        emit(state.copyWith(cancelFAndBState: CurrentAppState.ERROR,appException: cancelOrderData.exception));
    }

  }

  _completeOrderEvent(CompleteOrderEvent event,Emitter<OrderConfirmationState> emit) async {
    emit(state.copyWith(confirmationOrderState: CurrentAppState.LOADING));
    final orderData = await completeOrderUseCase.call(event.reservationId);

    switch (orderData) {
      case Success<Map<String, dynamic>>():
        emit(state.copyWith(confirmationOrderState: CurrentAppState.SUCCESS,confirmationOrderDetails: orderData.data));
        event.onSuccess();
      case Error<Map<String, dynamic>>():
        emit(state.copyWith(confirmationOrderState: CurrentAppState.ERROR,appException: orderData.exception));
        event.onFailure(orderData.exception);
    }
    print(state.confirmationOrderDetails);
  }
}

