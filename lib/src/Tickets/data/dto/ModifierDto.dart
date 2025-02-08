import 'package:equatable/equatable.dart';

import '../../domain/models/ModifierModel.dart';

class ModifierDto extends Equatable {
  final int? quantity;
  final String? description;
  final String? displayName;
  final int? taxInCents;
  final int? priceInCents;
  final String? descriptionAlt;
  final String? displayNameAr;
  final String? vistaModifierId;
  final String? modifierImageUrl;

  const ModifierDto({
    this.quantity = 0,
    this.description = '',
    this.displayName = '',
    this.taxInCents = 0,
    this.priceInCents = 0,
    this.descriptionAlt = '',
    this.displayNameAr = '',
    this.vistaModifierId = '',
    this.modifierImageUrl = '',
  });

  factory ModifierDto.fromJson(Map<String, dynamic> json) {
    return ModifierDto(
      quantity: json['quantity'] ??0,
      description: json['description'] ?? '',
      displayName: json['display_name'] ?? '',
      taxInCents: json['tax_in_cents'] ?? 0,
      priceInCents: json['price_in_cents'] ?? 0,
      descriptionAlt: json['description_alt'] ?? '',
      displayNameAr: json['display_name_ar'] ?? '',
      vistaModifierId: json['vista_modifier_id'] ?? '',
      modifierImageUrl: json['modifier_image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'description': description,
      'display_name': displayName,
      'tax_in_cents': taxInCents,
      'price_in_cents': priceInCents,
      'description_alt': descriptionAlt,
      'display_name_ar': displayNameAr,
      'vista_modifier_id': vistaModifierId,
      'modifier_image_url': modifierImageUrl,
    };
  }

  ModifierDto copyWith({
    int? quantity,
    String? description,
    String? displayName,
    int? taxInCents,
    int? priceInCents,
    String? descriptionAlt,
    String? displayNameAr,
    String? vistaModifierId,
    String? modifierImageUrl,
  }) {
    return ModifierDto(
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
      displayName: displayName ?? this.displayName,
      taxInCents: taxInCents ?? this.taxInCents,
      priceInCents: priceInCents ?? this.priceInCents,
      descriptionAlt: descriptionAlt ?? this.descriptionAlt,
      displayNameAr: displayNameAr ?? this.displayNameAr,
      vistaModifierId: vistaModifierId ?? this.vistaModifierId,
      modifierImageUrl: modifierImageUrl ?? this.modifierImageUrl,
    );
  }

  static ModifierModel toDomainModel(ModifierDto modifierDto) {
    return ModifierModel(
      quantity: modifierDto.quantity ?? 0,
      description: modifierDto.description ?? '',
      displayName: modifierDto.displayName ?? '',
      taxInCents: modifierDto.taxInCents ?? 0,
      priceInCents: modifierDto.priceInCents ?? 0,
      descriptionAlt: modifierDto.descriptionAlt ?? '',
      displayNameAr: modifierDto.displayNameAr ?? '',
      vistaModifierId: modifierDto.vistaModifierId ?? '',
      modifierImageUrl: modifierDto.modifierImageUrl ?? '',
    );
  }

  @override
  List<Object?> get props => [
    quantity,
    description,
    displayName,
    taxInCents,
    priceInCents,
    descriptionAlt,
    displayNameAr,
    vistaModifierId,
    modifierImageUrl,
  ];

  @override
  String toString() {
    return 'ModifierDto('
        'quantity: $quantity, '
        'description: $description, '
        'displayName: $displayName, '
        'taxInCents: $taxInCents, '
        'priceInCents: $priceInCents, '
        'descriptionAlt: $descriptionAlt, '
        'displayNameAr: $displayNameAr, '
        'vistaModifierId: $vistaModifierId, '
        'modifierImageUrl: $modifierImageUrl'
        ')';
  }


}
