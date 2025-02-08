import 'package:equatable/equatable.dart';

class AlternateItemModel extends Equatable {
  final String? alternateItemName;
  final String? alternateItemNameAr;
  final String? description;
  final String? descriptionAlt;
  final String? extendedDescription;
  final String? extendedDescriptionAlt;
  final String? fkConcessionItemId;
  final String? headOfficeItemCode;
  final int? priceInCents;
  final int? taxInCents;
  final String? vistaAlternateItemId;
  final String? vistaCinemaId;

  const AlternateItemModel({
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

  AlternateItemModel copyWith({
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
    return AlternateItemModel(
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
    return 'AlternateItemModel(alternateItemName: $alternateItemName, alternateItemNameAr: $alternateItemNameAr, description: $description, descriptionAlt: $descriptionAlt, extendedDescription: $extendedDescription, extendedDescriptionAlt: $extendedDescriptionAlt, fkConcessionItemId: $fkConcessionItemId, headOfficeItemCode: $headOfficeItemCode, priceInCents: $priceInCents, taxInCents: $taxInCents, vistaAlternateItemId: $vistaAlternateItemId, vistaCinemaId: $vistaCinemaId)';
  }
}