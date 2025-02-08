import 'package:equatable/equatable.dart';

import 'AlternateItemModel.dart';
import 'ModifierGroupsModel.dart';
import 'RecipeItemModel.dart';

class ConcessionItemModel extends Equatable {
  final String? concessionItemName;
  final String? concessionItemNameAr;
  final String? description;
  final String? descriptionAlt;
  final String? extendedDescription;
  final String? extendedDescriptionAlt;
  final int? fkConcessionCategoryId;
  final String? headOfficeItemCode;
  final bool? isAvailableForInSeatDelivery;
  final bool? isAvailableForPickupAtCounter;
  final String? itemClassCode;
  final int? priceInCents;
  final bool? requiresPickup;
  final int? taxInCents;
  final String? vistaCinemaId;
  final String? vistaConcessionId;
  final String? concessionImageUrl;
  final List<RecipeItemModel>? recipeItems;
  final List<AlternateItemModel>? alternateItems;
  final List<ModifierGroupsModel>? modifierGroups;

  const ConcessionItemModel({
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
    this.concessionImageUrl,
    this.recipeItems = const [],
    this.alternateItems = const [],
    this.modifierGroups = const [],
  });




  ConcessionItemModel copyWith({
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
    List<RecipeItemModel>? recipeItems,
    List<AlternateItemModel>? alternateItems,
    List<ModifierGroupsModel>? modifierGroups,
  }) {
    return ConcessionItemModel(
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
    return 'ConcessionItemModel(concessionItemName: $concessionItemName, concessionItemNameAr: $concessionItemNameAr, description: $description, descriptionAlt: $descriptionAlt, extendedDescription: $extendedDescription, extendedDescriptionAlt: $extendedDescriptionAlt, fkConcessionCategoryId: $fkConcessionCategoryId, headOfficeItemCode: $headOfficeItemCode, isAvailableForInSeatDelivery: $isAvailableForInSeatDelivery, isAvailableForPickupAtCounter: $isAvailableForPickupAtCounter, itemClassCode: $itemClassCode, priceInCents: $priceInCents, requiresPickup: $requiresPickup, taxInCents: $taxInCents, vistaCinemaId: $vistaCinemaId, vistaConcessionId: $vistaConcessionId, concessionImageUrl: $concessionImageUrl, recipeItems: $recipeItems, alternateItems: $alternateItems, modifierGroups: $modifierGroups)';
  }
}