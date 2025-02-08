import 'package:equatable/equatable.dart';

class OfferDetailsModel extends Equatable {
  final String? vistaTicketTypeCode;
  final String? displayName;
  final String? displayNameAr;
  final String? offerDesc;
  final String? offerDescAr;
  final String? offerImage1;
  final String? offerImage2;
  final num? offerOrder;
  final String? offerTnc;
  final String? offerTncAr;
  final String? offerGroupName;

  const OfferDetailsModel({
    this.vistaTicketTypeCode = '',
    this.displayName = '',
    this.displayNameAr = '',
    this.offerDesc = '',
    this.offerDescAr = '',
    this.offerImage1 = '',
    this.offerImage2 = '',
    this.offerOrder = 0,
    this.offerTnc  = '',
    this.offerTncAr= '',
    this.offerGroupName = '',
  });



  OfferDetailsModel copyWith({
    String? vistaTicketTypeCode,
    String? displayName,
    String? displayNameAr,
    String? offerDesc,
    String? offerDescAr,
    String? offerImage1,
    String? offerImage2,
     num? offerOrder,
    String? offerTnc,
    String? offerTncAr,
    String? offerGroupName,
  }) {
    return OfferDetailsModel(
      vistaTicketTypeCode: vistaTicketTypeCode ?? this.vistaTicketTypeCode,
      displayName: displayName ?? this.displayName,
      displayNameAr: displayNameAr ?? this.displayNameAr,
      offerDesc: offerDesc ?? this.offerDesc,
      offerDescAr: offerDescAr ?? this.offerDescAr,
      offerImage1: offerImage1 ?? this.offerImage1,
      offerImage2: offerImage2 ?? this.offerImage2,
      offerOrder: offerOrder ?? this.offerOrder,
      offerTnc: offerTnc ?? this.offerTnc,
      offerTncAr: offerTncAr ?? this.offerTncAr,
      offerGroupName: offerGroupName ?? this.offerGroupName,
    );
  }

  @override
  List<Object?> get props => [
    vistaTicketTypeCode,
    displayName,
    displayNameAr,
    offerDesc,
    offerDescAr,
    offerImage1,
    offerImage2,
    offerOrder,
    offerTnc,
    offerTncAr,
    offerGroupName,
  ];

  @override
  String toString() {
    return 'OfferDetailsModel(vistaTicketTypeCode: $vistaTicketTypeCode, displayName: $displayName, displayNameAr: $displayNameAr, offerDesc: $offerDesc, offerDescAr: $offerDescAr, offerImage1: $offerImage1, offerImage2: $offerImage2, offerOrder: $offerOrder, offerTnc: $offerTnc, offerTncAr: $offerTncAr, offerGroupName: $offerGroupName)';
  }
}