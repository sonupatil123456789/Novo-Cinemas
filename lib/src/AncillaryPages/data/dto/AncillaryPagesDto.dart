import 'package:equatable/equatable.dart';
import 'package:novocinema/src/AncillaryPages/data/dto/ExperiencesDto.dart';

import '../../../../entities/dto/ExperienceDto.dart';
import '../../domain/models/AncillaryPagesModel.dart';

class AncillaryPagesDto extends Equatable {
  final List<AncillaryPagesDataDto> data;

  const AncillaryPagesDto({
    this.data = const [],
  });

  factory AncillaryPagesDto.fromJson(Map<String, dynamic> json) =>
      AncillaryPagesDto(
        data: (json['data'] as List?)
                ?.map((item) => AncillaryPagesDataDto.fromJson(item))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        "data": data.map((item) => item.toJson()).toList(),
      };

  AncillaryPagesDto copyWith({
    List<AncillaryPagesDataDto>? data,
  }) =>
      AncillaryPagesDto(
        data: data ?? this.data,
      );

  static AncillaryPagesModel toDomainModel(AncillaryPagesDto experiencesDto) {
    return AncillaryPagesModel(
      data: experiencesDto.data
          .map((toElement) => AncillaryPagesDataDto.toDomainModel(toElement))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'AncillaryPagesDto('
        'data: $data,'
        ')';
  }

  @override
  List<Object?> get props => [data];
}

class AncillaryPagesDataDto extends Equatable {
  final int id;
  final String pageName;
  final String pageDesc;
  final String pageNameAr;
  final String pageDescAr;
  final String key;
  final dynamic pageJson;
  final dynamic pageJsonAr;
  final bool pageIsActive;
  final String createdAt;
  final String updatedAt;
  final dynamic seoMetaId;

  AncillaryPagesDataDto(
      {this.id = 0,
      this.pageName = '',
      this.pageDesc = '',
      this.pageNameAr = '',
      this.pageDescAr = '',
      this.key = '',
      this.pageJson,
      this.pageJsonAr,
      this.pageIsActive = false,
      this.createdAt = '',
      this.updatedAt = '',
      this.seoMetaId});

  factory AncillaryPagesDataDto.fromJson(Map<String, dynamic> json) =>
      AncillaryPagesDataDto(
        id: json["id"] ?? 0,
        pageName: json["page_name"] ?? '',
        pageDesc: json["page_desc"] ?? '',
        pageNameAr: json["page_name_ar"] ?? '',
        pageDescAr: json["page_desc_ar"] ?? '',
        key: json["key"] ?? '',
        pageJson: json['page_json'] != null
            ? json["key"] == '/experiences'
                ? ExperiencesDto.fromJson(json['page_json'])
                : null
            : null,
        pageJsonAr: json['page_json_ar'] != null
            ? json["key"] == '/experiences'
                ? ExperiencesDto.fromJson(json['page_json_ar'])
                : null
            : null,
        pageIsActive: json["page_is_active"] ?? false,
        createdAt: json["created_at"] ?? '',
        updatedAt: json["updated_at"] ?? '',
        seoMetaId: json["seo_meta_id"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "page_name": pageName,
        "page_desc": pageDesc,
        "page_name_ar": pageNameAr,
        "page_desc_ar": pageDescAr,
        "key": key,
        "page_json": pageJson.toJson(),
        "page_json_ar": pageJsonAr.toJson(),
        "page_is_active": pageIsActive,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "seo_meta_id": seoMetaId,
      };

  AncillaryPagesDataDto copyWith({
    int? id,
    String? pageName,
    String? pageDesc,
    String? pageNameAr,
    String? pageDescAr,
    String? key,
    dynamic pageJson,
    dynamic pageJsonAr,
    bool? pageIsActive,
    String? createdAt,
    String? updatedAt,
    dynamic seoMetaId,
  }) =>
      AncillaryPagesDataDto(
        id: id ?? this.id,
        pageName: pageName ?? this.pageName,
        pageDesc: pageDesc ?? this.pageDesc,
        pageNameAr: pageNameAr ?? this.pageNameAr,
        pageDescAr: pageDescAr ?? this.pageDescAr,
        key: key ?? this.key,
        pageJson: pageJson ?? this.pageJson,
        pageJsonAr: pageJsonAr ?? this.pageJsonAr,
        pageIsActive: pageIsActive ?? this.pageIsActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        seoMetaId: seoMetaId ?? this.seoMetaId,
      );

  static AncillaryPagesDataModel toDomainModel(
      AncillaryPagesDataDto ancillaryPagesDataDto) {
    return AncillaryPagesDataModel(
      id: ancillaryPagesDataDto.id,
      pageName: ancillaryPagesDataDto.pageName,
      pageDesc: ancillaryPagesDataDto.pageDesc,
      pageNameAr: ancillaryPagesDataDto.pageNameAr,
      pageDescAr: ancillaryPagesDataDto.pageDescAr,
      key: ancillaryPagesDataDto.key,
      pageJson: ancillaryPagesDataDto.key == '/experiences' ? ExperiencesDto.toDomainModel((ancillaryPagesDataDto.pageJson)) : null,
      pageJsonAr: ancillaryPagesDataDto.key == '/experiences' ? ExperiencesDto.toDomainModel((ancillaryPagesDataDto.pageJsonAr)) : null,
      pageIsActive: ancillaryPagesDataDto.pageIsActive,
      createdAt: ancillaryPagesDataDto.createdAt,
      updatedAt: ancillaryPagesDataDto.updatedAt,
      seoMetaId: ancillaryPagesDataDto.seoMetaId,
    );
  }

  @override
  List<Object?> get props => [
        id,
        pageName,
        pageDesc,
        pageNameAr,
        pageDescAr,
        key,
        pageJson,
        pageJsonAr,
        pageIsActive,
        createdAt,
        updatedAt,
        seoMetaId,
      ];

  @override
  String toString() {
    return 'AncillaryPagesDataDto('
        'id: $id,'
        'pageName: $pageName,'
        'pageDesc: $pageDesc,'
        'pageNameAr: $pageNameAr,'
        'pageDescAr: $pageDescAr,'
        'key: $key,'
        'pageJson: $pageJson,'
        'pageJsonAr: $pageJsonAr,'
        'pageIsActive: $pageIsActive,'
        'createdAt: $createdAt,'
        'updatedAt: $updatedAt,'
        'seoMetaId: $seoMetaId,'
        ')';
  }
}
