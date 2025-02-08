
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:novocinema/src/Auth/domain/useCases/CreateAccountUseCase.dart';
import 'package:novocinema/src/Auth/domain/useCases/EmailVerificationUseCase.dart';
import 'package:novocinema/src/Auth/domain/useCases/GetAllNationalityUseCase.dart';
import 'package:novocinema/src/Auth/domain/useCases/GetUserDetailsUseCase.dart';
import 'package:novocinema/src/Auth/domain/useCases/LogOutUseCase.dart';
import 'package:novocinema/src/Auth/domain/useCases/LoginUseCase.dart';
import 'package:novocinema/src/Auth/domain/useCases/ResetPasswordUseCase.dart';
import 'package:novocinema/src/Auth/domain/useCases/VerifyOtpUseCase.dart';
import '../../../di.dart';
import '../data/local/LocalDatasource.dart';
import '../data/remote/RemoteDatasource.dart';
import '../data/remote/RemoteDatasourceImpl.dart';
import '../data/repositoryImpl/RepositoryImpl.dart';
import '../domain/Repository/Repository.dart';
import '../domain/useCases/AppleSigneIn.dart';
import '../domain/useCases/AuthenticateUserUseCase.dart';
import '../domain/useCases/FacebookLogInUseCase.dart';
import '../domain/useCases/FacebookSigneUpUseCase.dart';
import '../domain/useCases/GoogleLogInUseCase.dart';
import '../domain/useCases/ForgotPasswordUseCase.dart';
import '../domain/useCases/GoogleSigneUpUseCase.dart';
import '../domain/useCases/LoginAsGuestUseCase.dart';
import '../presentation/bloc/AuthBloc.dart';

Future<void> injectAuth() async {
  // BLoC
  getIt.registerFactory(() => AuthBloc(getIt(),getIt(), getIt(),getIt() ,getIt(),getIt(),getIt(), getIt(), getIt() , getIt() , getIt(),getIt(),getIt(),getIt(), getIt(),getIt()));

  // Use cases
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => LoginAsGuestUseCase(getIt()));
  getIt.registerLazySingleton(() => CreateAccountUseCase(getIt()));
  getIt.registerLazySingleton(() => AppleSigneIn(getIt()));
  getIt.registerLazySingleton(() => GoogleLogInUseCase(getIt()));
  getIt.registerLazySingleton(() => GoogleSigneUpUseCase(getIt()));
  getIt.registerLazySingleton(() => FacebookLogInUseCase(getIt()));
  getIt.registerLazySingleton(() => FacebookSigneUpUseCase(getIt()));
  getIt.registerLazySingleton(() => AuthenticateUserUseCase(getIt()));
  getIt.registerLazySingleton(() => GetUserDetailsUseCase(getIt()));
  getIt.registerLazySingleton(() => ForgotPasswordUseCase(getIt()));
  getIt.registerLazySingleton(() => EmailVerificationUseCase(getIt()));
  getIt.registerLazySingleton(() => ResetPasswordUseCase(getIt()));
  getIt.registerLazySingleton(() => VerifyOtpUseCase(getIt()));
  getIt.registerLazySingleton(() => LogOutUseCase(getIt()));
  getIt.registerLazySingleton(() => GetAllNationalityUseCase(getIt()));

  // Repository
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt<AuthRemoteDatasource>(), getIt<AuthLocalDatasource>(),getIt()));

  // Data sources
  getIt.registerLazySingleton<AuthRemoteDatasource>(
        () => AuthRemoteDatasourceImpl(getIt(),getIt<FirebaseAuth>() , getIt<GoogleSignIn>(), getIt()),
  );


  getIt.registerLazySingleton(() => AuthLocalDatasource(getIt()));

}