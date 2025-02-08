part of 'OrderConfirmationBloc.dart';

sealed class OrderConfirmationEvent extends Equatable {
  const OrderConfirmationEvent();

  @override
  List<Object> get props => [];
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





