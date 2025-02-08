import 'package:equatable/equatable.dart';

class CinemaModel extends Equatable {
  final String? name;
  final String? nameAr;

  const CinemaModel({
    this.name = '',
    this.nameAr = '',
  });

  factory CinemaModel.fromJson(Map<String, dynamic> json) {
    return CinemaModel(
      name: json['name'],
      nameAr: json['name_ar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'name_ar': nameAr,
    };
  }

  CinemaModel copyWith({
    String? name,
    String? nameAr,
  }) {
    return CinemaModel(
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
    );
  }

  @override
  List<Object?> get props => [name, nameAr];

  @override
  String toString() {
    return 'CinemaModel(name: $name, nameAr: $nameAr)';
  }
}