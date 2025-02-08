import 'package:equatable/equatable.dart';

class ExperiencesModel extends Equatable {
  final String logo;
  final int ogId;
  final String banner;
  final List<int> country;
  final String feature;
  final List<FeatureModel> featureArray;
  // final List<GalleryArray> galleryArray;
  final String experienceName;
  final String descriptionTitle;
  final List<int>? exp;

  // final List<CinemaExpList>? cinemaExpList;

  const ExperiencesModel({
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

  ExperiencesModel copyWith({
    String? logo,
    int? ogId,
    String? banner,
    List<int>? country,
    String? feature,
    List<FeatureModel>? featureArray,
    // List<GalleryArray>? galleryArray,
    String? experienceName,
    String? descriptionTitle,
    List<int>? exp,
    // List<CinemaExpList>? cinemaExpList,
  }) =>
      ExperiencesModel(
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
    return 'ExperiencesModel('
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

class FeatureModel extends Equatable {
  final String desc;
  final String icon;
  final String feature;

  FeatureModel({
    this.desc = '',
    this.icon = '',
    this.feature = '',
  });

  FeatureModel copyWith({
    String? desc,
    String? icon,
    String? feature,
  }) =>
      FeatureModel(
        desc: desc ?? this.desc,
        icon: icon ?? this.icon,
        feature: feature ?? this.feature,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [desc, icon, feature];

  @override
  String toString() {
    return 'FeatureModel('
        'desc: $desc,'
        'icon: $icon,'
        'feature: $feature,'
        ')';
  }
}
