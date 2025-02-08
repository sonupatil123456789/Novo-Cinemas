import 'package:equatable/equatable.dart';
import 'package:novocinema/src/Auth/domain/models/LoyaltyInfoModel.dart';

class LoyaltyInfoDto extends Equatable {
  final int? extendedResultCode;
  final bool? isWebAccountActivated;
  final dynamic member;
  final String? loyaltySessionToken;
  final int? lockOutPeriodInSeconds;
  final dynamic loyaltyMember;
  final int? result;
  final String? errorDescription;

  const LoyaltyInfoDto({
    this.extendedResultCode,
    this.isWebAccountActivated,
    this.member,
    this.loyaltySessionToken,
    this.lockOutPeriodInSeconds,
    this.loyaltyMember,
    this.result,
    this.errorDescription,
  });

  factory LoyaltyInfoDto.fromJson(Map<String, dynamic> json) => LoyaltyInfoDto(
    extendedResultCode: json['ExtendedResultCode'] as int? ?? 0,
    isWebAccountActivated: json['IsWebAccountActivated'] as bool? ?? false,
    member: json['Member'],
    loyaltySessionToken: json['LoyaltySessionToken'] as String? ?? '',
    lockOutPeriodInSeconds: json['LockOutPeriodInSeconds'] as int? ?? 0,
    loyaltyMember: json['LoyaltyMember'],
    result: json['Result'] as int? ?? 0,
    errorDescription: json['ErrorDescription'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => {
    'ExtendedResultCode': extendedResultCode,
    'IsWebAccountActivated': isWebAccountActivated,
    'Member': member,
    'LoyaltySessionToken': loyaltySessionToken,
    'LockOutPeriodInSeconds': lockOutPeriodInSeconds,
    'LoyaltyMember': loyaltyMember,
    'Result': result,
    'ErrorDescription': errorDescription,
  };

  LoyaltyInfoDto copyWith({
    int? extendedResultCode,
    bool? isWebAccountActivated,
    dynamic member,
    String? loyaltySessionToken,
    int? lockOutPeriodInSeconds,
    dynamic loyaltyMember,
    int? result,
    String? errorDescription,
  }) {
    return LoyaltyInfoDto(
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

  static LoyaltyInfoModel toDomainModel(LoyaltyInfoDto loyaltyInfoDto){
    return LoyaltyInfoModel(
        errorDescription: loyaltyInfoDto.errorDescription,
      extendedResultCode: loyaltyInfoDto.extendedResultCode,
      isWebAccountActivated: loyaltyInfoDto.isWebAccountActivated,
      lockOutPeriodInSeconds: loyaltyInfoDto.lockOutPeriodInSeconds,
      loyaltyMember: loyaltyInfoDto.loyaltyMember,
      loyaltySessionToken: loyaltyInfoDto.loyaltySessionToken,
      member: loyaltyInfoDto.member,
      result: loyaltyInfoDto.result
    );
  }

  @override
  String toString() {
    return 'LoyaltyInfoDto(extendedResultCode: $extendedResultCode, isWebAccountActivated: $isWebAccountActivated, member: $member, loyaltySessionToken: $loyaltySessionToken, lockOutPeriodInSeconds: $lockOutPeriodInSeconds, loyaltyMember: $loyaltyMember, result: $result, errorDescription: $errorDescription)';
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
