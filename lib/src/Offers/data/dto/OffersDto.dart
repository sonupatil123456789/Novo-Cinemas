import 'package:equatable/equatable.dart';
import 'package:novocinema/src/Offers/domain/models/OffersModel.dart';

import 'OfferDetailsDto.dart';

class OffersDto extends Equatable {
  final List<OfferDetailsDto>? bankOffers;
  final List<OfferDetailsDto>? normalOffers;

  const OffersDto({
    this.bankOffers = const [],
    this.normalOffers = const [],
  });

  factory OffersDto.fromJson(Map<String, dynamic> json) => OffersDto(
        bankOffers: json['bankOffers'] != null
            ? (json['bankOffers'] as List<dynamic>)
                .map((e) => OfferDetailsDto.fromJson(e as Map<String, dynamic>))
                .toList()
            : [],
    normalOffers: json['normalOffers'] != null
        ? (json['normalOffers'] as List<dynamic>)
        .map((e) => OfferDetailsDto.fromJson(e as Map<String, dynamic>))
        .toList()
        : [],
        // normalOffers: json['normalOffers'] as List<dynamic>,
      );

  Map<String, dynamic> toJson() => {
        'bankOffers': bankOffers?.map((e) => e.toJson()).toList(),
    'normalOffers': bankOffers?.map((e) => e.toJson()).toList(),
        // 'normalOffers': normalOffers,
      };

  OffersDto copyWith({
    List<OfferDetailsDto>? bankOffers,
    List<OfferDetailsDto>? normalOffers,
  }) {
    return OffersDto(
      bankOffers: bankOffers ?? this.bankOffers,
      normalOffers: normalOffers ?? this.normalOffers,
    );
  }

  static OffersModel toDomainModel(OffersDto offersDto) {
    return OffersModel(
        bankOffers: offersDto.bankOffers
                ?.map((toElement) => OfferDetailsDto.toDomainModel(toElement))
                .toList() ??[],
        normalOffers: offersDto.normalOffers
            ?.map((toElement) => OfferDetailsDto.toDomainModel(toElement))
            .toList() ??[]
    );
  }

  @override
  List<Object?> get props => [bankOffers, normalOffers];

  @override
  String toString() {
    return 'OffersDto(bankOffers: $bankOffers, normalOffers: $normalOffers)';
  }
}
