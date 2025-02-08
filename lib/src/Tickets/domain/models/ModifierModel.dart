import 'package:equatable/equatable.dart';

class ModifierModel extends Equatable {
  final int? quantity;
  final String? description;
  final String? displayName;
  final int? taxInCents;
  final int? priceInCents;
  final String? descriptionAlt;
  final String? displayNameAr;
  final String? vistaModifierId;
  final String? modifierImageUrl;

  const ModifierModel({
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


  ModifierModel copyWith({
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
    return ModifierModel(
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
    return 'ModifierModel('
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
