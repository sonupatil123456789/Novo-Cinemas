import 'dart:developer';

import 'package:flutter/foundation.dart';


class Logger {

  static customLogData( String title , dynamic data ){
    if(kDebugMode){
      log("[ $title ] === >> $data" );
    }
  }

  static customLogError(String errorTitle ,  error , StackTrace stack ){
    if(kDebugMode){
      log("[ Error IN $errorTitle ] === >> error: $error  ==== stackTrace: $stack" );
    }
  }

}

// error:error, stackTrace: stack