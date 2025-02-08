part of 'AuthBloc.dart';

class AuthState extends Equatable {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final DropDownItemData<Map<String,dynamic>>? phoneNumberCode;
  final String email;
  final String gender;
  final DateTime? dateOfBirth;
  final String password;
  final UserAuthModel? user;
  final CurrentAppState loginState;
  final CurrentAppState createAccountState;
  final CurrentAppState getUserDetailsState;
  final CurrentAppState googleLoginState;
  final CurrentAppState appleLoginState;
  final CurrentAppState faceBookLoginState;
  final CurrentAppState guestLoginState;
  final   CurrentAppState? emailVerificationState;

  final List<Map<String,dynamic>> nationalityList;
  DropDownItemData<Map<String,dynamic>>? selectedNationality;
  final CurrentAppState nationalityState;

  final CurrentAppState forgotPasswordState;
  final CurrentAppState verifyOtpState;
  final CurrentAppState changePasswordState;

  final AppException? appException;

  AuthState(
      {this.firstName = '',
      this.lastName = '',
      this.phoneNumber = '',
      this.phoneNumberCode,
      this.email = '',
      this.password = '',
      this.selectedNationality,
      this.gender = 'Male',
      this.dateOfBirth,
      this.user,
        this.emailVerificationState = CurrentAppState.INITIAL,
      this.appleLoginState = CurrentAppState.INITIAL,
      this.getUserDetailsState = CurrentAppState.INITIAL,
      this.faceBookLoginState = CurrentAppState.INITIAL,
      this.loginState = CurrentAppState.INITIAL,
      this.createAccountState = CurrentAppState.INITIAL,
      this.googleLoginState = CurrentAppState.INITIAL,
      this.forgotPasswordState = CurrentAppState.INITIAL,
      this.verifyOtpState = CurrentAppState.INITIAL,
      this.changePasswordState = CurrentAppState.INITIAL,
      this.nationalityState = CurrentAppState.INITIAL,
        this.guestLoginState = CurrentAppState.INITIAL,
      this.nationalityList = const [],
      this.appException});

  AuthState copyWith(
      {String? firstName,
      String? lastName,
      String? phoneNumber,
        DropDownItemData<Map<String,dynamic>>? phoneNumberCode,
      String? email,
      String? password,
      String? gender,
      DateTime? dateOfBirth,
      CurrentAppState? loginState,
      CurrentAppState? createAccountState,
        CurrentAppState? emailVerificationState,
      CurrentAppState? getUserDetailsState,
      CurrentAppState? googleLoginState,
      CurrentAppState? appleLoginState,
      CurrentAppState? faceBookLoginState,
      CurrentAppState? forgotPasswordState,
      CurrentAppState? verifyOtpState,
      CurrentAppState? changePasswordState,
      List<Map<String,dynamic>>? nationalityList,
      CurrentAppState? nationalityState,
      DropDownItemData<Map<String,dynamic>>? selectedNationality,
      UserAuthModel? user,
       CurrentAppState?  guestLoginState,
      AppException? appException}) {
    return AuthState(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        user: user ?? this.user,
        password: password ?? this.password,
        gender: gender ?? this.gender,
        loginState: loginState ?? this.loginState,
        createAccountState: createAccountState ?? this.createAccountState,
        appException: appException ?? this.appException,
        googleLoginState: googleLoginState ?? this.googleLoginState,
        emailVerificationState: emailVerificationState ?? this.emailVerificationState,
        appleLoginState: appleLoginState ?? this.appleLoginState,
        changePasswordState: changePasswordState ?? this.changePasswordState,
        verifyOtpState: verifyOtpState ?? this.verifyOtpState,
        faceBookLoginState: faceBookLoginState ?? this.faceBookLoginState,
        forgotPasswordState: forgotPasswordState ?? this.forgotPasswordState,
        nationalityList: nationalityList ?? this.nationalityList,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        phoneNumberCode: phoneNumberCode ?? this.phoneNumberCode,
        nationalityState: nationalityState ?? this.nationalityState,
        selectedNationality: selectedNationality ?? this.selectedNationality,
        guestLoginState:  guestLoginState?? this.guestLoginState,
        getUserDetailsState: getUserDetailsState ?? this.getUserDetailsState);
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        phoneNumber,
        phoneNumberCode,
        password,
        loginState,
        createAccountState,
        appException,
        googleLoginState,
        faceBookLoginState,
        appleLoginState,
        guestLoginState,
        user,
        gender,
        getUserDetailsState,
        changePasswordState,
        verifyOtpState,
        nationalityList,
        selectedNationality,
        nationalityState,
        dateOfBirth,
        forgotPasswordState,
        emailVerificationState
      ];
}
