import 'package:equatable/equatable.dart';

import 'ConcessionItemModel.dart';

class ConcessionCategoryModel extends Equatable {
  final int? vistaConcessionCategoryId;
  final String? name;
  final List<ConcessionItemModel>? concessionItems;

  const ConcessionCategoryModel({
    this.vistaConcessionCategoryId = 0,
    this.name = '',
    this.concessionItems = const [],
  });



  ConcessionCategoryModel copyWith({
    int? vistaConcessionCategoryId,
    String? name,
    List<ConcessionItemModel>? concessionItems,
  }) {
    return ConcessionCategoryModel(
      vistaConcessionCategoryId: vistaConcessionCategoryId ?? this.vistaConcessionCategoryId,
      name: name ?? this.name,
      concessionItems: concessionItems ?? this.concessionItems,
    );
  }

  @override
  List<Object?> get props => [vistaConcessionCategoryId, name, concessionItems];

  @override
  String toString() {
    return 'ConcessionCategoryModel(vistaConcessionCategoryId: $vistaConcessionCategoryId, name: $name, concessionItems: $concessionItems)';
  }


}
