import 'package:equatable/equatable.dart';

class AllGiftCardModel extends Equatable {
  final String? id;
  final String? headOfficeItemCode;
  final String? description;
  final String? descriptionAlt;
  final int? minPrice;
  final int? maxPrice;
  final int? cinemaId;

  AllGiftCardModel({
    this.id = '',
    this.headOfficeItemCode = '',
    this.description = '',
    this.descriptionAlt = '',
    this.minPrice = 0,
    this.maxPrice = 0,
    this.cinemaId = 0,
  });

  AllGiftCardModel copyWith({
    String? id,
    String? headOfficeItemCode,
    String? description,
    String? descriptionAlt,
    int? minPrice,
    int? maxPrice,
    int? cinemaId,
  }) =>
      AllGiftCardModel(
        id: id ?? this.id,
        headOfficeItemCode: headOfficeItemCode ?? this.headOfficeItemCode,
        description: description ?? this.description,
        descriptionAlt: descriptionAlt ?? this.descriptionAlt,
        minPrice: minPrice ?? this.minPrice,
        maxPrice: maxPrice ?? this.maxPrice,
        cinemaId: cinemaId ?? this.cinemaId,
      );

  @override
  List<Object?> get props =>
      [id, headOfficeItemCode, description, descriptionAlt, minPrice, maxPrice, cinemaId];

  @override
  String toString() {
    return 'AllGiftCardModel('
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
