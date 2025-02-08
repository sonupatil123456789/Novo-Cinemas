import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class CreatePaymentEvent extends PaymentEvent {
  final String reservationId;

  const CreatePaymentEvent(this.reservationId);

  @override
  List<Object> get props => [reservationId];
}
