
import 'package:equatable/equatable.dart';
import 'package:novocinema/src/F&B/domain/models/ModifierItemModel.dart';

class ModifierItemDto extends Equatable {
  final String description;
  final String descriptionAlt;
  final String fkConcessionItemId;
  final String fkModifierGroupId;
  final String headOfficeItemCode;
  final String modifierItemName;
  final String modifierItemNameAr;
  final int priceInCents;
  final int taxInCents;
  final String vistaCinemaId;
  final String vistaModifierId;

  const ModifierItemDto({
    this.description = '',
    this.descriptionAlt = '',
    this.fkConcessionItemId = '',
    this.fkModifierGroupId = '',
    this.headOfficeItemCode = '',
    this.modifierItemName = '',
    this.modifierItemNameAr = '',
    this.priceInCents = 0,
    this.taxInCents = 0,
    this.vistaCinemaId = '',
    this.vistaModifierId = '',
  });

  factory ModifierItemDto.fromJson(Map<String, dynamic> json) {
    return ModifierItemDto(
      description: json['description'] ?? '',
      descriptionAlt: json['description_alt'] ?? '',
      fkConcessionItemId: json['fk_concession_item_id'] ?? '',
      fkModifierGroupId: json['fk_modifier_group_id'] ?? '',
      headOfficeItemCode: json['head_office_item_code'] ?? '',
      modifierItemName: json['modifier_item_name'] ?? '',
      modifierItemNameAr: json['modifier_item_name_ar'] ?? '',
      priceInCents: json['price_in_cents'] ?? 0,
      taxInCents: json['tax_in_cents'] ?? 0,
      vistaCinemaId: json['vista_cinema_id'] ?? '',
      vistaModifierId: json['vista_modifier_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'description_alt': descriptionAlt,
      'fk_concession_item_id': fkConcessionItemId,
      'fk_modifier_group_id': fkModifierGroupId,
      'head_office_item_code': headOfficeItemCode,
      'modifier_item_name': modifierItemName,
      'modifier_item_name_ar': modifierItemNameAr,
      'price_in_cents': priceInCents,
      'tax_in_cents': taxInCents,
      'vista_cinema_id': vistaCinemaId,
      'vista_modifier_id': vistaModifierId,
    };
  }

  static ModifierItemModel toDomainModel(ModifierItemDto modifierItemDto ){
    return ModifierItemModel(
        descriptionAlt: modifierItemDto.descriptionAlt,
        description: modifierItemDto.description,
        fkConcessionItemId: modifierItemDto.fkConcessionItemId,
        vistaCinemaId: modifierItemDto.vistaCinemaId,
      taxInCents: modifierItemDto.taxInCents,
      headOfficeItemCode: modifierItemDto.headOfficeItemCode,
      priceInCents: modifierItemDto.priceInCents,
      fkModifierGroupId: modifierItemDto.fkModifierGroupId,
      modifierItemName: modifierItemDto.modifierItemName,
      modifierItemNameAr: modifierItemDto.modifierItemNameAr,
      vistaModifierId: modifierItemDto.vistaModifierId,
    );
  }

  @override
  List<Object?> get props => [
    description,
    descriptionAlt,
    fkConcessionItemId,
    fkModifierGroupId,
    headOfficeItemCode,
    modifierItemName,
    modifierItemNameAr,
    priceInCents,
    taxInCents,
    vistaCinemaId,
    vistaModifierId,
  ];

  ModifierItemDto copyWith({
    String? description,
    String? descriptionAlt,
    String? fkConcessionItemId,
    String? fkModifierGroupId,
    String? headOfficeItemCode,
    String? modifierItemName,
    String? modifierItemNameAr,
    int? priceInCents,
    int? taxInCents,
    String? vistaCinemaId,
    String? vistaModifierId,
  }) {
    return ModifierItemDto(
      description: description ?? this.description,
      descriptionAlt: descriptionAlt ?? this.descriptionAlt,
      fkConcessionItemId: fkConcessionItemId ?? this.fkConcessionItemId,
      fkModifierGroupId: fkModifierGroupId ?? this.fkModifierGroupId,
      headOfficeItemCode: headOfficeItemCode ?? this.headOfficeItemCode,
      modifierItemName: modifierItemName ?? this.modifierItemName,
      modifierItemNameAr: modifierItemNameAr ?? this.modifierItemNameAr,
      priceInCents: priceInCents ?? this.priceInCents,
      taxInCents: taxInCents ?? this.taxInCents,
      vistaCinemaId: vistaCinemaId ?? this.vistaCinemaId,
      vistaModifierId: vistaModifierId ?? this.vistaModifierId,
    );
  }

  @override
  String toString() {
    return 'ModifierItemDto(description: $description, descriptionAlt: $descriptionAlt, fkConcessionItemId: $fkConcessionItemId, fkModifierGroupId: $fkModifierGroupId, headOfficeItemCode: $headOfficeItemCode, modifierItemName: $modifierItemName, modifierItemNameAr: $modifierItemNameAr, priceInCents: $priceInCents, taxInCents: $taxInCents, vistaCinemaId: $vistaCinemaId, vistaModifierId: $vistaModifierId)';
  }
}