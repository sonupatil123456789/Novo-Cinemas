import 'package:equatable/equatable.dart';
import 'package:novocinema/src/Offers/domain/models/BankOfferModel.dart';

class OfferDetailsDto extends Equatable {
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

  const OfferDetailsDto({
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

  factory OfferDetailsDto.fromJson(Map<String, dynamic> json) => OfferDetailsDto(
    vistaTicketTypeCode: json['vista_ticket_type_code'] as String? ?? '',
    displayName: json['display_name'] as String? ?? '',
    displayNameAr: json['display_name_ar'] as String? ?? '',
    offerDesc: json['offer_desc'] as String? ?? '',
    offerDescAr: json['offer_desc_ar'] as String? ?? '',
    offerImage1: json['offer_image_1'] as String ? ?? '',
    offerImage2: json['offer_image_2'] as String? ?? '',
    offerOrder: json['offer_order'] as num? ?? 0,
    offerTnc: json['offer_tnc'] as String? ?? '',
    offerTncAr: json['offer_tnc_ar'] as String? ?? '',
    offerGroupName: json['offer_group_name'] as String? ??'',
  );

  Map<String, dynamic> toJson() => {
    'vista_ticket_type_code': vistaTicketTypeCode,
    'display_name': displayName,
    'display_name_ar': displayNameAr,
    'offer_desc': offerDesc,
    'offer_desc_ar': offerDescAr,
    'offer_image_1': offerImage1,
    'offer_image_2': offerImage2,
    'offer_order': offerOrder,
    'offer_tnc': offerTnc,
    'offer_tnc_ar': offerTncAr,
    'offer_group_name': offerGroupName,
  };

  OfferDetailsDto copyWith({
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
    return OfferDetailsDto(
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

  static OfferDetailsModel toDomainModel(OfferDetailsDto offerDetailsDto) {
    return OfferDetailsModel(
      displayName: offerDetailsDto.displayName,
      displayNameAr: offerDetailsDto.displayNameAr,
      offerDesc: offerDetailsDto.offerDesc,
      offerDescAr: offerDetailsDto.offerDescAr,
      offerGroupName: offerDetailsDto.offerGroupName,
      offerImage1: offerDetailsDto.offerImage1,
      offerImage2: offerDetailsDto.offerImage2,
      offerOrder: offerDetailsDto.offerOrder,
      offerTnc: offerDetailsDto.offerTnc,
      offerTncAr: offerDetailsDto.offerTncAr,
      vistaTicketTypeCode: offerDetailsDto.vistaTicketTypeCode
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
    return 'OfferDetailsDto(vistaTicketTypeCode: $vistaTicketTypeCode, displayName: $displayName, displayNameAr: $displayNameAr, offerDesc: $offerDesc, offerDescAr: $offerDescAr, offerImage1: $offerImage1, offerImage2: $offerImage2, offerOrder: $offerOrder, offerTnc: $offerTnc, offerTncAr: $offerTncAr, offerGroupName: $offerGroupName)';
  }
}