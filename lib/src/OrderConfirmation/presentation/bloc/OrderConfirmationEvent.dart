part of 'OrderConfirmationBloc.dart';

sealed class OrderConfirmationEvent extends Equatable {
  const OrderConfirmationEvent();

  @override
  List<Object> get props => [];
}


class InitialiseOrderConformationEvent extends OrderConfirmationEvent {
  final num finalPrice ;
  const InitialiseOrderConformationEvent({required this.finalPrice});
  @override
  List<Object> get props => [finalPrice];
}


class ApplyVoucherCodeEvent extends OrderConfirmationEvent {
  final Map<String,dynamic> data ;
  final  Function onSuccess ;
  final Function(AppException) onFailure ;

  const ApplyVoucherCodeEvent({required this.data, required this.onFailure,required this.onSuccess});

  @override
  List<Object> get props => [data,onFailure,onSuccess];
}

class RemoveVoucherCodeEvent extends OrderConfirmationEvent {
  final  String reservationId;
  final  Function onSuccess ;
  final  Function(AppException) onFailure ;

  const RemoveVoucherCodeEvent({required this.onFailure,required this.onSuccess, required this.reservationId});

  @override
  List<Object> get props => [onFailure,onSuccess, reservationId];
}


class SetBookingStepperEvent extends OrderConfirmationEvent {
  final BookingFlowSteps step ;

  const SetBookingStepperEvent({required this.step});

  @override
  List<Object> get props => [step];
}


class CancelFAndBEvent extends OrderConfirmationEvent {
  final Function onSuccess ;
  final String reservationId ;

  const CancelFAndBEvent({required this.reservationId,required this.onSuccess});

  @override
  List<Object> get props => [reservationId,onSuccess];
}

class CompleteOrderEvent extends OrderConfirmationEvent {
  final Function onSuccess ;
  final Function(AppException) onFailure ;
  final String reservationId ;

  const CompleteOrderEvent(
      {required this.reservationId, required this.onFailure,required this.onSuccess});

  @override
  List<Object> get props => [reservationId, onFailure,onSuccess];
}





