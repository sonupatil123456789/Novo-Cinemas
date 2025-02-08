import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/src/Offers/domain/models/BankOfferModel.dart';
import 'package:novocinema/src/Offers/domain/models/OffersModel.dart';
import 'package:novocinema/src/Offers/domain/useCases/RemoveAppliedBankOffersUseCase.dart';
import 'package:novocinema/src/SeatLayout/presentation/bloc/SeatLayoutBloc.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/utils/Logger.dart';
import '../../domain/useCases/ApplyBankOfferUseCase.dart';
import '../../domain/useCases/ApplyDiscountCodeOffersUseCase.dart';
import '../../domain/useCases/CancelBookedSelectedSeatsUseCase.dart';
import '../../domain/useCases/GetAllOffersUseCase.dart';
import '../../domain/useCases/RemoveDiscountCodeOffersUseCase.dart';
import '../../domain/useCases/ValidateBankOfferUseCase.dart';
part 'OffersEvent.dart';
part 'OffersState.dart';

class OffersBloc extends Bloc<OffersEvent, OffersState> {
  final GetAllOffersUseCase getAllOffersUseCase ;
  final CancelBookedSelectedSeatsUseCase  cancelBookedSelectedSeatsUseCase ;
  final ApplyBankOfferUseCase applyBankOfferUseCase ;
  final RemoveAppliedBankOffersUseCase removeAppliedBankOffersUseCase ;
  final ValidateBankOfferUseCase validateBankOfferUseCase ;

  final ApplyDiscountCodeOffersUseCase applyDiscountCodeOffersUseCase ;
  final RemoveDiscountCodeOffersUseCase removeDiscountCodeOffersUseCase ;


  OffersBloc(this.cancelBookedSelectedSeatsUseCase ,
      this.getAllOffersUseCase, this.applyBankOfferUseCase,
      this.removeDiscountCodeOffersUseCase ,
      this.applyDiscountCodeOffersUseCase ,
      this.removeAppliedBankOffersUseCase,
      this.validateBankOfferUseCase) : super(const OffersState()) {




    on<InitialiseOffersEvent>(_initialiseOffersEvent);
    on<GetAllOffersEvent>(_getAllOffersEvent);
    on<CancelBookedSelectedSeatsEvent>(_cancelBookedSelectedSeatsEvent);
    on<ApplyBankOffersEvent>(_applyBankOffersEvent);
    on<ValidateBankOffersEvent>(_validateBankOffersEvent);
    on<RemoveAppliedBankOffersEvent>(_removeAppliedBankOffersEvent);

    on<ApplyDiscountCodeOffersEvent>(_applyDiscountCodeOffersEvent);
    on<RemoveDiscountCodeOffersEvent>(_removeDiscountCodeOffersEvent);
    on<ClearOfferStateEvent>(_clearOfferStateEvent);



  }

  _clearOfferStateEvent(ClearOfferStateEvent event , Emitter<OffersState> emit){
    emit(const OffersState());
    Logger.customLogData("Seat Confirmation Details (OffersScreen)", state.toString());
  }

  _removeDiscountCodeOffersEvent(RemoveDiscountCodeOffersEvent event , Emitter<OffersState> emit)async {

    emit(state.copyWith(removeDiscountCodeOfferState: CurrentAppState.LOADING));
    final removeDiscountCodeOffersData = await removeAppliedBankOffersUseCase.call(state.reservationId?? '');
    switch(removeDiscountCodeOffersData) {
      case Success<Map<String, dynamic>>():

        final total = (removeDiscountCodeOffersData.data['ticket_price_in_cents'] as num) ;
        final discountPrice = (removeDiscountCodeOffersData.data['discount_amount_in_cents'] as num) ;

        emit(state.copyWith(removeDiscountCodeOfferState: CurrentAppState.SUCCESS,applyDiscountCodeOfferState: CurrentAppState.INITIAL, totalSeatPrice:total,discountPrice: discountPrice,isPromoCodeApplied : false ));
        event.onSuccess();
        Logger.customLogData("Offer Price ", 'Total price ${state.totalSeatPrice} Discount price ${state.discountPrice}');
      case Error<Map<String, dynamic>>():
        emit(state.copyWith(removeDiscountCodeOfferState: CurrentAppState.ERROR,applyDiscountCodeOfferState: CurrentAppState.INITIAL,  appException: removeDiscountCodeOffersData.exception));
        event.onFailure(removeDiscountCodeOffersData.exception);
    }
  }

  _applyDiscountCodeOffersEvent(ApplyDiscountCodeOffersEvent event , Emitter<OffersState> emit)async {

    emit(state.copyWith(applyDiscountCodeOfferState: CurrentAppState.LOADING));
    final applyDiscountCodeOffersData = await applyDiscountCodeOffersUseCase.call(event.data);
    switch(applyDiscountCodeOffersData) {
      case Success<Map<String, dynamic>>():

        final total = (applyDiscountCodeOffersData.data['ticket_price_in_cents'] as num) ;
        final discountPrice = (applyDiscountCodeOffersData.data['discount_amount_in_cents'] as num) ;

        emit(state.copyWith(applyDiscountCodeOfferState: CurrentAppState.SUCCESS,removeDiscountCodeOfferState:CurrentAppState.INITIAL  ,isPromoCodeApplied: true, totalSeatPrice:total,discountPrice: discountPrice ));
        event.onSuccess();
        Logger.customLogData("Offer Price ", 'Total price ${state.totalSeatPrice} Discount price ${state.discountPrice}');
      case Error<Map<String, dynamic>>():
        emit(state.copyWith(applyDiscountCodeOfferState: CurrentAppState.ERROR, removeDiscountCodeOfferState:CurrentAppState.INITIAL ,appException: applyDiscountCodeOffersData.exception));
        event.onFailure(applyDiscountCodeOffersData.exception);
    }
  }

  _removeAppliedBankOffersEvent(RemoveAppliedBankOffersEvent event , Emitter<OffersState> emit)async {


    emit(state.copyWith(removeApplyBankOfferState: CurrentAppState.LOADING));
    final removeBankOffersData = await removeAppliedBankOffersUseCase.call(state.reservationId?? '');
    switch(removeBankOffersData) {
      case Success<Map<String, dynamic>>():

        final total = (removeBankOffersData.data['ticket_price_in_cents'] as num) ;
        final discountPrice = (removeBankOffersData.data['discount_amount_in_cents'] as num) ;


        emit(state.copyWith(removeApplyBankOfferState: CurrentAppState.SUCCESS,isOffersApplied :false ,totalSeatPrice:total,discountPrice: discountPrice ));
        event.onSuccess();
        Logger.customLogData("Offer Price ", 'Total price ${state.totalSeatPrice} Discount price ${state.discountPrice}');
      case Error<Map<String, dynamic>>():
        emit(state.copyWith(removeApplyBankOfferState: CurrentAppState.ERROR, appException: removeBankOffersData.exception));
        event.onFailure(removeBankOffersData.exception);
    }
  }

  _applyBankOffersEvent(ApplyBankOffersEvent event , Emitter<OffersState> emit)async {

    emit(state.copyWith(applyBankOfferState: CurrentAppState.LOADING));
    final applyBankOffersData = await applyBankOfferUseCase.call(event.data);
    switch(applyBankOffersData) {
      case Success<Map<String, dynamic>>():

        final total = (applyBankOffersData.data['ticket_price_in_cents'] as num) ;
        final discountPrice = (applyBankOffersData.data['discount_amount_in_cents'] as num) ;

        emit(state.copyWith(applyBankOfferState: CurrentAppState.SUCCESS, totalSeatPrice:total,discountPrice: discountPrice,isOffersApplied :true ));
        event.onSuccess();
        Logger.customLogData("Offer Price ", 'Total price ${state.totalSeatPrice} Discount price ${state.discountPrice}');
      case Error<Map<String, dynamic>>():
        emit(state.copyWith(applyBankOfferState: CurrentAppState.ERROR, appException: applyBankOffersData.exception));
        event.onFailure(applyBankOffersData.exception);
    }
  }

  _validateBankOffersEvent(ValidateBankOffersEvent event , Emitter<OffersState> emit)async {
    emit(state.copyWith(validateBankOfferState: CurrentAppState.LOADING));
    final validatedBankOfferData = await validateBankOfferUseCase.call(event.data);
    switch(validatedBankOfferData) {
      case Success<bool>():
        emit(state.copyWith(validateBankOfferState: CurrentAppState.SUCCESS));
        event.onSuccess();
      case Error<bool>():
        emit(state.copyWith(validateBankOfferState: CurrentAppState.ERROR, appException: validatedBankOfferData.exception));
        event.onFailure(validatedBankOfferData.exception);
    }
  }

  _cancelBookedSelectedSeatsEvent(CancelBookedSelectedSeatsEvent event , Emitter<OffersState> emit)async {
    emit(state.copyWith(cancelBookingSelectedSeatState: CurrentAppState.LOADING));
    final cancelBookingSeatsData = await cancelBookedSelectedSeatsUseCase.call(state.reservationId ?? '');
    switch(cancelBookingSeatsData) {
      case Success<Map<String, dynamic>>():
        emit(state.copyWith(cancelBookingSelectedSeatState: CurrentAppState.SUCCESS));
        event.callBack(cancelBookingSeatsData.data);
      case Error<Map<String, dynamic>>():
        emit(state.copyWith(cancelBookingSelectedSeatState: CurrentAppState.ERROR, appException: cancelBookingSeatsData.exception));
    }
  }

  _getAllOffersEvent(GetAllOffersEvent event , Emitter<OffersState> emit) async {
    emit(state.copyWith(loading: CurrentAppState.LOADING));
    final getAllOffersData = await getAllOffersUseCase.call(state.reservationId ?? '');
    switch(getAllOffersData) {
      case Success<OffersModel>():
        emit(state.copyWith(loading: CurrentAppState.SUCCESS,offersData: getAllOffersData.data ));
      case Error<OffersModel>():
      emit(state.copyWith(loading: CurrentAppState.ERROR,appException: getAllOffersData.exception));
    }
  }

  _initialiseOffersEvent(InitialiseOffersEvent event , Emitter<OffersState> emit){
    final seatLayoutState = event.seatLayoutBloc.state;

    final totalPrice = (seatLayoutState.seatConfirmationDetails['SelectedSeats'] as List<Map<String,dynamic>>).fold(0, (total, current) {
      return total + (current['PriceInCents'] as int? ?? 0);
    });


    emit(state.copyWith(
        seatConfirmationDetails: seatLayoutState.seatConfirmationDetails,
        reservationId: seatLayoutState.reservationId,
        totalSeatPrice: totalPrice,
        isPromoCodeApplied: false
    ));
    Logger.customLogData("Seat Confirmation Details (OffersScreen)", state.seatConfirmationDetails.toString());
  }





}


