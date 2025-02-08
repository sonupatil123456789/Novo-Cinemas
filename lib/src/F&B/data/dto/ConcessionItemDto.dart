import 'package:equatable/equatable.dart';
import 'package:novocinema/src/F&B/domain/models/ConcessionItemModel.dart';

import 'AlternateItemDto.dart';
import 'ModifierGroupsDto.dart';
import 'RecipeItemDto.dart';

class ConcessionItemDto extends Equatable {
  final String concessionItemName;
  final String concessionItemNameAr;
  final String description;
  final String descriptionAlt;
  final String extendedDescription;
  final String extendedDescriptionAlt;
  final int fkConcessionCategoryId;
  final String headOfficeItemCode;
  final bool isAvailableForInSeatDelivery;
  final bool isAvailableForPickupAtCounter;
  final String itemClassCode;
  final int priceInCents;
  final bool requiresPickup;
  final int taxInCents;
  final String vistaCinemaId;
  final String vistaConcessionId;
  final String? concessionImageUrl;
  final List<RecipeItemDto> recipeItems;
  final List<AlternateItemDto> alternateItems;
  final List<ModifierGroupDto> modifierGroups;

  const ConcessionItemDto({
    this.concessionItemName = '',
    this.concessionItemNameAr = '',
    this.description = '',
    this.descriptionAlt = '',
    this.extendedDescription = '',
    this.extendedDescriptionAlt = '',
    this.fkConcessionCategoryId = 0,
    this.headOfficeItemCode = '',
    this.isAvailableForInSeatDelivery = false,
    this.isAvailableForPickupAtCounter = false,
    this.itemClassCode = '',
    this.priceInCents = 0,
    this.requiresPickup = false,
    this.taxInCents = 0,
    this.vistaCinemaId = '',
    this.vistaConcessionId = '',
    this.concessionImageUrl = ''    ,
    this.recipeItems = const [],
    this.alternateItems = const [],
    this.modifierGroups = const [],
  });

  factory ConcessionItemDto.fromJson(Map<String, dynamic> json) {
    return ConcessionItemDto(
      concessionItemName: json['concession_item_name'] ?? '',
      concessionItemNameAr: json['concession_item_name_ar'] ?? '',
      description: json['description'] ?? '',
      descriptionAlt: json['description_alt'] ?? '',
      extendedDescription: json['extended_description'] ?? '',
      extendedDescriptionAlt: json['extended_description_alt'] ?? '',
      fkConcessionCategoryId: json['fk_concession_category_id'] ?? 0,
      headOfficeItemCode: json['head_office_item_code'] ?? '',
      isAvailableForInSeatDelivery: json['is_available_for_in_seat_delivery'] ?? false,
      isAvailableForPickupAtCounter: json['is_available_for_pickup_at_counter'] ?? false,
      itemClassCode: json['item_class_code'] ?? '',
      priceInCents: json['price_in_cents'] ?? 0,
      requiresPickup: json['requires_pickup'] ?? false,
      taxInCents: json['tax_in_cents'] ?? 0,
      vistaCinemaId: json['vista_cinema_id'] ?? '',
      vistaConcessionId: json['vista_concession_id'] ?? '',
      concessionImageUrl: json['concession_image_url'] ?? '',
      recipeItems: (json['RecipeItems'] as List?)
          ?.map((item) => RecipeItemDto.fromJson(item))
          .toList() ?? [],
      alternateItems: (json['AlternateItems'] as List?)
          ?.map((item) => AlternateItemDto.fromJson(item))
          .toList() ?? [],
      modifierGroups: (json['ModifierGroups'] as List?)
          ?.map((group) => ModifierGroupDto.fromJson(group))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'concession_item_name': concessionItemName,
      'concession_item_name_ar': concessionItemNameAr,
      'description': description,
      'description_alt': descriptionAlt,
      'extended_description': extendedDescription,
      'extended_description_alt': extendedDescriptionAlt,
      'fk_concession_category_id': fkConcessionCategoryId,
      'head_office_item_code': headOfficeItemCode,
      'is_available_for_in_seat_delivery': isAvailableForInSeatDelivery,
      'is_available_for_pickup_at_counter': isAvailableForPickupAtCounter,
      'item_class_code': itemClassCode,
      'price_in_cents': priceInCents,
      'requires_pickup': requiresPickup,
      'tax_in_cents': taxInCents,
      'vista_cinema_id': vistaCinemaId,
      'vista_concession_id': vistaConcessionId,
      'concession_image_url': concessionImageUrl,
      'RecipeItems': recipeItems.map((item) => item.toJson()).toList(),
      'AlternateItems': alternateItems.map((item) => item.toJson()).toList(),
      'ModifierGroups': modifierGroups.map((group) => group.toJson()).toList(),
    };
  }

  ConcessionItemDto copyWith({
    String? concessionItemName,
    String? concessionItemNameAr,
    String? description,
    String? descriptionAlt,
    String? extendedDescription,
    String? extendedDescriptionAlt,
    int? fkConcessionCategoryId,
    String? headOfficeItemCode,
    bool? isAvailableForInSeatDelivery,
    bool? isAvailableForPickupAtCounter,
    String? itemClassCode,
    int? priceInCents,
    bool? requiresPickup,
    int? taxInCents,
    String? vistaCinemaId,
    String? vistaConcessionId,
    String? concessionImageUrl,
    List<RecipeItemDto>? recipeItems,
    List<AlternateItemDto>? alternateItems,
    List<ModifierGroupDto>? modifierGroups,
  }) {
    return ConcessionItemDto(
      concessionItemName: concessionItemName ?? this.concessionItemName,
      concessionItemNameAr: concessionItemNameAr ?? this.concessionItemNameAr,
      description: description ?? this.description,
      descriptionAlt: descriptionAlt ?? this.descriptionAlt,
      extendedDescription: extendedDescription ?? this.extendedDescription,
      extendedDescriptionAlt: extendedDescriptionAlt ?? this.extendedDescriptionAlt,
      fkConcessionCategoryId: fkConcessionCategoryId ?? this.fkConcessionCategoryId,
      headOfficeItemCode: headOfficeItemCode ?? this.headOfficeItemCode,
      isAvailableForInSeatDelivery: isAvailableForInSeatDelivery ?? this.isAvailableForInSeatDelivery,
      isAvailableForPickupAtCounter: isAvailableForPickupAtCounter ?? this.isAvailableForPickupAtCounter,
      itemClassCode: itemClassCode ?? this.itemClassCode,
      priceInCents: priceInCents ?? this.priceInCents,
      requiresPickup: requiresPickup ?? this.requiresPickup,
      taxInCents: taxInCents ?? this.taxInCents,
      vistaCinemaId: vistaCinemaId ?? this.vistaCinemaId,
      vistaConcessionId: vistaConcessionId ?? this.vistaConcessionId,
      concessionImageUrl: concessionImageUrl ?? this.concessionImageUrl,
      recipeItems: recipeItems ?? this.recipeItems,
      alternateItems: alternateItems ?? this.alternateItems,
      modifierGroups: modifierGroups ?? this.modifierGroups,

    );
  }

  static ConcessionItemModel toDomainModel(ConcessionItemDto concessionItemDto ){
    return ConcessionItemModel(
        descriptionAlt: concessionItemDto.descriptionAlt,
        description: concessionItemDto.description,
        vistaCinemaId: concessionItemDto.vistaCinemaId,
      taxInCents: concessionItemDto.taxInCents,
      headOfficeItemCode: concessionItemDto.headOfficeItemCode,
      priceInCents: concessionItemDto.priceInCents,
     extendedDescriptionAlt: concessionItemDto.extendedDescriptionAlt,
      extendedDescription: concessionItemDto.extendedDescription,
      concessionImageUrl: concessionItemDto.concessionImageUrl,
      alternateItems: concessionItemDto.alternateItems.map((toElement)=>AlternateItemDto.toDomainModel(toElement)).toList(),
      modifierGroups: concessionItemDto.modifierGroups.map((toElement)=>ModifierGroupDto.toDomainModel(toElement)).toList(),
      recipeItems: concessionItemDto.recipeItems.map((toElement)=>RecipeItemDto.toDomainModel(toElement)).toList(),
      concessionItemName: concessionItemDto.concessionItemName,
      concessionItemNameAr: concessionItemDto.concessionItemNameAr,
      fkConcessionCategoryId: concessionItemDto.fkConcessionCategoryId  ,
      isAvailableForInSeatDelivery: concessionItemDto.isAvailableForInSeatDelivery ,
      isAvailableForPickupAtCounter: concessionItemDto.isAvailableForPickupAtCounter,
      itemClassCode: concessionItemDto.itemClassCode ,
      requiresPickup: concessionItemDto.requiresPickup ,
      vistaConcessionId: concessionItemDto.vistaConcessionId,
    );
  }

  @override
  List<Object?> get props => [
    concessionItemName,
    concessionItemNameAr,
    description,
    descriptionAlt,
    extendedDescription,
    extendedDescriptionAlt,
    fkConcessionCategoryId,
    headOfficeItemCode,
    isAvailableForInSeatDelivery,
    isAvailableForPickupAtCounter,
    itemClassCode,
    priceInCents,
    requiresPickup,
    taxInCents,
    vistaCinemaId,
    vistaConcessionId,
    concessionImageUrl,
    recipeItems,
    alternateItems,
    modifierGroups,
  ];

  @override
  String toString() {
    return 'ConcessionItemDto(concessionItemName: $concessionItemName, concessionItemNameAr: $concessionItemNameAr, description: $description, descriptionAlt: $descriptionAlt, extendedDescription: $extendedDescription, extendedDescriptionAlt: $extendedDescriptionAlt, fkConcessionCategoryId: $fkConcessionCategoryId, headOfficeItemCode: $headOfficeItemCode, isAvailableForInSeatDelivery: $isAvailableForInSeatDelivery, isAvailableForPickupAtCounter: $isAvailableForPickupAtCounter, itemClassCode: $itemClassCode, priceInCents: $priceInCents, requiresPickup: $requiresPickup, taxInCents: $taxInCents, vistaCinemaId: $vistaCinemaId, vistaConcessionId: $vistaConcessionId, concessionImageUrl: $concessionImageUrl, recipeItems: $recipeItems, alternateItems: $alternateItems, modifierGroups: $modifierGroups)';
  }
}