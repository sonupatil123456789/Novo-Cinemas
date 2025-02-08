part of 'ApplicationBloc.dart';

class ApplicationState extends Equatable {

  Locale? locale ;
  bool ? isUserLogIn;
  UserAuthModel ? userDetails;
  AppException ? error;


   ApplicationState({
        this.locale = const Locale('en', ''),
        this.isUserLogIn = false ,
     this.error ,
         this.userDetails = const UserAuthModel()
  });

  ApplicationState copyWith({
    Locale? locale,
    bool ? isUserLogIn ,
    UserAuthModel ? userDetails,
    AppException ? error
   }) {
    return ApplicationState(
      locale: locale ?? this.locale,
      isUserLogIn: isUserLogIn ?? this.isUserLogIn,
        userDetails : userDetails ?? this.userDetails,
        error: error ?? this.error
    );
  }

  @override
  List<Object?> get props => [
    locale,
    isUserLogIn,
    userDetails
  ];
}
