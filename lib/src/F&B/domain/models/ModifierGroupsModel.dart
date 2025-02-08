import 'package:equatable/equatable.dart';

import 'ModifierItemModel.dart';

class ModifierGroupsModel extends Equatable {
  final String? description;
  final String? descriptionAlt;
  final String? fkConcessionItemId;
  final int? freeQuantity;
  final int? maximumQuantity;
  final int? minimumQuantity;
  final String? modifierGroupName;
  final String? modifierGroupNameAr;
  final String? vistaCinemaId;
  final String? vistaModifierGroupId;
  final List<ModifierItemModel>? modifierItems;
  final bool ? isButtonEnabled ;

  const ModifierGroupsModel({
    this.description = '',
    this.descriptionAlt = '',
    this.fkConcessionItemId = '',
    this.freeQuantity = 0,
    this.maximumQuantity = 0,
    this.minimumQuantity = 0,
    this.modifierGroupName = '',
    this.modifierGroupNameAr = '',
    this.vistaCinemaId = '',
    this.vistaModifierGroupId = '',
    this.modifierItems = const [],
    this.isButtonEnabled = true
  });

  @override
  List<Object?> get props => [
    description,
    descriptionAlt,
    fkConcessionItemId,
    freeQuantity,
    maximumQuantity,
    minimumQuantity,
    modifierGroupName,
    modifierGroupNameAr,
    vistaCinemaId,
    vistaModifierGroupId,
    modifierItems,
    isButtonEnabled
  ];

  ModifierGroupsModel copyWith({
    String? description,
    String? descriptionAlt,
    String? fkConcessionItemId,
    int? freeQuantity,
    int? maximumQuantity,
    int? minimumQuantity,
    String? modifierGroupName,
    String? modifierGroupNameAr,
    String? vistaCinemaId,
    String? vistaModifierGroupId,
    List<ModifierItemModel>? modifierItems,
    bool ? isButtonEnabled
  }) {
    return ModifierGroupsModel(
      description: description ?? this.description,
      descriptionAlt: descriptionAlt ?? this.descriptionAlt,
      fkConcessionItemId: fkConcessionItemId ?? this.fkConcessionItemId,
      freeQuantity: freeQuantity ?? this.freeQuantity,
      maximumQuantity: maximumQuantity ?? this.maximumQuantity,
      minimumQuantity: minimumQuantity ?? this.minimumQuantity,
      modifierGroupName: modifierGroupName ?? this.modifierGroupName,
      modifierGroupNameAr: modifierGroupNameAr ?? this.modifierGroupNameAr,
      vistaCinemaId: vistaCinemaId ?? this.vistaCinemaId,
      vistaModifierGroupId: vistaModifierGroupId ?? this.vistaModifierGroupId,
      modifierItems: modifierItems ?? this.modifierItems,
        isButtonEnabled : isButtonEnabled ?? this.isButtonEnabled
    );
  }


  @override
  String toString() {
    return 'ModifierGroupsModel(description: $description, descriptionAlt: $descriptionAlt, fkConcessionItemId: $fkConcessionItemId, freeQuantity: $freeQuantity, maximumQuantity: $maximumQuantity, minimumQuantity: $minimumQuantity, modifierGroupName: $modifierGroupName, modifierGroupNameAr: $modifierGroupNameAr, vistaCinemaId: $vistaCinemaId, vistaModifierGroupId: $vistaModifierGroupId, modifierItems: $modifierItems isButtonEnabled: $isButtonEnabled)';
  }
}
