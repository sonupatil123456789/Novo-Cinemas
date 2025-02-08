import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../../presentation/screens/OtpVerificationScreen.dart';
import '../Repository/Repository.dart';

class VerifyOtpUseCase implements UseCase<DataResult<String>, VerifyOtpParams> {
  final AuthRepository repository;
  VerifyOtpUseCase(this.repository);

  @override
  Future<DataResult<String>> call(VerifyOtpParams params) async {
    return await repository.verifyOtp(params.data, params.otpVerificationType);
  }
}

class VerifyOtpParams {
  final OtpVerificationType otpVerificationType;
  final Map<String, dynamic> data;
  VerifyOtpParams(this.data, this.otpVerificationType);
}
