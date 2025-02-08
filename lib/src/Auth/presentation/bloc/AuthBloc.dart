import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/core/resources/UseCase.dart';
import 'package:novocinema/core/utils/DateFormater.dart';
import 'package:novocinema/core/utils/Logger.dart';
import 'package:novocinema/src/Auth/domain/models/UserAuthModel.dart';
import 'package:novocinema/src/Auth/domain/useCases/CreateAccountUseCase.dart';
import 'package:novocinema/src/Auth/domain/useCases/FacebookSigneUpUseCase.dart';
import 'package:novocinema/src/Auth/domain/useCases/GetUserDetailsUseCase.dart';
import 'package:novocinema/src/Auth/domain/useCases/GoogleLogInUseCase.dart';
import 'package:novocinema/src/Auth/domain/useCases/LoginUseCase.dart';
import 'package:novocinema/src/Auth/domain/useCases/ResetPasswordUseCase.dart';
import 'package:novocinema/src/Auth/presentation/screens/OtpVerificationScreen.dart';
import '../../../../components/dropdown/coustom_icon_dropdown.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../../domain/useCases/AppleSigneIn.dart';
import '../../domain/useCases/AuthenticateUserUseCase.dart';
import '../../domain/useCases/EmailVerificationUseCase.dart';
import '../../domain/useCases/FacebookLogInUseCase.dart';
import '../../domain/useCases/ForgotPasswordUseCase.dart';
import '../../domain/useCases/GetAllNationalityUseCase.dart';
import '../../domain/useCases/GoogleSigneUpUseCase.dart';
import '../../domain/useCases/LogOutUseCase.dart';
import '../../domain/useCases/LoginAsGuestUseCase.dart';
import '../../domain/useCases/VerifyOtpUseCase.dart';

part 'AuthEvent.dart';
part 'AuthState.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase login;
  final CreateAccountUseCase createAccount;
  final GetUserDetailsUseCase getUserDetails;
  final AppleSigneIn appleSigneIn ;
  final AuthenticateUserUseCase authenticateUserUseCase;
  final GoogleLogInUseCase googleLogInUseCase;
  final GoogleSigneUpUseCase googleSigneUpUseCase;
  final FacebookLogInUseCase facebookLogInUseCase;
  final FacebookSigneUpUseCase facebookSigneUpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final EmailVerificationUseCase emailVerificationUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final LogOutUseCase logOutUseCase;
  final GetAllNationalityUseCase getAllNationalityUseCase ;
  final LoginAsGuestUseCase loginAsGuestUseCase;

  AuthBloc(this.login, this.createAccount , this.googleLogInUseCase , this.appleSigneIn,
      this.googleSigneUpUseCase,this.getAllNationalityUseCase,this.emailVerificationUseCase,
      this.authenticateUserUseCase, this.getUserDetails,this.loginAsGuestUseCase ,
      this.facebookSigneUpUseCase, this.facebookLogInUseCase,
      this.verifyOtpUseCase,this.forgotPasswordUseCase,this.resetPasswordUseCase,
      this.logOutUseCase) : super(AuthState()) {

    on<LoginEvent>(_loginEvent);
    on<LogOutEvent>(_logOutEvent);

    on<OnEmailChanged>(_onEmailChanged);
    on<OnPasswordChanged>(_onPasswordChanged);

    on<OnFirstNameChanged>(_onFirstNameChanged);
    on<OnLastNameChanged>(_onLastNameChanged);
    on<OnPhoneNumberChanged>(_onPhoneNumberChanged);
    on<OnGenderChanged>(_onGenderChanged);
    on<OnNationalityChanged>(_onNationalityChanged);
    on<OnDateChanged>(_onDateChanged);




    on<SigneUpEvent>(_signeUpEvent);
    on<EmailVerificationEvent>(_emailVerificationEvent);


    on<GoogleSigneUpEvent>(_googleSigneUpEvent);
    on<GoogleLogInEvent>(_googleLogInEvent);

    on<FacebookSigneUpEvent>(_facebookSigneUpEvent);
    on<FacebookLogInEvent>(_facebookLogInEvent);

    on<AppleSigneUpEvent>(_appleSigneUpEvent);
    on<AuthenticateUserEvent>(_authenticateUserEvent);

    on<LoginAsGuestEvent>(_loginAsGuestEvent);

    on<ForgotPasswordEvent>(_forgotPasswordEvent);
    on<VerifyOtpEvent>(_verifyOtpEvent);
    on<ResetPasswordEvent>(_resetPasswordEvent);

    on<GetUserDetailsEvent>(_getUserDetailsEvent);
    on<GetAllNationalityEvent>(_getAllNationalityEvent);
    on<OnPhoneNumberCountryChanged>(_onPhoneNumberCountryChanged);




  }

  FutureOr<void> _loginAsGuestEvent(LoginAsGuestEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(guestLoginState: CurrentAppState.LOADING));

    final loginAsGuestData = await loginAsGuestUseCase.call(<String,dynamic>{
    "country_id": 1,
    "guest_contact": '${state.phoneNumberCode?.title}${state.phoneNumber}',
    "guest_email": state.email,
    "guest_first_name": state.firstName,
    "guest_last_name": state.lastName,
    });

    switch (loginAsGuestData) {
      case Success<bool>():
        emit(state.copyWith(guestLoginState: CurrentAppState.SUCCESS));
        event.onSuccess();
      case Error<bool>():
      emit(state.copyWith(guestLoginState: CurrentAppState.ERROR, appException: loginAsGuestData.exception));
      event.onFailure(loginAsGuestData.exception);
    }
  }


  FutureOr<void> _facebookLogInEvent(FacebookLogInEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(faceBookLoginState: CurrentAppState.LOADING));
    final facebookLoginData = await facebookLogInUseCase.call(EmptyParams());
    switch(facebookLoginData) {
      case Success<Map<String, dynamic>>():

        if(facebookLoginData.data['new_user'] == true){
          emit(state.copyWith(faceBookLoginState: CurrentAppState.SUCCESS));
          event.onSuccess(facebookLoginData.data['new_user'],facebookLoginData.data['token']);
        }else {

          final userData = await getUserDetails.call(EmptyParams());
          switch (userData) {
            case Success<UserAuthModel>():
              emit(state.copyWith(getUserDetailsState: CurrentAppState.SUCCESS,faceBookLoginState: CurrentAppState.SUCCESS, user: userData.data ));
              event.onSuccess(facebookLoginData.data['new_user'],facebookLoginData.data['token']);
              Logger.customLogData("User", state.user);
            case Error<UserAuthModel>():
              emit(state.copyWith(getUserDetailsState: CurrentAppState.ERROR,faceBookLoginState: CurrentAppState.ERROR, appException:userData.exception));
              event.onFailure(userData.exception);
          }
        }
      case Error<Map<String, dynamic>>():
        emit(state.copyWith(faceBookLoginState: CurrentAppState.ERROR,appException: facebookLoginData.exception ));
        event.onFailure(facebookLoginData.exception);
    }
  }

  FutureOr<void> _facebookSigneUpEvent(FacebookSigneUpEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(faceBookLoginState: CurrentAppState.LOADING));
    final data = state.dateOfBirth?.toIso8601String();


    final facebookSigneUpData = await facebookSigneUpUseCase.call(<String,dynamic>{
      "user_contact": '${state.phoneNumberCode?.title}${state.phoneNumber}',
      "gender": state.gender,
      "user_birth_day":'${getYear(data!)}-${getMonth(data!)}-${getDay(data!)}',
      "verify_token": event.token
    });
    switch(facebookSigneUpData) {
      case Success<Map<String, dynamic>>():

        final userData = await getUserDetails.call(EmptyParams());
        switch (userData) {
          case Success<UserAuthModel>():
            emit(state.copyWith(getUserDetailsState: CurrentAppState.SUCCESS,faceBookLoginState: CurrentAppState.SUCCESS, user: userData.data ));
            event.onSuccess();
            Logger.customLogData("User", state.user);
          case Error<UserAuthModel>():
            emit(state.copyWith(getUserDetailsState: CurrentAppState.ERROR,faceBookLoginState: CurrentAppState.ERROR, appException:userData.exception));
            event.onFailure(userData.exception);
        }

      case Error<Map<String, dynamic>>():
        emit(state.copyWith(faceBookLoginState: CurrentAppState.ERROR,appException: facebookSigneUpData.exception));
        event.onFailure(facebookSigneUpData.exception);
    }
  }


  FutureOr<void> _googleLogInEvent(GoogleLogInEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(googleLoginState: CurrentAppState.LOADING));
    final googleLoginData = await googleLogInUseCase.call(EmptyParams());
    switch(googleLoginData) {
      case Success<Map<String, dynamic>>():

        if(googleLoginData.data['new_user'] == true){
          emit(state.copyWith(googleLoginState: CurrentAppState.SUCCESS));
          event.onSuccess(googleLoginData.data['new_user'],googleLoginData.data['token']);
        }else {

          final userData = await getUserDetails.call(EmptyParams());
          switch (userData) {
            case Success<UserAuthModel>():
              emit(state.copyWith(getUserDetailsState: CurrentAppState.SUCCESS,googleLoginState: CurrentAppState.SUCCESS, user: userData.data ));
              event.onSuccess(googleLoginData.data['new_user'],googleLoginData.data['token']);
              Logger.customLogData("User", state.user);
            case Error<UserAuthModel>():
              emit(state.copyWith(getUserDetailsState: CurrentAppState.ERROR,googleLoginState: CurrentAppState.ERROR, appException:userData.exception));
              event.onFailure(userData.exception);
          }

        }


      case Error<Map<String, dynamic>>():
        emit(state.copyWith(googleLoginState: CurrentAppState.ERROR,appException: googleLoginData.exception ));
        event.onFailure(googleLoginData.exception);
    }
  }

  FutureOr<void> _googleSigneUpEvent(GoogleSigneUpEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(googleLoginState: CurrentAppState.LOADING));
    final data = state.dateOfBirth?.toIso8601String();


    final googleSigneUpData = await googleSigneUpUseCase.call(<String,dynamic>{
      "user_contact": '${state.phoneNumberCode?.title}${state.phoneNumber}',
      "gender": state.gender,
      "user_birth_day":'${getYear(data!)}-${getMonth(data!)}-${getDay(data!)}',
      "verify_token": event.token
    });
    switch(googleSigneUpData) {
      case Success<Map<String, dynamic>>():

        final userData = await getUserDetails.call(EmptyParams());
        switch (userData) {
          case Success<UserAuthModel>():
            emit(state.copyWith(getUserDetailsState: CurrentAppState.SUCCESS,googleLoginState: CurrentAppState.SUCCESS, user: userData.data ));
            event.onSuccess();
            Logger.customLogData("User", state.user);
          case Error<UserAuthModel>():
            emit(state.copyWith(getUserDetailsState: CurrentAppState.ERROR,googleLoginState: CurrentAppState.ERROR, appException:userData.exception));
            event.onFailure(userData.exception);
        }

      case Error<Map<String, dynamic>>():
      emit(state.copyWith(googleLoginState: CurrentAppState.ERROR,appException: googleSigneUpData.exception));
      event.onFailure(googleSigneUpData.exception);
    }
  }

  FutureOr<void> _resetPasswordEvent(ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(changePasswordState: CurrentAppState.LOADING));
    final changePasswordData = await resetPasswordUseCase.call(event.data);
    switch (changePasswordData) {
      case Success<bool>():
        emit(state.copyWith(changePasswordState: CurrentAppState.SUCCESS));
        event.onSuccess();
      case Error<bool>():
        emit(state.copyWith(changePasswordState: CurrentAppState.ERROR, appException: changePasswordData.exception));
        event.onFailure(changePasswordData.exception);
    }
  }

  FutureOr<void> _verifyOtpEvent(VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(verifyOtpState: CurrentAppState.LOADING));
    final verifyOtpData = await verifyOtpUseCase.call(VerifyOtpParams(event.data,event.otpVerificationType));
    switch (verifyOtpData) {
      case Success<String>():
        emit(state.copyWith(verifyOtpState: CurrentAppState.SUCCESS));
        event.onSuccess(verifyOtpData.data);
      case Error<String>():
      emit(state.copyWith(verifyOtpState: CurrentAppState.ERROR, appException: verifyOtpData.exception));
      event.onFailure(verifyOtpData.exception);
    }
  }

  FutureOr<void> _forgotPasswordEvent(ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(forgotPasswordState: CurrentAppState.LOADING));
    final forgotPasswordData = await forgotPasswordUseCase.call(event.email);
    switch (forgotPasswordData) {
      case Success<bool>():
        emit(state.copyWith(forgotPasswordState: CurrentAppState.SUCCESS));
        event.onSuccess();
      case Error<bool>():
        emit(state.copyWith(forgotPasswordState: CurrentAppState.ERROR, appException: forgotPasswordData.exception));
        event.onFailure(forgotPasswordData.exception);
    }
  }







  FutureOr<void> _logOutEvent(LogOutEvent event, Emitter<AuthState> emit) async {
    final userData = await logOutUseCase.call(EmptyParams());
    switch (userData) {
      case Success<bool>():
        event.onSuccess();
      case Error<bool>():
         event.onFailure(userData.exception);
    }
  }

  FutureOr<void> _authenticateUserEvent(AuthenticateUserEvent event, Emitter<AuthState> emit) async {
    final userData = await authenticateUserUseCase.call(EmptyParams());
    switch (userData) {
      case Success<String?>():
        event.onSuccess();
      case Error<String?>():
        event.onFailure();
    }
  }

  FutureOr<void> _loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(loginState: CurrentAppState.LOADING));
    final loginData = await login.call(LoginParams(state.password, state.email));
    switch (loginData) {
      case Success<bool>():
        final userData = await getUserDetails.call(EmptyParams());
        switch (userData) {
          case Success<UserAuthModel>():
            emit(state.copyWith(getUserDetailsState: CurrentAppState.SUCCESS,loginState: CurrentAppState.SUCCESS, user: userData.data ));
            event.onSuccess();
            Logger.customLogData("User", state.user);
          case Error<UserAuthModel>():
            emit(state.copyWith(getUserDetailsState: CurrentAppState.ERROR,loginState: CurrentAppState.ERROR, appException:userData.exception));
            event.onFailure(userData.exception);
        }
      case Error<bool>():
        emit(state.copyWith(loginState: CurrentAppState.ERROR, appException: loginData.exception));
        event.onFailure(loginData.exception);
    }
  }

  FutureOr<void> _getUserDetailsEvent(GetUserDetailsEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(getUserDetailsState: CurrentAppState.LOADING));
    final userData = await getUserDetails.call(EmptyParams());
    switch (userData) {
      case Success<UserAuthModel>():
        emit(state.copyWith(getUserDetailsState: CurrentAppState.SUCCESS, user: userData.data ));
        event.onSuccess();
      case Error<UserAuthModel>():
      emit(state.copyWith(getUserDetailsState: CurrentAppState.ERROR, appException:userData.exception));
      event.onFailure(userData.exception);
    }
    Logger.customLogData("User", state.user);
  }

  FutureOr<void> _onEmailChanged(
      OnEmailChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _onPasswordChanged(
      OnPasswordChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> _onFirstNameChanged(
      OnFirstNameChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(firstName: event.firstName));
  }

  FutureOr<void> _onLastNameChanged(
      OnLastNameChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(lastName: event.lastName));
  }

  FutureOr<void> _onPhoneNumberChanged(
      OnPhoneNumberChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  FutureOr<void> _onGenderChanged(
      OnGenderChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(gender: event.gender));
  }

  FutureOr<void> _onNationalityChanged( OnNationalityChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(selectedNationality: event.nationality));
    Logger.customLogData('Nationality', state.selectedNationality);
  }

  FutureOr<void> _onPhoneNumberCountryChanged( OnPhoneNumberCountryChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(phoneNumberCode: event.phoneNumberCountry));
    Logger.customLogData('Phone Number Code', state.phoneNumberCode);
  }


  FutureOr<void> _onDateChanged(OnDateChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(dateOfBirth: event.date));
    Logger.customLogData('Date', state.dateOfBirth);
  }

  FutureOr<void> _signeUpEvent(SigneUpEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(createAccountState: CurrentAppState.LOADING));

    final data = state.dateOfBirth?.toIso8601String();


    final signeUpData = await createAccount.call(<String,dynamic>{
      "user_email": state.email,
      "user_password": state.password,
      "first_name": state.firstName,
      "last_name": state.lastName,
      "user_contact": '${state.phoneNumberCode?.title}${state.phoneNumber}',
      "user_name": state.firstName,
      "gender": state.gender,
      "user_birth_day":'${getYear(data!)}-${getMonth(data!)}-${getDay(data!)}',
      "nationality":state.selectedNationality?.title
    });

    switch (signeUpData) {
      case Success<bool>():
        final emailVerificationData = await emailVerificationUseCase.call(state.email);

        switch (emailVerificationData) {
          case Success<bool>():
            emit(state.copyWith(createAccountState: CurrentAppState.SUCCESS));
            event.onSuccess();
          case Error<bool>():
            emit(state.copyWith(createAccountState: CurrentAppState.ERROR, appException: emailVerificationData.exception));
            event.onFailure(emailVerificationData.exception);
        }
      case Error<bool>():
        emit(state.copyWith(createAccountState: CurrentAppState.ERROR, appException: signeUpData.exception));
        event.onFailure(signeUpData.exception);
    }
  }

  FutureOr<void> _emailVerificationEvent(EmailVerificationEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(emailVerificationState: CurrentAppState.LOADING));
    final emailVerificationData = await emailVerificationUseCase.call(event.email);
    switch (emailVerificationData) {
      case Success<bool>():
        emit(state.copyWith(emailVerificationState: CurrentAppState.SUCCESS));
        event.onSuccess();
      case Error<bool>():
        emit(state.copyWith(emailVerificationState: CurrentAppState.ERROR, appException: emailVerificationData.exception));
        event.onFailure(emailVerificationData.exception);
    }
  }


  FutureOr<void> _appleSigneUpEvent(AppleSigneUpEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(appleLoginState: CurrentAppState.LOADING));
    final data = await appleSigneIn.call(EmptyParams());
    switch(data) {
      case Success<bool>():
        emit(state.copyWith(appleLoginState: CurrentAppState.SUCCESS));
      case Error<bool>():
        emit(state.copyWith(appleLoginState: CurrentAppState.ERROR, appException: data.exception));
    }
  }


  FutureOr<void> _getAllNationalityEvent(GetAllNationalityEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(nationalityState: CurrentAppState.LOADING));
    final nationalityData = await getAllNationalityUseCase.call(EmptyParams());
    switch(nationalityData) {
      case Success<List<Map<String,dynamic>>>():
        emit(state.copyWith(nationalityState: CurrentAppState.SUCCESS, nationalityList: nationalityData.data));
      case Error<List<Map<String,dynamic>>>():
        emit(state.copyWith(nationalityState: CurrentAppState.ERROR,appException: nationalityData.exception ));
    }
  }











}


