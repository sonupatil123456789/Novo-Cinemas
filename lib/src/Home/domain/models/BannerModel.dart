
import 'package:equatable/equatable.dart';

import 'BannerMovieDetailModel.dart';

class BannerModel extends Equatable {
  final String? bannerId;
  final String? bannerImage;
  final String? bannerMobileImage;
  final String? customBannerUrl;
  final String? customClickUrl;
  final String? fkBannerTypeId;
  final BannerMovieDetailsModel? movieDetails;

  const BannerModel({
    this.bannerId,
    this.bannerImage,
    this.bannerMobileImage,
    this.customBannerUrl,
    this.customClickUrl,
    this.fkBannerTypeId,
    this.movieDetails
  });

  BannerModel copyWith({
    String? bannerId,
    String? bannerImage,
    String? bannerMobileImage,
    String? customBannerUrl,
    String? customClickUrl,
    String? fkBannerTypeId,
    BannerMovieDetailsModel? movieDetails
  }) {
    return BannerModel(
      bannerId: bannerId ?? this.bannerId,
      bannerImage: bannerImage ?? this.bannerImage,
      bannerMobileImage: bannerMobileImage ?? this.bannerMobileImage,
      customBannerUrl: customBannerUrl ?? this.customBannerUrl,
      customClickUrl: customClickUrl ?? this.customClickUrl,
      fkBannerTypeId: fkBannerTypeId ?? this.fkBannerTypeId,
        movieDetails : movieDetails ?? this.movieDetails
    );
  }

  @override
  List<Object?> get props => [
    bannerId,
    bannerImage,
    bannerMobileImage,
    customBannerUrl,
    customClickUrl,
    movieDetails,
    fkBannerTypeId,
  ];

  @override
  String toString() {
    return 'BannerModel(bannerId: $bannerId, bannerImage: $bannerImage, bannerMobileImage: $bannerMobileImage, customBannerUrl: $customBannerUrl, customClickUrl: $customClickUrl, fkBannerTypeId: $fkBannerTypeId, movieDetails: $movieDetails)';
  }
}