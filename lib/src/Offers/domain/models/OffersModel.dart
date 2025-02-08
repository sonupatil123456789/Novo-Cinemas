import 'package:equatable/equatable.dart';

import 'BankOfferModel.dart';

class OffersModel extends Equatable {
  final List<OfferDetailsModel>? bankOffers;
  final List<OfferDetailsModel>? normalOffers;

  const OffersModel({
    this.bankOffers = const [],
     this.normalOffers = const [],
  });



  OffersModel copyWith({
    List<OfferDetailsModel>? bankOffers,
    List<OfferDetailsModel>? normalOffers,
  }) {
    return OffersModel(
      bankOffers: bankOffers ?? this.bankOffers,
      normalOffers: normalOffers ?? this.normalOffers,
    );
  }

  @override
  List<Object?> get props => [bankOffers,normalOffers];

  @override
  String toString() {
    return 'OffersModel(bankOffers: $bankOffers , normalOffers: $normalOffers)';
  }
}