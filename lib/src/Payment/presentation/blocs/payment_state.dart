import 'package:equatable/equatable.dart';
import 'package:novocinema/src/Payment/data/models/payment_response.dart';

class PaymentState extends Equatable {
  final bool isLoading;
  final String? error;
  final dynamic paymentResponse;

  const PaymentState({
    required this.isLoading,
    this.error,
    this.paymentResponse,
  });

  factory PaymentState.initial() {
    return const PaymentState(
      isLoading: false,
      error: null,
      paymentResponse: null,
    );
  }

  PaymentState copyWith({
    bool? isLoading,
    String? error,
    dynamic  paymentResponse,
  }) {
    return PaymentState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      paymentResponse: paymentResponse ?? this.paymentResponse,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, paymentResponse];
}
