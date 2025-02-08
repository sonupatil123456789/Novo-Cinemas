import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novocinema/src/AncillaryPages/domain/models/AncillaryPagesModel.dart';
import 'package:novocinema/src/AncillaryPages/domain/useCases/AncillarPagesUseCase.dart';
import 'package:novocinema/src/GiftCard/domain/models/AllGiftCardModel.dart';
import 'package:novocinema/src/GiftCard/domain/models/SendReceivedGiftCardModel.dart';
import 'package:novocinema/src/GiftCard/domain/useCases/BuyGiftCardUseCase.dart';
import 'package:novocinema/src/GiftCard/domain/useCases/GetAllGiftCardUseCase.dart';
import 'package:novocinema/src/GiftCard/domain/useCases/SendReceivedGiftCardUseCase.dart';

import '../../../../components/customcomp/coustom_tabbar.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/DataResult.dart';
import '../../../../core/resources/UseCase.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/utils/Logger.dart';

part 'AncillaryPagesEvent.dart';

part 'AncillaryPagesState.dart';

class AncillaryPagesBloc
    extends Bloc<AncillaryPagesEvent, AncillaryPagesState> {
  final AncillaryPagesUseCase ancillaryPagesUseCase;

  AncillaryPagesBloc(this.ancillaryPagesUseCase)
      : super(const AncillaryPagesState()) {
    on<ExperiencesDataRequestEvent>(_experiencesDataRequestEvent);
  }

  _experiencesDataRequestEvent(ExperiencesDataRequestEvent event,
      Emitter<AncillaryPagesState> emit) async {
    final experiencesData = await ancillaryPagesUseCase.call(event.key);

    switch (experiencesData) {
      case Success<AncillaryPagesModel>():
        emit(state.copyWith(
            loading: CurrentAppState.SUCCESS,
            experiencesData: experiencesData.data));
      case Error<AncillaryPagesModel>():
        emit(state.copyWith(
            loading: CurrentAppState.ERROR,
            appException: experiencesData.exception));
    }
  }

  // _experiencesDataRequestEvent(ExperiencesDataRequestEvent event,
  //     Emitter<AncillaryPagesState> emit) async {
  //   final experiencesData = await ancillaryPagesUseCase.call(event.key);
  //
  //   switch (experiencesData) {
  //     case Success<AncillaryPagesModel>():
  //       emit(state.copyWith(
  //           loading: CurrentAppState.SUCCESS,
  //           experiencesData: experiencesData.data));
  //     case Error<AncillaryPagesModel>():
  //       emit(state.copyWith(
  //           loading: CurrentAppState.ERROR,
  //           appException: experiencesData.exception));
  //   }
  // }
}
