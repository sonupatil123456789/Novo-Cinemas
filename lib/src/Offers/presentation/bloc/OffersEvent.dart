part of 'OffersBloc.dart';

sealed class OffersEvent extends Equatable {
  const OffersEvent();

  @override
  List<Object> get props => [];
}

class ApplyBankOffersEvent extends OffersEvent {
  Map<String,dynamic> data ;
  final  OfferDetailsModel Function() onSuccess ;
  final Function(AppException) onFailure ;

   ApplyBankOffersEvent({required this.data, required this.onFailure,required this.onSuccess});

  @override
  List<Object> get props => [data,onFailure,onSuccess];
}

class RemoveAppliedBankOffersEvent extends OffersEvent {
  final  OfferDetailsModel Function() onSuccess ;
  final  Function(AppException) onFailure ;

  RemoveAppliedBankOffersEvent({required this.onFailure,required this.onSuccess});

  @override
  List<Object> get props => [onFailure,onSuccess];
}

class ValidateBankOffersEvent extends OffersEvent {
  Map<String,dynamic> data ;
  final Function onSuccess ;
  final Function(AppException) onFailure ;

  ValidateBankOffersEvent({required this.data, required this.onFailure,required this.onSuccess});

  @override
  List<Object> get props => [data,onFailure,onSuccess];
}

class InitialiseOffersEvent extends OffersEvent {
  final SeatLayoutBloc seatLayoutBloc;

  const InitialiseOffersEvent(this.seatLayoutBloc);

  @override
  List<Object> get props => [seatLayoutBloc];
}


class GetAllOffersEvent extends OffersEvent {

  const GetAllOffersEvent();

  @override
  List<Object> get props => [];
}



class CancelBookedSelectedSeatsEvent extends OffersEvent {
  Function(Map<String,dynamic>) callBack;

   CancelBookedSelectedSeatsEvent(this.callBack);

  @override
  List<Object> get props => [callBack];
}



class ApplyDiscountCodeOffersEvent extends OffersEvent {
  final Map<String,dynamic> data ;
  final  Function onSuccess ;
  final Function(AppException) onFailure ;

  const ApplyDiscountCodeOffersEvent({required this.data, required this.onFailure,required this.onSuccess});

  @override
  List<Object> get props => [data,onFailure,onSuccess];
}

class RemoveDiscountCodeOffersEvent extends OffersEvent {
  final  Function onSuccess ;
  final  Function(AppException) onFailure ;

  const RemoveDiscountCodeOffersEvent({required this.onFailure,required this.onSuccess});

  @override
  List<Object> get props => [onFailure,onSuccess];
}

class ClearOfferStateEvent extends OffersEvent {
  const ClearOfferStateEvent ();
}


