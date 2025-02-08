part of 'OffersBloc.dart';

class OffersState extends Equatable {
  final Map<String, dynamic> seatConfirmationDetails;
  final CurrentAppState loading;
  final CurrentAppState cancelBookingSelectedSeatState;
  final CurrentAppState validateBankOfferState;
  final CurrentAppState applyBankOfferState;
  final CurrentAppState removeApplyBankOfferState;

  final CurrentAppState applyDiscountCodeOfferState;
  final CurrentAppState removeDiscountCodeOfferState;

  final OffersModel? offersData;
  final AppException? appException;

  final bool? isOffersApplied;
  final bool? isPromoCodeApplied ;

  final String? reservationId;

  final num? totalSeatPrice;
  final num? discountPrice;

  const OffersState(
      {this.seatConfirmationDetails = const {},
      this.loading = CurrentAppState.INITIAL,
      this.isOffersApplied = false,
      this.validateBankOfferState = CurrentAppState.INITIAL,
      this.applyBankOfferState = CurrentAppState.INITIAL,
      this.removeApplyBankOfferState = CurrentAppState.INITIAL,
      this.applyDiscountCodeOfferState = CurrentAppState.INITIAL,
      this.removeDiscountCodeOfferState = CurrentAppState.INITIAL,
      this.offersData,
      this.cancelBookingSelectedSeatState = CurrentAppState.INITIAL,
      this.reservationId = '',
      this.totalSeatPrice = 0,
      this.discountPrice = 0,
        this.isPromoCodeApplied = false ,
      this.appException
      });

  OffersState copyWith(
      {Map<String, dynamic>? seatConfirmationDetails,
      AppException? appException,
      CurrentAppState? validateBankOfferState,
      CurrentAppState? applyBankOfferState,
      CurrentAppState? cancelBookingSelectedSeatState,
      CurrentAppState? removeApplyBankOfferState,
      CurrentAppState? applyDiscountCodeOfferState,
      CurrentAppState? removeDiscountCodeOfferState,
      String? reservationId,
      bool? isOffersApplied,
      num? totalSeatPrice,
      num? discountPrice,
        bool? isPromoCodeApplied ,
        OffersModel? offersData,
      CurrentAppState? loading}) {
    return OffersState(
        seatConfirmationDetails:
            seatConfirmationDetails ?? this.seatConfirmationDetails,
        appException: appException ?? this.appException,
        reservationId: reservationId ?? this.reservationId,
        offersData: offersData ?? this.offersData,
        isPromoCodeApplied: isPromoCodeApplied ?? this.isPromoCodeApplied,
        applyBankOfferState: applyBankOfferState ?? this.applyBankOfferState,
        removeApplyBankOfferState:
            removeApplyBankOfferState ?? this.removeApplyBankOfferState,
        validateBankOfferState:
            validateBankOfferState ?? this.validateBankOfferState,
        totalSeatPrice: totalSeatPrice ?? this.totalSeatPrice,
        isOffersApplied: isOffersApplied ?? this.isOffersApplied,
        discountPrice: discountPrice ?? this.discountPrice,
        applyDiscountCodeOfferState: applyDiscountCodeOfferState ?? this.applyDiscountCodeOfferState,
        removeDiscountCodeOfferState:removeDiscountCodeOfferState ?? this.removeDiscountCodeOfferState,
        cancelBookingSelectedSeatState: cancelBookingSelectedSeatState ??
            this.cancelBookingSelectedSeatState,
        loading: loading ?? this.loading);
  }

  @override
  List<Object?> get props => [
        seatConfirmationDetails,
        applyBankOfferState,
        validateBankOfferState,
        loading,
        offersData,
        appException,
        cancelBookingSelectedSeatState,
        reservationId,
    isOffersApplied,
        totalSeatPrice,
        discountPrice,
        removeApplyBankOfferState,
        removeDiscountCodeOfferState,
    isPromoCodeApplied,
        applyDiscountCodeOfferState
      ];
}
