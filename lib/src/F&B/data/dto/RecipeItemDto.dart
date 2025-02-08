import 'package:equatable/equatable.dart';

import '../../domain/models/RecipeItemModel.dart';
import 'AlternateItemDto.dart';

class RecipeItemDto extends Equatable {
  final String description;
  final String descriptionAlt;
  final String fkConcessionItemId;
  final int quantity;
  final String vistaCinemaId;
  final String vistaRecipeId;
  final List<AlternateItemDto> alternateItems;

  const RecipeItemDto({
    this.description = '',
    this.descriptionAlt = '',
    this.fkConcessionItemId = '',
    this.quantity = 0,
    this.vistaCinemaId = '',
    this.vistaRecipeId = '',
    this.alternateItems = const [],
  });

  factory RecipeItemDto.fromJson(Map<String, dynamic> json) {
    return RecipeItemDto(
      description: json['description'] ?? '',
      descriptionAlt: json['description_alt'] ?? '',
      fkConcessionItemId: json['fk_concession_item_id'] ?? '',
      quantity: json['quantity'] ?? 0,
      vistaCinemaId: json['vista_cinema_id'] ?? '',
      vistaRecipeId: json['vista_recipe_id'] ?? '',
      alternateItems: (json['AlternateItems'] as List?)
          ?.map((item) => AlternateItemDto.fromJson(item))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'description_alt': descriptionAlt,
      'fk_concession_item_id': fkConcessionItemId,
      'quantity': quantity,
      'vista_cinema_id': vistaCinemaId,
      'vista_recipe_id': vistaRecipeId,
      'AlternateItems': alternateItems.map((item) => item.toJson()).toList(),
    };
  }

  RecipeItemDto copyWith({
    String? description,
    String? descriptionAlt,
    String? fkConcessionItemId,
    int? quantity,
    String? vistaCinemaId,
    String? vistaRecipeId,
    List<AlternateItemDto>? alternateItems,
  }) {
    return RecipeItemDto(
      description: description ?? this.description,
      descriptionAlt: descriptionAlt ?? this.descriptionAlt,
      fkConcessionItemId: fkConcessionItemId ?? this.fkConcessionItemId,
      quantity: quantity ?? this.quantity,
      vistaCinemaId: vistaCinemaId ?? this.vistaCinemaId,
      vistaRecipeId: vistaRecipeId ?? this.vistaRecipeId,
      alternateItems: alternateItems ?? this.alternateItems,
    );
  }

  static RecipeItemModel toDomainModel(RecipeItemDto recipeItemDto ){
    return RecipeItemModel(
      descriptionAlt: recipeItemDto.descriptionAlt,
      description: recipeItemDto.description,
      alternateItems: recipeItemDto.alternateItems.map((toElement)=>AlternateItemDto.toDomainModel(toElement) ).toList(),
      fkConcessionItemId: recipeItemDto.fkConcessionItemId,
        quantity:  recipeItemDto.quantity,
      vistaCinemaId: recipeItemDto.vistaCinemaId,
      vistaRecipeId: recipeItemDto.vistaRecipeId
    );
  }



  @override
  List<Object?> get props => [
    description,
    descriptionAlt,
    fkConcessionItemId,
    quantity,
    vistaCinemaId,
    vistaRecipeId,
    alternateItems,
  ];

  @override
  String toString() {
    return 'RecipeItemDto(description: $description, descriptionAlt: $descriptionAlt, fkConcessionItemId: $fkConcessionItemId, quantity: $quantity, vistaCinemaId: $vistaCinemaId, vistaRecipeId: $vistaRecipeId, alternateItems: $alternateItems)';
  }
}
