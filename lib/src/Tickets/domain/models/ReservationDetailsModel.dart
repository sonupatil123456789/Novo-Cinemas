



import 'package:equatable/equatable.dart';
import 'package:novocinema/src/Movies/domain/models/MovieModel.dart';
import 'package:novocinema/src/Tickets/domain/models/SeatDetailsModel.dart';

import '../../../Movies/data/dto/MovieDto.dart';
import 'CinemaModel.dart';
import 'ConcessionModel.dart';


class ReservationDetailsModel extends Equatable {
  final String? reservationId;
  final int? cinemaId;
  final List<ConcessionModel>? concessionData;
  final int? concessionPriceInCents;
  final int? concessionTaxInCents;
  final int? ticketPriceInCents;
  final int? ticketTaxInCents;
  final String? customerEmail;
  final String? customerContact;
  final String? customerCountryCode;
  final List<SeatDetailsModel>? seatName;
  final String? screen;
  final String? sessionId;
  final String? showDate;
  final String? showTime;
  final num? totalSeats;
  final List<Map<String,dynamic>>? seatData ;
  final DateTime? showDateTime;
  final bool? isOnlyFAndB ;
  final String? vistaBookingId;
  final MovieModel? movie;
  final CinemaModel? cinema;

  const ReservationDetailsModel({
    this.reservationId = '',
    this.cinemaId = 0,
    this.concessionData = const [],
    this.concessionPriceInCents = 0,
    this.concessionTaxInCents = 0,
    this.ticketPriceInCents = 0,
    this.ticketTaxInCents = 0,
    this.customerEmail = '',
    this.customerContact = '',
    this.customerCountryCode = '',
    this.seatName = const [],
    this.screen = '',
    this.sessionId = '',
    this.showTime = '',
    this.showDate = '',
    this. totalSeats = 0 ,
    this. showDateTime,
    this. seatData  = const [],
    this.isOnlyFAndB = false ,
    this.vistaBookingId = '',
    this.movie,
    this.cinema,
  });



  ReservationDetailsModel copyWith({
    String? reservationId,
    int? cinemaId,
    List<ConcessionModel>? concessionData,
    int? concessionPriceInCents,
    int? concessionTaxInCents,
    int? ticketPriceInCents,
    int? ticketTaxInCents,
    String? customerEmail,
    String? customerContact,
    String? customerCountryCode,
    List<SeatDetailsModel>? seatName,
    String? screen,
    String? sessionId,
    DateTime? showDateTime,
    String? vistaBookingId,
    MovieModel? movie,
    CinemaModel? cinema,
    String? showDate,
    String? showTime,
    num? totalSeats,
    List<Map<String,dynamic>>? seatData ,
    bool? isOnlyFAndB ,
  }) {
    return ReservationDetailsModel(
      reservationId: reservationId ?? this.reservationId,
      cinemaId: cinemaId ?? this.cinemaId,
      concessionData: concessionData ?? this.concessionData,
      concessionPriceInCents: concessionPriceInCents ?? this.concessionPriceInCents,
      concessionTaxInCents: concessionTaxInCents ?? this.concessionTaxInCents,
      ticketPriceInCents: ticketPriceInCents ?? this.ticketPriceInCents,
      ticketTaxInCents: ticketTaxInCents ?? this.ticketTaxInCents,
      customerEmail: customerEmail ?? this.customerEmail,
      customerContact: customerContact ?? this.customerContact,
      customerCountryCode: customerCountryCode ?? this.customerCountryCode,
      seatName: seatName ?? this.seatName,
      screen: screen ?? this.screen,
      sessionId: sessionId ?? this.sessionId,
      isOnlyFAndB:  isOnlyFAndB?? this.isOnlyFAndB,
      seatData: seatData ?? this.seatData,
      showDate:showDate ?? this.showDate ,
      showTime:showTime ?? this.showTime ,
      totalSeats:totalSeats ?? this.totalSeats ,
      vistaBookingId: vistaBookingId ?? this.vistaBookingId,
      showDateTime: showDateTime ?? this.showDateTime,
      movie: movie ?? this.movie,
      cinema: cinema ?? this.cinema,
    );
  }
  @override
  List<Object?> get props => [
    reservationId,
    cinemaId,
    concessionData,
    concessionPriceInCents,
    concessionTaxInCents,
    ticketPriceInCents,
    ticketTaxInCents,
    customerEmail,
    customerContact,
    customerCountryCode,
    seatName,
    screen,
    sessionId,
    showDate,
    showTime,
    seatData,
    showDateTime,
    vistaBookingId,
    isOnlyFAndB,
    totalSeats,
    movie,
    cinema,
  ];

  @override
  String toString() {
    return 'ReservationDetailsModel('
        'reservationId: $reservationId, '
        'cinemaId: $cinemaId, '
        'concessionData: $concessionData, '
        'concessionPriceInCents: $concessionPriceInCents, '
        'concessionTaxInCents: $concessionTaxInCents, '
        'ticketPriceInCents: $ticketPriceInCents, '
        'ticketTaxInCents: $ticketTaxInCents, '
        'customerEmail: $customerEmail, '
        'customerContact: $customerContact, '
        'customerCountryCode: $customerCountryCode, '
        'seatName: $seatName, '
        'screen: $screen, '
        'sessionId: $sessionId, '
        'showDate: $showDate, '
        'showTime: $showTime, '
        'seatData: $seatData, '
        'isOnlyFAndB: $isOnlyFAndB, '
        'showDateTime: $showDateTime, '
        'totalSeats: $totalSeats, '
        'vistaBookingId: $vistaBookingId, '
        'movie: $movie, '
        'cinema: $cinema,'
        ')';
  }


}