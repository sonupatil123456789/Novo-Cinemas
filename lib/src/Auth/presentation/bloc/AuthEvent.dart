part of 'AuthBloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class OnFirstNameChanged extends AuthEvent {
  final String firstName;
  const OnFirstNameChanged(this.firstName);

  @override
  List<Object> get props => [firstName];
}

class OnNationalityChanged extends AuthEvent {
  final DropDownItemData<Map<String,dynamic>> nationality;
  const OnNationalityChanged(this.nationality);

  @override
  List<Object> get props => [nationality];
}

class OnLastNameChanged extends AuthEvent {
  final String lastName;
  const OnLastNameChanged(this.lastName);

  @override
  List<Object> get props => [lastName];
}


class OnPhoneNumberChanged extends AuthEvent {
  final String phoneNumber;
  const OnPhoneNumberChanged(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class OnReferralCodeChanged extends AuthEvent {
  final String referralCode;
  const OnReferralCodeChanged(this.referralCode);

  @override
  List<Object> get props => [referralCode];
}

class OnDateChanged extends AuthEvent {
  final DateTime date;
  const OnDateChanged(this.date);

  @override
  List<Object> get props => [date];
}



class OnPhoneNumberCountryChanged extends AuthEvent {
  final DropDownItemData<Map<String,dynamic>> phoneNumberCountry;
  const OnPhoneNumberCountryChanged(this.phoneNumberCountry);

  @override
  List<Object> get props => [phoneNumberCountry];
}




class OnGenderChanged extends AuthEvent {
  final String gender;
  const OnGenderChanged(this.gender);

  @override
  List<Object> get props => [gender];
}


class OnEmailChanged extends AuthEvent {
  final String email;
  const OnEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class OnPasswordChanged extends AuthEvent {
  final String password;
  const OnPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}



class LoginEvent extends AuthEvent {
  final Function onSuccess;
  final Function(AppException) onFailure;
  const LoginEvent({required this.onFailure,required this.onSuccess});

  @override
  List<Object> get props => [];
}


class LogOutEvent extends AuthEvent {
  Function onSuccess;
  Function(AppException) onFailure;
  LogOutEvent({required this.onSuccess, required this.onFailure});

  @override
  List<Object> get props => [];
}

class GetUserDetailsEvent extends AuthEvent {
  final Function onSuccess;
  final Function(AppException) onFailure;
  const GetUserDetailsEvent({required this.onFailure,required this.onSuccess});

  @override
  List<Object> get props => [onSuccess,onFailure];
}


class SigneUpEvent extends AuthEvent {
  final Function onSuccess;
  final Function(AppException) onFailure;
  const SigneUpEvent({required this.onFailure,required this.onSuccess});

  @override
  List<Object> get props => [onSuccess,onFailure];
}

class LoginAsGuestEvent extends AuthEvent {
  final Function onSuccess;
  final Function(AppException) onFailure;
  const LoginAsGuestEvent({required this.onFailure,required this.onSuccess});

  @override
  List<Object> get props => [onSuccess,onFailure];
}

class GoogleLogInEvent extends AuthEvent {
  final Function(bool, String) onSuccess;
  final Function(AppException) onFailure;
  const GoogleLogInEvent({required this.onFailure,required this.onSuccess});

  @override
  List<Object> get props => [onSuccess,onFailure];
}

class GoogleSigneUpEvent extends AuthEvent {
  final String token ;
  final Function() onSuccess;
  final Function(AppException) onFailure;
  const GoogleSigneUpEvent({required this.onFailure,required this.onSuccess, required this.token});

  @override
  List<Object> get props => [onSuccess,onFailure,token];
}

class AppleSigneUpEvent extends AuthEvent {
  const AppleSigneUpEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;
  final Function() onSuccess;
  final Function(AppException) onFailure;
  const ForgotPasswordEvent({required this.email, required this.onFailure,required this.onSuccess});

  @override
  List<Object> get props => [email, onSuccess,onFailure];
}

class EmailVerificationEvent extends AuthEvent {
  final String email;
  final Function() onSuccess;
  final Function(AppException) onFailure;
  const EmailVerificationEvent({required this.email, required this.onFailure,required this.onSuccess});

  @override
  List<Object> get props => [email, onSuccess,onFailure];
}


class VerifyOtpEvent extends AuthEvent {
  final Map<String,dynamic> data ;
  final OtpVerificationType otpVerificationType ;
  final Function(String) onSuccess;
  final Function(AppException) onFailure;
  const VerifyOtpEvent({required this.data, required this.onFailure,required this.onSuccess, required this.otpVerificationType});

  @override
  List<Object> get props => [data,onFailure,onSuccess,otpVerificationType];
}

class ResetPasswordEvent extends AuthEvent {
  final Map<String,dynamic> data ;
  final Function onSuccess;
  final Function(AppException) onFailure;
  const ResetPasswordEvent({required this.data, required this.onFailure,required this.onSuccess});

  @override
  List<Object> get props => [data,onFailure,onSuccess];
}


class AuthenticateUserEvent extends AuthEvent {
   Function onSuccess;
   Function onFailure;
  AuthenticateUserEvent({required this.onSuccess, required this.onFailure});

  @override
  List<Object> get props => [onSuccess,onFailure];
}

class GetAllNationalityEvent extends AuthEvent {
  const GetAllNationalityEvent();

  @override
  List<Object> get props => [];
}

class FacebookLogInEvent extends AuthEvent {
  final Function(bool, String) onSuccess;
  final Function(AppException) onFailure;
  const FacebookLogInEvent({required this.onFailure,required this.onSuccess});

  @override
  List<Object> get props => [onSuccess,onFailure];
}

class FacebookSigneUpEvent extends AuthEvent {
  final String token ;
  final Function() onSuccess;
  final Function(AppException) onFailure;
  const FacebookSigneUpEvent({required this.onFailure,required this.onSuccess, required this.token});

  @override
  List<Object> get props => [onSuccess,onFailure,token];
}


class ClearAuthStateEvent extends AuthEvent {

  const ClearAuthStateEvent();

  @override
  List<Object> get props => [];
}

