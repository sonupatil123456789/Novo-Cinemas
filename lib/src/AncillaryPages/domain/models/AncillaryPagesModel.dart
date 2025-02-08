import 'package:equatable/equatable.dart';

class AncillaryPagesModel extends Equatable {
  final List<AncillaryPagesDataModel> data;

  const AncillaryPagesModel({
    this.data = const [],
  });

  AncillaryPagesModel copyWith({
    List<AncillaryPagesDataModel>? data,
  }) =>
      AncillaryPagesModel(
        data: data ?? this.data,
      );

  @override
  List<Object?> get props => [data];

  @override
  String toString() {
    return 'AncillaryPagesModel('
        'data: $data,'
        ')';
  }
}

class AncillaryPagesDataModel extends Equatable {
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

  const AncillaryPagesDataModel(
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

  AncillaryPagesDataModel copyWith({
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
      AncillaryPagesDataModel(
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
    return 'AncillaryPagesDataModel('
        'id: $id,'
        'pageName: $pageName,'
        'pageDesc: $pageDesc,'
        'pageNameAr: $pageNameAr,'
        'pageDescAr: $pageDescAr,'
        'key: $key,'
        'data: $pageJson,'
        'data: $pageJsonAr,'
        'pageIsActive: $pageIsActive,'
        'createdAt: $createdAt,'
        'updatedAt: $updatedAt,'
        'seoMetaId: $seoMetaId,'
        ')';
  }
}
