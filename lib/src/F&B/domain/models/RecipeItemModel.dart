import 'package:equatable/equatable.dart';

import 'AlternateItemModel.dart';

class RecipeItemModel extends Equatable {
  final String? description;
  final String? descriptionAlt;
  final String? fkConcessionItemId;
  final int? quantity;
  final String? vistaCinemaId;
  final String? vistaRecipeId;
  final List<AlternateItemModel>? alternateItems;

  const RecipeItemModel({
    this.description = '',
    this.descriptionAlt = '',
    this.fkConcessionItemId = '',
    this.quantity = 0,
    this.vistaCinemaId = '',
    this.vistaRecipeId = '',
    this.alternateItems = const [],
  });



  RecipeItemModel copyWith({
    String? description,
    String? descriptionAlt,
    String? fkConcessionItemId,
    int? quantity,
    String? vistaCinemaId,
    String? vistaRecipeId,
    List<AlternateItemModel>? alternateItems,
  }) {
    return RecipeItemModel(
      description: description ?? this.description,
      descriptionAlt: descriptionAlt ?? this.descriptionAlt,
      fkConcessionItemId: fkConcessionItemId ?? this.fkConcessionItemId,
      quantity: quantity ?? this.quantity,
      vistaCinemaId: vistaCinemaId ?? this.vistaCinemaId,
      vistaRecipeId: vistaRecipeId ?? this.vistaRecipeId,
      alternateItems: alternateItems ?? this.alternateItems,
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
    return 'RecipeItemModel(description: $description, descriptionAlt: $descriptionAlt, fkConcessionItemId: $fkConcessionItemId, quantity: $quantity, vistaCinemaId: $vistaCinemaId, vistaRecipeId: $vistaRecipeId, alternateItems: $alternateItems)';
  }
}
