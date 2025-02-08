import 'package:equatable/equatable.dart';

import '../../domain/models/AllGiftCardModel.dart';

class AllGiftCardDto extends Equatable {
  final String? id;
  final String? headOfficeItemCode;
  final String? description;
  final String? descriptionAlt;
  final int? minPrice;
  final int? maxPrice;
  final int? cinemaId;

  AllGiftCardDto({
    this.id = '',
    this.headOfficeItemCode = '',
    this.description = '',
    this.descriptionAlt = '',
    this.minPrice = 0,
    this.maxPrice = 0,
    this.cinemaId = 0,
  });

  factory AllGiftCardDto.fromJson(Map<String, dynamic> json) => AllGiftCardDto(
        id: json["Id"] ?? '',
        headOfficeItemCode: json["HeadOfficeItemCode"] ?? '',
        description: json["Description"] ?? '',
        descriptionAlt: json["DescriptionAlt"] ?? '',
        minPrice: json["MinPrice"] ?? 0,
        maxPrice: json["MaxPrice"] ?? 0,
        cinemaId: json["CinemaId"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "HeadOfficeItemCode": headOfficeItemCode,
        "Description": description,
        "DescriptionAlt": descriptionAlt,
        "MinPrice": minPrice,
        "MaxPrice": maxPrice,
        "CinemaId": cinemaId,
      };

  AllGiftCardDto copyWith({
    String? id,
    String? headOfficeItemCode,
    String? description,
    String? descriptionAlt,
    int? minPrice,
    int? maxPrice,
    int? cinemaId,
  }) =>
      AllGiftCardDto(
        id: id ?? this.id,
        headOfficeItemCode: headOfficeItemCode ?? this.headOfficeItemCode,
        description: description ?? this.description,
        descriptionAlt: descriptionAlt ?? this.descriptionAlt,
        minPrice: minPrice ?? this.minPrice,
        maxPrice: maxPrice ?? this.maxPrice,
        cinemaId: cinemaId ?? this.cinemaId,
      );

  static AllGiftCardModel toDomainModel(AllGiftCardDto allGiftCardDto) {
    return AllGiftCardModel(
      id: allGiftCardDto.id,
      headOfficeItemCode: allGiftCardDto.headOfficeItemCode,
      description: allGiftCardDto.description,
      descriptionAlt: allGiftCardDto.descriptionAlt,
      minPrice: allGiftCardDto.minPrice,
      maxPrice: allGiftCardDto.maxPrice,
      cinemaId: allGiftCardDto.cinemaId
    );
  }

  @override
  List<Object?> get props =>
      [id, headOfficeItemCode, description, descriptionAlt, minPrice, maxPrice, cinemaId];

  @override
  String toString() {
    return 'AllGiftCardDto('
        'id: $id,'
        'headOfficeItemCode: $headOfficeItemCode,'
        'description: $description,'
        'descriptionAlt: $descriptionAlt,'
        'minPrice: $minPrice,'
        'maxPrice: $maxPrice,'
        'cinemaId: $cinemaId,'
        ')';
  }
}
