

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/core/utils/Logger.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../../../SeatLayout/presentation/components/BookingStepper.dart';
import '../../domain/useCases/ApplyVoucherCodeUseCase.dart';
import '../../domain/useCases/CancelFAndBUseCase.dart';
import '../../domain/useCases/CompleteOrderUseCase.dart';
import '../../domain/useCases/RemoveVoucherCodeUseCase.dart';
part 'OrderConfirmationEvent.dart';
part 'OrderConfirmationState.dart';

class OrderConfirmationBloc extends Bloc<OrderConfirmationEvent, OrderConfirmationState> {

  final CompleteOrderUseCase completeOrderUseCase;
  final CancelFAndBUseCase cancelFAndBUseCase;

  final ApplyVoucherCodeUseCase applyVoucherCodeUseCase;
  final RemoveVoucherCodeUseCase removeVoucherCodeUseCase;

  OrderConfirmationBloc(this.completeOrderUseCase,
      this.applyVoucherCodeUseCase,
      this.removeVoucherCodeUseCase,
      this.cancelFAndBUseCase): super(const OrderConfirmationState()) {
    on<InitialiseOrderConformationEvent>(_initialiseOrderConformationEvent);


    on<CompleteOrderEvent>(_completeOrderEvent);
    on<CancelFAndBEvent>(_cancelFAndBEvent);
    on<SetBookingStepperEvent>(_setBookingStepperEvent);
    on<ApplyVoucherCodeEvent>(_applyVoucherCodeEvent);
    on<RemoveVoucherCodeEvent>(_removeVoucherCodeEvent);

  }


  _initialiseOrderConformationEvent(InitialiseOrderConformationEvent event,Emitter<OrderConfirmationState> emit) async {
    emit(state.copyWith(totalOrderPrice : event.finalPrice));
    Logger.customLogData("Total Order Price", state.totalOrderPrice);
  }

  _removeVoucherCodeEvent(RemoveVoucherCodeEvent event , Emitter<OrderConfirmationState> emit)async {
    emit(state.copyWith(removeVoucherCodeState: CurrentAppState.LOADING));
    final removeVoucherCodeData = await removeVoucherCodeUseCase.call(event.reservationId?? '');
    switch(removeVoucherCodeData) {
      case Success<Map<String, dynamic>>():

        final total = (removeVoucherCodeData.data['updated_price'] as num) ;
        const discountPrice = 0 ;
        // final discountPrice = (removeVoucherCodeData.data['voucher_discount'] as num) ;


        emit(state.copyWith(removeVoucherCodeState: CurrentAppState.SUCCESS, applyVoucherCodeState: CurrentAppState.INITIAL,  isVoucherApplied :false ,totalOrderPrice:total,discountPrice: discountPrice ));
        event.onSuccess();
        Logger.customLogData("Voucher Price ", 'Total price ${state.totalOrderPrice} Discount price ${state.discountPrice}');
      case Error<Map<String, dynamic>>():
        emit(state.copyWith(removeVoucherCodeState: CurrentAppState.ERROR,applyVoucherCodeState: CurrentAppState.INITIAL, appException: removeVoucherCodeData.exception));
        event.onFailure(removeVoucherCodeData.exception);
    }
  }

  _applyVoucherCodeEvent(ApplyVoucherCodeEvent event , Emitter<OrderConfirmationState> emit)async {

    emit(state.copyWith(applyVoucherCodeState: CurrentAppState.LOADING));
    final applyBankOffersData = await applyVoucherCodeUseCase.call(event.data);
    switch(applyBankOffersData) {
      case Success<Map<String, dynamic>>():
        final total = (applyBankOffersData.data['updated_price'] as num) ;
        final discountPrice = (applyBankOffersData.data['voucher_discount'] as num) ;

        emit(state.copyWith(applyVoucherCodeState: CurrentAppState.SUCCESS,removeVoucherCodeState: CurrentAppState.INITIAL, totalOrderPrice:total,discountPrice: discountPrice,isVoucherApplied :true ));
        event.onSuccess();
        Logger.customLogData("Offer Price ", 'Total price ${state.totalOrderPrice} Discount price ${state.discountPrice}');
      case Error<Map<String, dynamic>>():
        emit(state.copyWith(applyVoucherCodeState: CurrentAppState.ERROR, removeVoucherCodeState: CurrentAppState.INITIAL, appException: applyBankOffersData.exception));
        event.onFailure(applyBankOffersData.exception);
    }
  }



  _setBookingStepperEvent(SetBookingStepperEvent event,Emitter<OrderConfirmationState> emit) async {
    emit(state.copyWith(bookingFlowSteps : event.step));
    Logger.customLogData("Current Booking Step", state.bookingFlowSteps);
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
  }
}

