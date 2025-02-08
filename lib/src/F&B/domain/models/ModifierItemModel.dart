
import 'package:equatable/equatable.dart';

class ModifierItemModel extends Equatable {
  final String? description;
  final String? descriptionAlt;
  final String? fkConcessionItemId;
  final String? fkModifierGroupId;
  final String? headOfficeItemCode;
  final String? modifierItemName;
  final String? modifierItemNameAr;
  final int? priceInCents;
  final int? taxInCents;
  final String? vistaCinemaId;
  final String? vistaModifierId;
   int qty;

   ModifierItemModel({
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
    this.qty = 0
  });



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
    qty
  ];

  ModifierItemModel copyWith({
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
    int? qty
  }) {
    return ModifierItemModel(
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
        qty : qty ?? this.qty
    );
  }

  @override
  String toString() {
    return 'ModifierItemModel(description: $description, descriptionAlt: $descriptionAlt, fkConcessionItemId: $fkConcessionItemId, fkModifierGroupId: $fkModifierGroupId, headOfficeItemCode: $headOfficeItemCode, modifierItemName: $modifierItemName, modifierItemNameAr: $modifierItemNameAr, priceInCents: $priceInCents, taxInCents: $taxInCents, vistaCinemaId: $vistaCinemaId, vistaModifierId: $vistaModifierId, qty: $qty)';
  }
}