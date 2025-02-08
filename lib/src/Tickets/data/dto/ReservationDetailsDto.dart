



import 'package:equatable/equatable.dart';
import 'package:novocinema/src/Tickets/domain/models/ReservationDetailsModel.dart';

import '../../../Movies/data/dto/MovieDto.dart';
import 'CinemaDto.dart';
import 'ConcessionDto.dart';
import 'SeatDetailsDto.dart';

class ReservationDetailsDto extends Equatable {
  final String? reservationId;
  final int? cinemaId;
  final List<ConcessionDto>? concessionData;
  final int? concessionPriceInCents;
  final int? concessionTaxInCents;
  final int? ticketPriceInCents;
  final int? ticketTaxInCents;
  final String? customerEmail;
  final String? customerContact;
  final String? customerCountryCode;
  final List<SeatDetailsDto>? seatName;
  final String? screen;
  final String? sessionId;
  final String? showDate;
  final String? showTime;
  final num? totalSeats;
  final List<Map<String,dynamic>>? seatData ;
  final DateTime? showDateTime;
  final bool? isOnlyFAndB ;
  final String? vistaBookingId;
  final MovieDto? movie;
  final CinemaDto? cinema;

  const ReservationDetailsDto({
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
    this.showDateTime,
    this. seatData  = const [],
    this.isOnlyFAndB = false ,
    this.vistaBookingId = '',
    this.movie,
    this.cinema,
  });

  factory ReservationDetailsDto.fromJson(Map<String, dynamic> json) {
    return ReservationDetailsDto(
      reservationId: json['reservation_id'] ?? '',
      cinemaId: json['cinema_id'] ??0,
      concessionData: json['concession_data'] != null
          ? (json['concession_data'] as List)
          .map((e) => ConcessionDto.fromJson(e))
          .toList()
          : [],
      concessionPriceInCents: json['concession_price_in_cents']??0,
      concessionTaxInCents: json['concession_tax_in_cents']?? 0,
      ticketPriceInCents: json['ticket_price_in_cents']?? 0,
      ticketTaxInCents: json['ticket_tax_in_cents'] ?? 0,
      customerEmail: json['customer_email'] ?? '',
      customerContact: json['customer_contact'] ?? '',
      customerCountryCode: json['customer_country_code'] ?? '',
      seatName: json['seat_name'] != null ? (json['seat_name'] as List<dynamic>).map((toElement)=>SeatDetailsDto.fromJson(toElement)).toList() :[],
      screen: json['screen'] ?? '',
      sessionId: json['session_id'] ?? '',
      showDate : json['show_date'] ?? '',
      showTime : json['show_time']?? '',
      showDateTime: json['show_date_time'] != null
          ? DateTime.parse(json['show_date_time'])
          : null,
      totalSeats : json['total_seats'] ?? 0,
      seatData: (json['seat_data'] as List<dynamic>?)?.map((item) =>item as Map<String, dynamic>).toList() ?? [],
      isOnlyFAndB : json['is_only_fnb'] ?? false,
      vistaBookingId: json['vista_booking_id'] ?? '',
      movie: json['movie'] != null ? MovieDto.fromJson(json['movie']) : MovieDto.fromJson(const <String,dynamic>{}),
      cinema: json['cinema'] != null ? CinemaDto.fromJson(json['cinema']) : CinemaDto.fromJson(const <String,dynamic>{}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reservation_id': reservationId,
      'cinema_id': cinemaId,
      'concession_data': concessionData?.map((e) => e.toJson()).toList(),
      'concession_price_in_cents': concessionPriceInCents,
      'concession_tax_in_cents': concessionTaxInCents,
      'ticket_price_in_cents': ticketPriceInCents,
      'ticket_tax_in_cents': ticketTaxInCents,
      'customer_email': customerEmail,
      'customer_contact': customerContact,
      'customer_country_code': customerCountryCode,
      'seat_name': seatName,
      'screen': screen,
      'session_id': sessionId,
      'total_seats' :totalSeats,
      'vista_booking_id': vistaBookingId,
      'movie': movie?.toJson(),
      'cinema': cinema?.toJson(),
      'show_date' : showDate,
      'show_time' : showTime,
      'seat_data': seatData,
      'show_date_time': showDateTime?.toIso8601String(),
      'is_only_fnb': isOnlyFAndB
    };
  }

  ReservationDetailsDto copyWith({
    String? reservationId,
    int? cinemaId,
    List<ConcessionDto>? concessionData,
    int? concessionPriceInCents,
    int? concessionTaxInCents,
    int? ticketPriceInCents,
    int? ticketTaxInCents,
    String? customerEmail,
    String? customerContact,
    String? customerCountryCode,
    String? screen,
    String? sessionId,
    DateTime? showDateTime,
    List<SeatDetailsDto>? seatName,
    String? vistaBookingId,
    MovieDto? movie,
    CinemaDto? cinema,
     String? showDate,
     String? showTime,
     num? totalSeats,
     List<Map<String,dynamic>>? seatData ,
     bool? isOnlyFAndB ,
  }) {
    return ReservationDetailsDto(
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

  static ReservationDetailsModel toDomainModel(ReservationDetailsDto reservationDetailsDto) {
    return ReservationDetailsModel(
      reservationId: reservationDetailsDto.reservationId ?? '',
      cinemaId: reservationDetailsDto.cinemaId ?? 0,
      concessionData: reservationDetailsDto.concessionData
          ?.map((concession) => ConcessionDto.toDomainModel(concession))
          .toList() ?? [],
      concessionPriceInCents: reservationDetailsDto.concessionPriceInCents ?? 0,
      concessionTaxInCents: reservationDetailsDto.concessionTaxInCents ?? 0,
      ticketPriceInCents: reservationDetailsDto.ticketPriceInCents ?? 0,
      ticketTaxInCents: reservationDetailsDto.ticketTaxInCents ?? 0,
      customerEmail: reservationDetailsDto.customerEmail ?? '',
      customerContact: reservationDetailsDto.customerContact ?? '',
      customerCountryCode: reservationDetailsDto.customerCountryCode ?? '',
      seatName: reservationDetailsDto.seatName
          ?.map((seatDetails) => SeatDetailsDto.toDomainModel(seatDetails))
          .toList() ?? [],
      screen: reservationDetailsDto.screen ?? '',
      sessionId: reservationDetailsDto.sessionId ?? '',
      vistaBookingId: reservationDetailsDto.vistaBookingId ?? '',
      movie: reservationDetailsDto.movie != null
          ? MovieDto.toDomainModel(reservationDetailsDto.movie!)
          : null,
      seatData: reservationDetailsDto.seatData,
      isOnlyFAndB: reservationDetailsDto.isOnlyFAndB,
      showDate: reservationDetailsDto.showDate,
      showTime: reservationDetailsDto.showTime,
      totalSeats: reservationDetailsDto.totalSeats,
        showDateTime : reservationDetailsDto.showDateTime,
      cinema: reservationDetailsDto.cinema != null
          ? CinemaDto.toDomainModel(reservationDetailsDto.cinema!)
          : null,
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
    vistaBookingId,
    isOnlyFAndB,
    totalSeats,
    movie,
    cinema,
    showDateTime
  ];

  @override
  String toString() {
    return 'ReservationDetailsDto('
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
        'showDateTime: $showDateTime, '
        'seatData: $seatData, '
        'isOnlyFAndB: $isOnlyFAndB, '
        'totalSeats: $totalSeats, '
        'vistaBookingId: $vistaBookingId, '
        'movie: $movie, '
        'cinema: $cinema,'
        ')';
  }
}