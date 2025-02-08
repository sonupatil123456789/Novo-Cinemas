import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/src/Payment/domain/usecases/create_payment.dart';
import 'package:novocinema/src/Payment/presentation/blocs/payment_event.dart';
import 'package:novocinema/src/Payment/presentation/blocs/payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final CreatePayment createPayment;

  PaymentBloc(this.createPayment) : super(PaymentState.initial()) {
    // Register event handlers
    on<CreatePaymentEvent>(_onCreatePaymentEvent);
  }

  Future<void> _onCreatePaymentEvent(
    CreatePaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      // Call the use case to create the payment
      final paymentResponse = await createPayment.call(event.reservationId);

      emit(state.copyWith(
        isLoading: false,
        paymentResponse: paymentResponse,
      ));
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        error: error.toString(),
      ));
    }
  }
}
