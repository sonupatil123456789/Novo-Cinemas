import 'package:equatable/equatable.dart';

class LoyaltyInfoModel extends Equatable {
  final int? extendedResultCode;
  final bool? isWebAccountActivated;
  final dynamic member;
  final String? loyaltySessionToken;
  final int? lockOutPeriodInSeconds;
  final dynamic loyaltyMember;
  final int? result;
  final String? errorDescription;

  const LoyaltyInfoModel({
    this.extendedResultCode,
    this.isWebAccountActivated,
    this.member,
    this.loyaltySessionToken,
    this.lockOutPeriodInSeconds,
    this.loyaltyMember,
    this.result,
    this.errorDescription,
  });



  LoyaltyInfoModel copyWith({
    int? extendedResultCode,
    bool? isWebAccountActivated,
    dynamic member,
    String? loyaltySessionToken,
    int? lockOutPeriodInSeconds,
    dynamic loyaltyMember,
    int? result,
    String? errorDescription,
  }) {
    return LoyaltyInfoModel(
      extendedResultCode: extendedResultCode ?? this.extendedResultCode,
      isWebAccountActivated: isWebAccountActivated ?? this.isWebAccountActivated,
      member: member ?? this.member,
      loyaltySessionToken: loyaltySessionToken ?? this.loyaltySessionToken,
      lockOutPeriodInSeconds:
      lockOutPeriodInSeconds ?? this.lockOutPeriodInSeconds,
      loyaltyMember: loyaltyMember ?? this.loyaltyMember,
      result: result ?? this.result,
      errorDescription: errorDescription ?? this.errorDescription,
    );
  }

  @override
  String toString() {
    return 'LoyaltyInfoModel(extendedResultCode: $extendedResultCode, isWebAccountActivated: $isWebAccountActivated, member: $member, loyaltySessionToken: $loyaltySessionToken, lockOutPeriodInSeconds: $lockOutPeriodInSeconds, loyaltyMember: $loyaltyMember, result: $result, errorDescription: $errorDescription)';
  }

  @override
  List<Object?> get props => [
    extendedResultCode,
    isWebAccountActivated,
    member,
    loyaltySessionToken,
    lockOutPeriodInSeconds,
    loyaltyMember,
    result,
    errorDescription,
  ];
}
