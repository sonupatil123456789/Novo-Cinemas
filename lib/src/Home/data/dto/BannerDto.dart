import 'package:equatable/equatable.dart';
import 'package:novocinema/src/Home/domain/models/BannerModel.dart';
import 'BannerMovieDetailDto.dart';

class BannerDto extends Equatable {
  final String? bannerId;
  final String? bannerImage;
  final String? bannerMobileImage;
  final String? customBannerUrl;
  final String? customClickUrl;
  final String? fkBannerTypeId;
  final BannerMovieDetailsDto? movieDetails ;


  const BannerDto({
    this.bannerId = '',
    this.bannerImage = '',
    this.bannerMobileImage = '',
    this.customBannerUrl = '',
    this.customClickUrl = '',
    this.fkBannerTypeId = '',
    this.movieDetails
  });


  factory BannerDto.fromJson(Map<String, dynamic> json) {
    return BannerDto(
      bannerId: json['banner_id']?.toString() ?? '',
      bannerImage: json['banner_image'] ?? '',
      bannerMobileImage: json['banner_mobile_image'] ?? '',
      customBannerUrl: json['custom_banner_url'] ?? '',
      customClickUrl: json['custom_click_url'],
      fkBannerTypeId: json['fk_banner_type_id']?.toString() ?? '',
        movieDetails : json['movie_details'] != null ? BannerMovieDetailsDto.fromJson(json['movie_details']):  BannerMovieDetailsDto.fromJson(const <String,dynamic>{})

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'banner_id': bannerId,
      'banner_image': bannerImage,
      'banner_mobile_image': bannerMobileImage,
      'custom_banner_url': customBannerUrl,
      'custom_click_url': customClickUrl,
      'fk_banner_type_id': fkBannerTypeId,
      'movie_details': movieDetails?.toJson()
    };
  }

  BannerDto copyWith({
    String? bannerId,
    String? bannerImage,
    String? bannerMobileImage,
    String? customBannerUrl,
    String? customClickUrl,
    String? fkBannerTypeId,
    BannerMovieDetailsDto? movieDetails

  }) {
    return BannerDto(
      bannerId: bannerId ?? this.bannerId,
      bannerImage: bannerImage ?? this.bannerImage,
      bannerMobileImage: bannerMobileImage ?? this.bannerMobileImage,
      customBannerUrl: customBannerUrl ?? this.customBannerUrl,
      customClickUrl: customClickUrl ?? this.customClickUrl,
      fkBannerTypeId: fkBannerTypeId ?? this.fkBannerTypeId,
        movieDetails : movieDetails ?? this.movieDetails
    );
  }

  static BannerModel toDomainModel(BannerDto bannerDto) {
    return BannerModel(
      bannerId: bannerDto.bannerId,
      bannerImage: bannerDto.bannerImage,
      bannerMobileImage: bannerDto.bannerMobileImage,
      customBannerUrl: bannerDto.customBannerUrl,
      customClickUrl: bannerDto.customClickUrl,
      fkBannerTypeId: bannerDto.fkBannerTypeId,
        movieDetails : BannerMovieDetailsDto.toDomainModel(bannerDto.movieDetails!)
    );
  }

  @override
  List<Object?> get props => [
        bannerId,
        bannerImage,
        bannerMobileImage,
        customBannerUrl,
        customClickUrl,
        fkBannerTypeId,
        movieDetails
      ];

  @override
  String toString() {
    return 'BannerDto(bannerId: $bannerId, bannerImage: $bannerImage, bannerMobileImage: $bannerMobileImage, customBannerUrl: $customBannerUrl, customClickUrl: $customClickUrl, fkBannerTypeId: $fkBannerTypeId, movieDetails: $movieDetails)';
  }
}


