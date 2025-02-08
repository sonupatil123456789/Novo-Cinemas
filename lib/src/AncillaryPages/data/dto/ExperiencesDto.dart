import 'package:equatable/equatable.dart';

import '../../domain/models/ExperiencesModel.dart';

class ExperiencesDto extends Equatable {
  final String logo;
  final int ogId;
  final String banner;
  final List<int> country;
  final String feature;
  final List<FeatureDto> featureArray;

  // final List<GalleryArray> galleryArray;
  final String experienceName;
  final String descriptionTitle;
  final List<int>? exp;

  // final List<CinemaExpList>? cinemaExpList;

  const ExperiencesDto({
    this.logo = '',
    this.ogId = 0,
    this.banner = '',
    this.country = const [],
    this.feature = '',
    this.featureArray = const [],
    // this.galleryArray = const [],
    this.experienceName = '',
    this.descriptionTitle = '',
    this.exp = const [],
    // this.cinemaExpList = const [],
  });

  factory ExperiencesDto.fromJson(Map<String, dynamic> json) => ExperiencesDto(
        logo: json["logo"] ?? '',
        ogId: json["og_id"] ?? 0,
        banner: json["banner"] ?? '',
        country: json["country"] == null
            ? []
            : List<int>.from(json["country"].map((x) => x)),
        feature: json["feature"] ?? '',
        featureArray: (json['featureArray'] as List?)
                ?.map((item) => FeatureDto.fromJson(item))
                .toList() ??
            [],
        // galleryArray: List<GalleryArray>.from(json["galleryArray"].map((x) => GalleryArray.fromJson(x))),
        experienceName: json["experience_name"] ?? '',
        descriptionTitle: json["description_title"] ?? '',
        exp: json["exp"] == null
            ? []
            : List<int>.from(json["exp"]!.map((x) => x)),
        // cinemaExpList: json["cinema_exp_list"] == null ? [] : List<CinemaExpList>.from(json["cinema_exp_list"]!.map((x) => CinemaExpList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "logo": logo,
        "og_id": ogId,
        "banner": banner,
        "country": List<dynamic>.from(country.map((x) => x)),
        "feature": feature,
        "featureArray": featureArray.map((item) => item.toJson()).toList(),
        // "galleryArray": List<dynamic>.from(galleryArray.map((x) => x.toJson())),
        "experience_name": experienceName,
        "description_title": descriptionTitle,
        "exp": exp == null ? [] : List<dynamic>.from(exp!.map((x) => x)),
        // "cinema_exp_list": cinemaExpList == null
        //     ? []
        //     : List<dynamic>.from(cinemaExpList!.map((x) => x.toJson())),
      };

  ExperiencesDto copyWith({
    String? logo,
    int? ogId,
    String? banner,
    List<int>? country,
    String? feature,
    List<FeatureDto>? featureArray,
    // List<GalleryArray>? galleryArray,
    String? experienceName,
    String? descriptionTitle,
    List<int>? exp,
    // List<CinemaExpList>? cinemaExpList,
  }) =>
      ExperiencesDto(
        logo: logo ?? this.logo,
        ogId: ogId ?? this.ogId,
        banner: banner ?? this.banner,
        country: country ?? this.country,
        feature: feature ?? this.feature,
        featureArray: featureArray ?? this.featureArray,
        // galleryArray: galleryArray ?? this.galleryArray,
        experienceName: experienceName ?? this.experienceName,
        descriptionTitle: descriptionTitle ?? this.descriptionTitle,
        exp: exp ?? this.exp,
        // cinemaExpList: cinemaExpList ?? this.cinemaExpList,
      );

  static ExperiencesModel toDomainModel(ExperiencesDto experiencesDto) {
    return ExperiencesModel(
      logo: experiencesDto.logo,
      ogId: experiencesDto.ogId,
      banner: experiencesDto.banner,
      country: experiencesDto.country,
      feature: experiencesDto.feature,
      featureArray: experiencesDto.featureArray
          .map((toElement) => FeatureDto.toDomainModel(toElement))
          .toList(),
      // galleryArray: experiencesDto.galleryArray,
      experienceName: experiencesDto.experienceName,
      descriptionTitle: experiencesDto.descriptionTitle,
      exp: experiencesDto.exp,
      // cinemaExpList: experiencesDto.cinemaExpList,
    );
  }

  @override
  List<Object?> get props => [
        logo,
        ogId,
        banner,
        country,
        feature,
        featureArray,
        // galleryArray,
        experienceName,
        descriptionTitle,
        exp,
        // cinemaExpList,
      ];

  @override
  String toString() {
    return 'ExperiencesDto('
        'logo: $logo,'
        'ogId: $ogId,'
        'banner: $banner,'
        'country: $country,'
        'feature: $feature,'
        'featureArray: $featureArray,'
        // 'galleryArray: $galleryArray,'
        'experienceName: $experienceName,'
        'descriptionTitle: $descriptionTitle,'
        'exp: $exp,'
        // 'cinemaExpList: $cinemaExpList,'
        ')';
  }
}

class FeatureDto extends Equatable {
  final String desc;
  final String icon;
  final String feature;

  FeatureDto({
    this.desc = '',
    this.icon = '',
    this.feature = '',
  });

  factory FeatureDto.fromJson(Map<String, dynamic> json) => FeatureDto(
        desc: json["desc"] ?? '',
        icon: json["icon"] ?? '',
        feature: json["feature"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "desc": desc,
        "icon": icon,
        "feature": feature,
      };

  FeatureDto copyWith({
    String? desc,
    String? icon,
    String? feature,
  }) =>
      FeatureDto(
        desc: desc ?? this.desc,
        icon: icon ?? this.icon,
        feature: feature ?? this.feature,
      );

  static FeatureModel toDomainModel(FeatureDto featureDto) {
    return FeatureModel(
      desc: featureDto.desc,
      icon: featureDto.icon,
      feature: featureDto.feature,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [desc, icon, feature];

  @override
  String toString() {
    return 'FeatureDto('
        'desc: $desc,'
        'icon: $icon,'
        'feature: $feature,'
        ')';
  }
}
