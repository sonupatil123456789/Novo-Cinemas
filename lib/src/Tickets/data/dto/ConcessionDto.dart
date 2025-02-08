import 'package:equatable/equatable.dart';

import '../../domain/models/ConcessionModel.dart';
import 'ModifierDto.dart';

class ConcessionDto extends Equatable {
  final int? quantity;
  final List<ModifierDto>? modifiers;
  final String? concessionName;
  final String? concessionNameAr;
  final String? concessionImageUrl;
  final String? concessionId;

  const ConcessionDto({
    this.quantity = 0,
    this.modifiers = const [],
    this.concessionName = '',
    this.concessionNameAr = '',
    this.concessionImageUrl = '',
    this.concessionId = ''
  });

  factory ConcessionDto.fromJson(Map<String, dynamic> json) {
    return ConcessionDto(
      quantity: json['quantity'] ?? 0,
      modifiers: json['modifiers'] != null
          ? (json['modifiers'] as List)
          .map((e) => ModifierDto.fromJson(e))
          .toList()
          : [],
      concessionId: json['concession_id'] ?? '',
      concessionName: json['concession_name'] ?? '',
      concessionNameAr: json['concession_name_ar'] ?? '',
      concessionImageUrl: json['concession_image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'modifiers': modifiers?.map((e) => e.toJson()).toList(),
      'concession_name': concessionName,
      'concession_id': concessionId,
      'concession_name_ar': concessionNameAr,
      'concession_image_url': concessionImageUrl,
    };
  }

  ConcessionDto copyWith({
    int? quantity,
    List<ModifierDto>? modifiers,
    String? concessionName,
    String? concessionNameAr,
    String? concessionImageUrl,
    String? concessionId
  }) {
    return ConcessionDto(
      quantity: quantity ?? this.quantity,
      modifiers: modifiers ?? this.modifiers,
      concessionId : concessionId ?? this.concessionId,
      concessionName: concessionName ?? this.concessionName,
      concessionNameAr: concessionNameAr ?? this.concessionNameAr,
      concessionImageUrl: concessionImageUrl ?? this.concessionImageUrl,
    );
  }

  static ConcessionModel toDomainModel(ConcessionDto concessionDto) {
    return ConcessionModel(
      quantity: concessionDto.quantity ?? 0,
       concessionId: concessionDto.concessionId,
      modifiers: concessionDto.modifiers
          ?.map((modifier) => ModifierDto.toDomainModel(modifier))
          .toList() ?? [],
      concessionName: concessionDto.concessionName ?? '',
      concessionNameAr: concessionDto.concessionNameAr ?? '',
      concessionImageUrl: concessionDto.concessionImageUrl ?? '',
    );
  }

  @override
  List<Object?> get props => [
    quantity,
    modifiers,
    concessionName,
    concessionNameAr,
    concessionImageUrl,
    concessionId
  ];

  @override
  String toString() {
    return 'ConcessionDto('
        'quantity: $quantity, '
        'modifiers: $modifiers, '
        'concessionName: $concessionName, '
        'concessionId: $concessionId, '
        'concessionNameAr: $concessionNameAr, '
        'concessionImageUrl: $concessionImageUrl'
        ')';
  }
}