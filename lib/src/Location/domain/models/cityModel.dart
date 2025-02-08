import 'package:equatable/equatable.dart';

class CityModel extends Equatable {
  final int? cityId;
  final int? countryId;
  final String? cityName;
  final String? cityNameAr;
  final bool? isActive;
  final bool? isDeleted;
  final int? createdBy;
  final int? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CityModel({
    this.cityId,
    this.countryId,
    this.cityName,
    this.cityNameAr,
    this.isActive,
    this.isDeleted,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      cityId: json["city_id"] ?? 0,
      countryId: json["fk_country_id"] ?? 0,
      cityName: json["city_name"] ?? "",
      cityNameAr: json["city_name_ar"] ?? "",
      isActive: json["is_active"] ?? false,
      isDeleted: json["is_deleted"] ?? false,
      createdBy: json["created_by"] ?? 0,
      updatedBy: json["updated_by"],
      createdAt: json["created_at"] != null
          ? DateTime.parse(json["created_at"])
          : null,
      updatedAt: json["updated_at"] != null
          ? DateTime.parse(json["updated_at"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "city_id": cityId,
      "fk_country_id": countryId,
      "city_name": cityName,
      "city_name_ar": cityNameAr,
      "is_active": isActive,
      "is_deleted": isDeleted,
      "created_by": createdBy,
      "updated_by": updatedBy,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
    };
  }

  CityModel copyWith({
    int? cityId,
    int? countryId,
    String? cityName,
    String? cityNameAr,
    bool? isActive,
    bool? isDeleted,
    int? createdBy,
    int? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CityModel(
      cityId: cityId ?? this.cityId,
      countryId: countryId ?? this.countryId,
      cityName: cityName ?? this.cityName,
      cityNameAr: cityNameAr ?? this.cityNameAr,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        cityId,
        countryId,
        cityName,
        cityNameAr,
        isActive,
        isDeleted,
        createdBy,
        updatedBy,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() {
    return 'CityModel(cityId: $cityId, countryId: $countryId, cityName: $cityName, cityNameAr: $cityNameAr, isActive: $isActive, isDeleted: $isDeleted, createdBy: $createdBy, updatedBy: $updatedBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
