import 'package:equatable/equatable.dart';
import 'package:novocinema/src/F&B/domain/models/ModifierGroupsModel.dart';

import 'ModifierItemDto.dart';

class ModifierGroupDto extends Equatable {
  final String description;
  final String descriptionAlt;
  final String fkConcessionItemId;
  final int freeQuantity;
  final int maximumQuantity;
  final int minimumQuantity;
  final String modifierGroupName;
  final String modifierGroupNameAr;
  final String vistaCinemaId;
  final String vistaModifierGroupId;
  final List<ModifierItemDto> modifierItems;

  const ModifierGroupDto({
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
  });

  factory ModifierGroupDto.fromJson(Map<String, dynamic> json) {
    return ModifierGroupDto(
      description: json['description'] ?? '',
      descriptionAlt: json['description_alt'] ?? '',
      fkConcessionItemId: json['fk_concession_item_id'] ?? '',
      freeQuantity: json['free_quantity'] ?? 0,
      maximumQuantity: json['maximum_quantity'] ?? 0,
      minimumQuantity: json['minimum_quantity'] ?? 0,
      modifierGroupName: json['modifier_group_name'] ?? '',
      modifierGroupNameAr: json['modifier_group_name_ar'] ?? '',
      vistaCinemaId: json['vista_cinema_id'] ?? '',
      vistaModifierGroupId: json['vista_modifier_group_id'] ?? '',
      modifierItems: json['modifierItems'] != null
          ? (json['modifierItems'] as List)
          .map((item) => ModifierItemDto.fromJson(item))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'description_alt': descriptionAlt,
      'fk_concession_item_id': fkConcessionItemId,
      'free_quantity': freeQuantity,
      'maximum_quantity': maximumQuantity,
      'minimum_quantity': minimumQuantity,
      'modifier_group_name': modifierGroupName,
      'modifier_group_name_ar': modifierGroupNameAr,
      'vista_cinema_id': vistaCinemaId,
      'vista_modifier_group_id': vistaModifierGroupId,
      'modifierItems': modifierItems.map((item) => item.toJson()).toList(),
    };
  }

  static ModifierGroupsModel toDomainModel(ModifierGroupDto modifierGroupDto ){
    return ModifierGroupsModel(
        descriptionAlt: modifierGroupDto.descriptionAlt,
        description: modifierGroupDto.description,
        fkConcessionItemId: modifierGroupDto.fkConcessionItemId,
        vistaCinemaId: modifierGroupDto.vistaCinemaId,
        freeQuantity: modifierGroupDto.freeQuantity,
        maximumQuantity: modifierGroupDto.maximumQuantity,
        minimumQuantity: modifierGroupDto.minimumQuantity,
        modifierGroupName: modifierGroupDto.modifierGroupName,
        modifierGroupNameAr: modifierGroupDto.modifierGroupNameAr,
        vistaModifierGroupId: modifierGroupDto.vistaModifierGroupId,
        modifierItems: modifierGroupDto.modifierItems.map((toElement)=>ModifierItemDto.toDomainModel(toElement)).toList()
    );
  }

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
  ];

  ModifierGroupDto copyWith({
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
    List<ModifierItemDto>? modifierItems,
  }) {
    return ModifierGroupDto(
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
    );
  }


  @override
  String toString() {
    return 'ModifierGroupDto(description: $description, descriptionAlt: $descriptionAlt, fkConcessionItemId: $fkConcessionItemId, freeQuantity: $freeQuantity, maximumQuantity: $maximumQuantity, minimumQuantity: $minimumQuantity, modifierGroupName: $modifierGroupName, modifierGroupNameAr: $modifierGroupNameAr, vistaCinemaId: $vistaCinemaId, vistaModifierGroupId: $vistaModifierGroupId, modifierItems: $modifierItems)';
  }
}
