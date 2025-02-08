import 'package:equatable/equatable.dart';
import 'package:novocinema/src/F&B/domain/models/AlternateItemModel.dart';

class AlternateItemDto extends Equatable {
  final String alternateItemName;
  final String alternateItemNameAr;
  final String description;
  final String descriptionAlt;
  final String extendedDescription;
  final String extendedDescriptionAlt;
  final String fkConcessionItemId;
  final String headOfficeItemCode;
  final int priceInCents;
  final int taxInCents;
  final String vistaAlternateItemId;
  final String vistaCinemaId;

  const AlternateItemDto({
    this.alternateItemName = '',
    this.alternateItemNameAr = '',
    this.description = '',
    this.descriptionAlt = '',
    this.extendedDescription = '',
    this.extendedDescriptionAlt = '',
    this.fkConcessionItemId = '',
    this.headOfficeItemCode = '',
    this.priceInCents = 0,
    this.taxInCents = 0,
    this.vistaAlternateItemId = '',
    this.vistaCinemaId = '',
  });

  factory AlternateItemDto.fromJson(Map<String, dynamic> json) {
    return AlternateItemDto(
      alternateItemName: json['alternate_item_name'] ?? '',
      alternateItemNameAr: json['alternate_item_name_ar'] ?? '',
      description: json['description'] ?? '',
      descriptionAlt: json['description_alt'] ?? '',
      extendedDescription: json['extended_description'] ?? '',
      extendedDescriptionAlt: json['extended_description_alt'] ?? '',
      fkConcessionItemId: json['fk_concession_item_id'] ?? '',
      headOfficeItemCode: json['head_office_item_code'] ?? '',
      priceInCents: json['price_in_cents'] ?? 0,
      taxInCents: json['tax_in_cents'] ?? 0,
      vistaAlternateItemId: json['vista_alternate_item_id'] ?? '',
      vistaCinemaId: json['vista_cinema_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'alternate_item_name': alternateItemName,
      'alternate_item_name_ar': alternateItemNameAr,
      'description': description,
      'description_alt': descriptionAlt,
      'extended_description': extendedDescription,
      'extended_description_alt': extendedDescriptionAlt,
      'fk_concession_item_id': fkConcessionItemId,
      'head_office_item_code': headOfficeItemCode,
      'price_in_cents': priceInCents,
      'tax_in_cents': taxInCents,
      'vista_alternate_item_id': vistaAlternateItemId,
      'vista_cinema_id': vistaCinemaId,
    };
  }

  static AlternateItemModel toDomainModel(AlternateItemDto alternateItemDto ){
    return AlternateItemModel(
        descriptionAlt: alternateItemDto.descriptionAlt,
        description: alternateItemDto.description,
        fkConcessionItemId: alternateItemDto.fkConcessionItemId,
        vistaCinemaId: alternateItemDto.vistaCinemaId,
      priceInCents: alternateItemDto.priceInCents,
      alternateItemName: alternateItemDto.alternateItemName,
      alternateItemNameAr: alternateItemDto.alternateItemNameAr,
      extendedDescription: alternateItemDto.extendedDescription,
      extendedDescriptionAlt: alternateItemDto.extendedDescriptionAlt,
      headOfficeItemCode: alternateItemDto.headOfficeItemCode,
      taxInCents: alternateItemDto.taxInCents,
      vistaAlternateItemId: alternateItemDto.vistaAlternateItemId
    );
  }

  @override
  List<Object?> get props => [
    alternateItemName,
    alternateItemNameAr,
    description,
    descriptionAlt,
    extendedDescription,
    extendedDescriptionAlt,
    fkConcessionItemId,
    headOfficeItemCode,
    priceInCents,
    taxInCents,
    vistaAlternateItemId,
    vistaCinemaId,
  ];

  AlternateItemDto copyWith({
    String? alternateItemName,
    String? alternateItemNameAr,
    String? description,
    String? descriptionAlt,
    String? extendedDescription,
    String? extendedDescriptionAlt,
    String? fkConcessionItemId,
    String? headOfficeItemCode,
    int? priceInCents,
    int? taxInCents,
    String? vistaAlternateItemId,
    String? vistaCinemaId,
  }) {
    return AlternateItemDto(
      alternateItemName: alternateItemName ?? this.alternateItemName,
      alternateItemNameAr: alternateItemNameAr ?? this.alternateItemNameAr,
      description: description ?? this.description,
      descriptionAlt: descriptionAlt ?? this.descriptionAlt,
      extendedDescription: extendedDescription ?? this.extendedDescription,
      extendedDescriptionAlt: extendedDescriptionAlt ?? this.extendedDescriptionAlt,
      fkConcessionItemId: fkConcessionItemId ?? this.fkConcessionItemId,
      headOfficeItemCode: headOfficeItemCode ?? this.headOfficeItemCode,
      priceInCents: priceInCents ?? this.priceInCents,
      taxInCents: taxInCents ?? this.taxInCents,
      vistaAlternateItemId: vistaAlternateItemId ?? this.vistaAlternateItemId,
      vistaCinemaId: vistaCinemaId ?? this.vistaCinemaId,
    );
  }
  @override
  String toString() {
    return 'AlternateItemDto(alternateItemName: $alternateItemName, alternateItemNameAr: $alternateItemNameAr, description: $description, descriptionAlt: $descriptionAlt, extendedDescription: $extendedDescription, extendedDescriptionAlt: $extendedDescriptionAlt, fkConcessionItemId: $fkConcessionItemId, headOfficeItemCode: $headOfficeItemCode, priceInCents: $priceInCents, taxInCents: $taxInCents, vistaAlternateItemId: $vistaAlternateItemId, vistaCinemaId: $vistaCinemaId)';
  }
}