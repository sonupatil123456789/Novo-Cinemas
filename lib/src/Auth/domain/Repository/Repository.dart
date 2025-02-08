import '../../../../core/resources/DataResult.dart';
import '../../presentation/screens/OtpVerificationScreen.dart';
import '../models/UserAuthModel.dart';

abstract interface class AuthRepository{

  Future<DataResult<bool>> signeUp(Map<String,dynamic> customer);

  Future<DataResult<bool>>  logIn(String email , String password);

  Future<DataResult<bool>>  logOut();

  Future<DataResult<UserAuthModel>> getUserDetails();

  Future<DataResult<String?>> authenticateUser();

  Future<DataResult<Map<String,dynamic>>>  googleLogIn();

  Future<DataResult<Map<String,dynamic>>> googleSigneUp(Map<String,dynamic> data);

  Future<DataResult<bool>>  logInWithApple();


  Future<DataResult<bool>> forgotPassword(String emailId);

  Future<DataResult<bool>> emailVerification(String emailId);

  Future<DataResult<String>> verifyOtp(Map<String,dynamic> data, OtpVerificationType otpVerificationType);

  Future<DataResult<bool>> resetPassword(Map<String,dynamic> data);

  Future<DataResult<List<Map<String,dynamic>>>> getAllNationality();


  Future<DataResult<Map<String,dynamic>>>  facebookLogIn();

  Future<DataResult<Map<String,dynamic>>> facebookSigneUp(Map<String,dynamic> data);

  Future<DataResult<bool>> loginAsGuest(Map<String,dynamic> data);

}