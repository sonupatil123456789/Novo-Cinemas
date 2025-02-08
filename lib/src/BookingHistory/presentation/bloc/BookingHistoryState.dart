part of 'BookingHistoryBloc.dart';

class BookingHistoryState extends Equatable {
  final CurrentAppState loading;
  final AppException? appException;
  final List<ReservationDetailsModel>? bookingHistory;
  final List<ReservationDetailsModel> resentBookingList ;
  final List<ReservationDetailsModel> pastBookingList ;


  const BookingHistoryState(
      {
      this.loading = CurrentAppState.INITIAL,
        this.bookingHistory = const [] ,
        this.resentBookingList = const [],
        this.pastBookingList = const [],
      this.appException});

  BookingHistoryState copyWith(
      {AppException? appException,
        List<ReservationDetailsModel>? bookingHistory,
         List<ReservationDetailsModel>? resentBookingList ,
         List<ReservationDetailsModel>? pastBookingList ,
      CurrentAppState? loading}) {
    return BookingHistoryState(
        appException: appException ?? this.appException,
        pastBookingList : pastBookingList ?? this.pastBookingList ,
        resentBookingList : resentBookingList ?? this.resentBookingList,
        bookingHistory: bookingHistory ?? this.bookingHistory,
        loading: loading ?? this.loading);
  }

  @override
  List<Object?> get props =>
      [loading, appException, bookingHistory,resentBookingList,pastBookingList];
}
