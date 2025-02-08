import 'package:equatable/equatable.dart';

import '../../domain/models/ConcessionCategoryModel.dart';
import 'ConcessionItemDto.dart';

class ConcessionCategoryDto extends Equatable {
  final int vistaConcessionCategoryId;
  final String name;
  final List<ConcessionItemDto> concessionItems;

  const ConcessionCategoryDto({
    this.vistaConcessionCategoryId = 0,
    this.name = '',
    this.concessionItems = const [],
  });

  factory ConcessionCategoryDto.fromJson(Map<String, dynamic> json) {
    return ConcessionCategoryDto(
      vistaConcessionCategoryId: json['vista_concession_category_id'] ?? 0,
      name: json['name'] ?? '',
      concessionItems: (json['ConcessionItems'] as List?)
          ?.map((item) => ConcessionItemDto.fromJson(item))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vista_concession_category_id': vistaConcessionCategoryId,
      'name': name,
      'ConcessionItems': concessionItems.map((item) => item.toJson()).toList(),
    };
  }

  ConcessionCategoryDto copyWith({
    int? vistaConcessionCategoryId,
    String? name,
    List<ConcessionItemDto>? concessionItems,
  }) {
    return ConcessionCategoryDto(
      vistaConcessionCategoryId: vistaConcessionCategoryId ?? this.vistaConcessionCategoryId,
      name: name ?? this.name,
      concessionItems: concessionItems ?? this.concessionItems,
    );
  }

  static ConcessionCategoryModel toDomainModel(ConcessionCategoryDto concessionCategoryDto ){
    return ConcessionCategoryModel(
      name: concessionCategoryDto.name,
      vistaConcessionCategoryId: concessionCategoryDto.vistaConcessionCategoryId,
      concessionItems: concessionCategoryDto.concessionItems.map((toElement)=>ConcessionItemDto.toDomainModel(toElement)).toList()
    );
  }

  @override
  List<Object?> get props => [vistaConcessionCategoryId, name, concessionItems];

  @override
  String toString() {
    return 'ConcessionCategoryDto(vistaConcessionCategoryId: $vistaConcessionCategoryId, name: $name, concessionItems: $concessionItems)';
  }


}
