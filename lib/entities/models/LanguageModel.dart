

import 'package:equatable/equatable.dart';

class LanguageModel extends Equatable{

  final int ? id;
  final String? name;
  final bool? isActive ;

  const LanguageModel({
    this.id = 0,
    this.name = '',
    this.isActive = false
  });


  LanguageModel copyWith({
    String? name,
    int? id,
    bool? isActive
  }) {
    return LanguageModel(
        id: id ?? this.id,
        name: name ?? this.name,
        isActive:  isActive ?? this.isActive
    );
  }

  @override
  List<Object?> get props => [id, name,isActive];


  @override
  String toString() {
    return 'LanguageModel(id: $id, name: $name , isActive: $isActive)';
  }



}