import 'package:equatable/equatable.dart';
import 'package:novocinema/src/Tickets/domain/models/ModifierModel.dart';


class ConcessionModel extends Equatable {
  final int? quantity;
  final List<ModifierModel>? modifiers;
  final String? concessionName;
  final String? concessionNameAr;
  final String? concessionImageUrl;
  final String? concessionId;

  const ConcessionModel({
    this.quantity = 0,
    this.modifiers = const [],
    this.concessionName = '',
    this.concessionNameAr = '',
    this.concessionId = '',
    this.concessionImageUrl = '',
  });



  ConcessionModel copyWith({
    int? quantity,
    List<ModifierModel>? modifiers,
    String? concessionName,
    String? concessionNameAr,
    String? concessionImageUrl,
    String ? concessionId ,
  }) {
    return ConcessionModel(
      quantity: quantity ?? this.quantity,
      modifiers: modifiers ?? this.modifiers,
      concessionId : concessionId?? this.concessionId,
      concessionName: concessionName ?? this.concessionName,
      concessionNameAr: concessionNameAr ?? this.concessionNameAr,
      concessionImageUrl: concessionImageUrl ?? this.concessionImageUrl,
    );
  }

  @override
  List<Object?> get props => [
    quantity,
    modifiers,
    concessionName,
    concessionId,
    concessionNameAr,
    concessionImageUrl,
  ];

  @override
  String toString() {
    return 'ConcessionModel('
        'quantity: $quantity, '
        'modifiers: $modifiers, '
        'concessionName: $concessionName, '
        'concessionNameAr: $concessionNameAr, '
        'concessionId: $concessionId, '
        'concessionImageUrl: $concessionImageUrl'
        ')';
  }
}