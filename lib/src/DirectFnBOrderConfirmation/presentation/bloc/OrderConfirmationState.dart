part of 'OrderConfirmationBloc.dart';

class OrderConfirmationState extends Equatable {
  final Map<String, dynamic> confirmationOrderDetails;
  final CurrentAppState loading;
  final CurrentAppState confirmationOrderState;
  final CurrentAppState cancelFAndBState;
  final AppException? appException;




  const OrderConfirmationState(
      {
        this.confirmationOrderDetails = const {},
        this.cancelFAndBState = CurrentAppState.INITIAL,
      this.loading = CurrentAppState.INITIAL,
        this.confirmationOrderState = CurrentAppState.INITIAL,
      this.appException});

  OrderConfirmationState copyWith(
      {
        Map<String,dynamic>? confirmationOrderDetails,
        CurrentAppState? cancelFAndBState,
      AppException? appException,
        CurrentAppState? confirmationOrderState,
      CurrentAppState? loading}) {
    return OrderConfirmationState(
        confirmationOrderState : confirmationOrderState ?? this.confirmationOrderState,
        cancelFAndBState: cancelFAndBState ?? this.cancelFAndBState,
        appException: appException ?? this.appException,
        confirmationOrderDetails : confirmationOrderDetails ??this.confirmationOrderDetails,
        loading: loading ?? this.loading);
  }

  @override
  List<Object?> get props => [confirmationOrderState, loading, appException,confirmationOrderDetails,cancelFAndBState];
}
