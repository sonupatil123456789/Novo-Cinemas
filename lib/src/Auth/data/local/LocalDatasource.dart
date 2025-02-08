
import 'package:novocinema/core/constants/DatabaseKeyConstants.dart';
import 'package:novocinema/core/resources/ExceptionHandler.dart';
import 'package:novocinema/core/resources/SeassionManager.dart';
import 'package:novocinema/src/Auth/data/dto/UserAuthDto.dart';

class AuthLocalDatasource {
  late final SeassionManager localStorage ;
  AuthLocalDatasource(this.localStorage);

  Future<bool> setUserData(UserAuthDto user )async{
    try{
      return await localStorage.saveObjectToSharedPreferences(USER, user.toJson());
    } on Exception catch(error, stackTrace){
      throw ExceptionHandler.handleDatabaseException(error, stackTrace);
    }
  }

  Future<bool> removeUserData()async{
    try{
      return await localStorage.removeObjectFromSharedPreferences(USER);
    } on Exception catch(error, stackTrace){
      throw ExceptionHandler.handleDatabaseException(error, stackTrace);
    }
  }

  Future<UserAuthDto> getUserData()async{
    try{
      final Map<String, dynamic>? user = await localStorage.getObjectFromSharedPreferences(USER);
      if(user!= null){
       return  UserAuthDto.fromJson(user);
      } else{
        return const UserAuthDto();
      }

    } on Exception catch(error, stackTrace){
      throw ExceptionHandler.handleDatabaseException(error, stackTrace);
    }
  }


}
