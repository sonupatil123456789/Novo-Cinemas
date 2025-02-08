part of 'OrderConfirmationBloc.dart';

class OrderConfirmationState extends Equatable {
  final Map<String, dynamic> confirmationOrderDetails;
  final CurrentAppState loading;
  final CurrentAppState confirmationOrderState;
  final CurrentAppState cancelFAndBState;
  final AppException? appException;

  final BookingFlowSteps bookingFlowSteps;


  final CurrentAppState applyVoucherCodeState;
  final CurrentAppState removeVoucherCodeState;


  final bool? isVoucherApplied;

  final num? totalOrderPrice;
  final num? discountPrice;




  const OrderConfirmationState(
      {
        this.confirmationOrderDetails = const {},
        this.cancelFAndBState = CurrentAppState.INITIAL,
        this.loading = CurrentAppState.INITIAL,
        this.bookingFlowSteps = BookingFlowSteps.SEAT_SELECTION,
        this.confirmationOrderState = CurrentAppState.INITIAL,

        this.applyVoucherCodeState = CurrentAppState.INITIAL,
        this.removeVoucherCodeState = CurrentAppState.INITIAL,
        this.totalOrderPrice = 0,
        this.discountPrice = 0,
        this.isVoucherApplied = false ,


      this.appException});

  OrderConfirmationState copyWith(
      {
        Map<String,dynamic>? confirmationOrderDetails,
        CurrentAppState? cancelFAndBState,
         AppException? appException,
        CurrentAppState? confirmationOrderState,
         CurrentAppState? applyVoucherCodeState,
         CurrentAppState? removeVoucherCodeState,
         bool? isVoucherApplied,
         num? totalOrderPrice,
          num? discountPrice,
        BookingFlowSteps? bookingFlowSteps ,

      CurrentAppState? loading}) {
    return OrderConfirmationState(
        confirmationOrderState : confirmationOrderState ?? this.confirmationOrderState,
        cancelFAndBState: cancelFAndBState ?? this.cancelFAndBState,
        appException: appException ?? this.appException,
        bookingFlowSteps : bookingFlowSteps ??this.bookingFlowSteps ,
        confirmationOrderDetails : confirmationOrderDetails ??this.confirmationOrderDetails,
        applyVoucherCodeState: applyVoucherCodeState ?? this.applyVoucherCodeState,
        discountPrice: discountPrice ?? this.discountPrice,
        isVoucherApplied:isVoucherApplied ?? this.isVoucherApplied ,
        removeVoucherCodeState: removeVoucherCodeState ?? this.removeVoucherCodeState,
        totalOrderPrice: totalOrderPrice ?? this.totalOrderPrice,
        loading: loading ?? this.loading);
  }

  @override
  List<Object?> get props => [confirmationOrderState, loading, discountPrice,applyVoucherCodeState,discountPrice,
    appException,confirmationOrderDetails,cancelFAndBState, totalOrderPrice,removeVoucherCodeState,isVoucherApplied,
    bookingFlowSteps];
}
