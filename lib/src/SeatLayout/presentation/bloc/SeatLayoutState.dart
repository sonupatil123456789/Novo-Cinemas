part of 'SeatLayoutBloc.dart';

class SeatLayoutState extends Equatable {
  final SeatLayoutModel seatLayout;
  final CurrentAppState loading;
  final CurrentAppState extendTimerState;
  final num totalSelectedSeatPrice;
  final AppException? appException;
  // selected seat data to view state change
  final List<SeatModel> selectedSeat;
  // selected seat data to send to backend for seat booking api
  final List<Map<String, dynamic>> bookSelectedSeat;
  final Map<String,dynamic> seatConfirmationDetails;
  final MovieSelectionType? movieSelectionType ;

  final CurrentAppState bookSelectedSeatState;
  final String? reservationId ;

  const SeatLayoutState(
      {this.seatLayout = const SeatLayoutModel(),
      this.selectedSeat = const [],
        this.extendTimerState = CurrentAppState.INITIAL,
        this .totalSelectedSeatPrice = 0,
        this.movieSelectionType =MovieSelectionType.MOVIE_DETAILS,
        this.loading = CurrentAppState.INITIAL,
        this.bookSelectedSeat = const [],
        this.seatConfirmationDetails = const {},
        this.bookSelectedSeatState = CurrentAppState.INITIAL,
        this.reservationId = '',
      this.appException});

  SeatLayoutState copyWith(
      {SeatLayoutModel? seatLayout,
      List<SeatModel>? selectedSeat,
        CurrentAppState? bookSelectedSeatState,
        MovieSelectionType? movieSelectionType,
        String? reservationId,
        List<Map<String, dynamic>>? bookSelectedSeat,
      AppException? appException,
         CurrentAppState? extendTimerState,
         num? totalSelectedSeatPrice,
        Map<String,dynamic>? seatConfirmationDetails,
      CurrentAppState? loading}) {
    return SeatLayoutState(
        seatLayout: seatLayout ?? this.seatLayout,
        selectedSeat: selectedSeat ?? this.selectedSeat,
        bookSelectedSeat : bookSelectedSeat ?? this.bookSelectedSeat,
        movieSelectionType : movieSelectionType ?? this.movieSelectionType ,
        appException: appException ?? this.appException,
        reservationId : reservationId ?? this.reservationId,
        totalSelectedSeatPrice : totalSelectedSeatPrice ?? this.totalSelectedSeatPrice ,
        extendTimerState : extendTimerState ?? this.extendTimerState,
        bookSelectedSeatState : bookSelectedSeatState ?? this.bookSelectedSeatState,
        seatConfirmationDetails: seatConfirmationDetails?? this.seatConfirmationDetails,
        loading: loading ?? this.loading);
  }

  @override
  List<Object?> get props => [seatLayout, selectedSeat,bookSelectedSeat, loading,reservationId, appException,extendTimerState, seatConfirmationDetails,bookSelectedSeatState,movieSelectionType,totalSelectedSeatPrice];
}
