import 'dart:async';
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novocinema/core/resources/AppException.dart';
import 'package:novocinema/core/resources/enums.dart';

import '../core/constants/DatabaseKeyConstants.dart';
import '../core/resources/SeassionManager.dart';
import '../di.dart';
import '../src/Auth/data/dto/UserAuthDto.dart';
import '../src/Auth/data/local/LocalDatasource.dart';
import '../src/Auth/domain/models/UserAuthModel.dart';

part 'ApplicationEvent.dart';
part 'ApplicationState.dart';


const List<Locale> supportedLanguages = [
Locale('en', ''),
Locale('ar', ''),
];


class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  late final SeassionManager session ;

  ApplicationBloc() : super(ApplicationState(userDetails : const UserAuthModel())) {
    session = SeassionManager();



    on<SetLocalEvent>(_setLocalEvent);
    on<IsUserLogInEvent>(_isUserLogInEvent);
    on<SetIsUserLogInEvent>(_setIsUserLogInEvent);
    on<GetLocalUserDetailsEvent>(_getLocalUserDetailsEvent);

  }




  FutureOr<void> _setLocalEvent(SetLocalEvent event, Emitter<ApplicationState> emit) {
    emit(state.copyWith(locale: event.locale));
  }



  Future _isUserLogInEvent(IsUserLogInEvent event, Emitter<ApplicationState> emit) async  {
    final tokenData = await  session.getAccessToken(TOKEN);

    if(tokenData != null && tokenData.isNotEmpty){
      emit(state.copyWith(isUserLogIn: true));
    }else {
      emit(state.copyWith(isUserLogIn: false));
    }
  }

  Future _setIsUserLogInEvent(SetIsUserLogInEvent event, Emitter<ApplicationState> emit) async  {
    emit(state.copyWith(isUserLogIn: event.isLogIn));
  }


  Future _getLocalUserDetailsEvent(GetLocalUserDetailsEvent event, Emitter<ApplicationState> emit) async  {
    final localDataSource = getIt<AuthLocalDatasource>();
    final userData = await localDataSource.getUserData();

    try {
      emit(state.copyWith(userDetails: UserAuthDto.toDomainModel(userData)));

    } on Exception catch (error) {
      emit(state.copyWith(error: AppException(message: error.toString(), errorCode: ErrorCode.UNKNOWN_ERROR)));
    }

  }





}


