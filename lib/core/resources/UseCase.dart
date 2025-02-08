import 'package:flutter/material.dart';

abstract interface class UseCase<SuccessDataType, Parameters>{
  Future<SuccessDataType> call(Parameters params );
}

abstract interface class StreamedUseCase<SuccessDataType, Parameters>{
  Stream<SuccessDataType> call(Parameters params );
}



class EmptyParams{}