import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/core/resources/enums.dart';
import 'package:novocinema/src/F&B/domain/models/ConcessionCategoryModel.dart';
import '../../../../components/chips/CustomChoiceChips.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/utils/Logger.dart';
import '../../domain/models/ConcessionItemModel.dart';
import '../../domain/useCases/CompleteFoodAndBevRageUseCase.dart';
import '../../domain/useCases/GetAllFoodAndBevRageUseCase.dart';
import '../components/F&BCartPopup.dart';

part 'F&BEvent.dart';

part 'F&BState.dart';

class FAndBBloc extends Bloc<FAndBEvent, FAndBState> {
  final GetAllFoodAndBevRageUseCase getAllFoodAndBevRageUseCase;

  final CompleteFoodAndBevRageUseCase completeFoodAndBevRageUseCase;

  FAndBBloc(this.getAllFoodAndBevRageUseCase, this.completeFoodAndBevRageUseCase)
      : super( FAndBState()) {

    on<GetAllFoodAndBevRageEvent>(_getAllFoodAndBevRageEvent);
    on<SelectedFAndBCategoryEvent>(_selectedFAndBCategoryEvent);
    on<CompleteFAndBEvent>(_completeFAndBEvent);
    on<AddConcessionItemWithPriceEvent>(_addConcessionItemWithPriceEvent);
    on<RemoveConcessionItemEvent>(_removeConcessionItemEvent);
    on<IncrementDecrementConcessionItemEvent>(_incrementDecrementConcessionItemEvent);
    on<ClearFAndBStateEvent>(_clearFAndBStateEvent);

  }

  _clearFAndBStateEvent(ClearFAndBStateEvent event , Emitter<FAndBState> emit){
    emit(FAndBState());
    Logger.customLogData("(FAndBScreen)", state.fnbConfirmationDetails);
  }

  _completeFAndBEvent(CompleteFAndBEvent event, Emitter<FAndBState> emit) async {
    emit(state.copyWith(fnbConfirmationState: CurrentAppState.LOADING));

    final fAndBListData = await completeFoodAndBevRageUseCase.call(CompleteFoodAndBevRageParams(event.data , event.postConcessionUrl));

    switch (fAndBListData) {
      case Success<Map<String, dynamic>>():
        final totalAmount = getTotalAmount(state.addConcessionItemList) ;
        emit(state.copyWith(fnbConfirmationState: CurrentAppState.SUCCESS,fnbConfirmationDetails: fAndBListData.data,totalFinalPrice:totalAmount ));
        event.onSuccess(fAndBListData.data);
      case Error<Map<String, dynamic>>():
        emit(state.copyWith(fnbConfirmationState: CurrentAppState.ERROR, appException: fAndBListData.exception));
        event.onFailure( fAndBListData.exception);
    }
  }

  _addConcessionItemWithPriceEvent(AddConcessionItemWithPriceEvent event, Emitter<FAndBState> emit) {
    final concessions = state.addConcessionItemList.map((item) => Map<String, dynamic>.from(item)).toList();
    if (concessions.any((element) => element['Id'] == event.addConcession['Id'])) {
      for (var element in concessions) {
        if (jsonEncode(element['Modifiers']) == jsonEncode(event.addConcession['Modifiers'])) {
          element['Quantity'] += event.addConcession['Quantity'];
        } else {
          concessions.add(event.addConcession);
        }
        break;
      }
    } else {
      concessions.add(event.addConcession);
    }
    event.onItemAdded(concessions);
    emit(state.copyWith(finalPrice: event.price, addConcessionItemList: concessions));
    Logger.customLogData("Final Price [${state.finalPrice}]", state.addConcessionItemList.toString());
  }

  _removeConcessionItemEvent(RemoveConcessionItemEvent event, Emitter<FAndBState> emit) {
    final concessions = List.of(state.addConcessionItemList);
    final index = concessions.indexWhere((element) => element['Id'] == event.concessionItem['Id'] && jsonEncode(element['Modifiers']) == jsonEncode(event.concessionItem['Modifiers']));

    concessions.removeAt(index);
    emit(state.copyWith(addConcessionItemList: concessions));
  }

  _incrementDecrementConcessionItemEvent(IncrementDecrementConcessionItemEvent event, Emitter<FAndBState> emit) {

    final concessions = state.addConcessionItemList.map((item) => Map<String, dynamic>.from(item)).toList();

    final index = concessions.indexWhere((element) {
      return element['Id'] == event.concession['Id'] &&
          jsonEncode(element['Modifiers']) == jsonEncode(event.concession['Modifiers']);
    });

    if (event.isIncrement) {
      ++concessions[index]['Quantity'];
    } else {
      final qty = --concessions[index]['Quantity'];
      if(concessions[index]['Quantity'] == 0){
        concessions.removeAt(index);
      }
    }


    print("into the bloc ${concessions}");

    emit(state.copyWith(addConcessionItemList: concessions));
  }

  _selectedFAndBCategoryEvent(SelectedFAndBCategoryEvent event, Emitter<FAndBState> emit) {
    List<ConcessionItemModel> data = [];
    for (var listData in state.fAndBDataList) {
      if (listData.vistaConcessionCategoryId == event.selectedCategory.Id) {
        data.addAll(listData.concessionItems!.toList());
      }
    }

    emit(state.copyWith(selectedChoiceChipData: event.selectedCategory, fAndBConcessionsList: data));

    Logger.customLogData(
      "Selected Category",
      state.selectedChoiceChipData.toString(),
    );
  }

  _getAllFoodAndBevRageEvent(GetAllFoodAndBevRageEvent event, Emitter<FAndBState> emit) async {
    emit(state.copyWith(loading: CurrentAppState.LOADING));
    final fAndBListData = await getAllFoodAndBevRageUseCase.call(event.cinemaId);

    switch (fAndBListData) {
      case Success<List<ConcessionCategoryModel>>():
        List<ConcessionItemModel> concessionData = [];
        List<ConcessionCategoryModel> concessionCategory = [];


        for (var listData in fAndBListData.data) {
          concessionData.addAll(listData.concessionItems!.toList());
        }

        final allFnb = ConcessionCategoryModel(name: "All", concessionItems: concessionData,vistaConcessionCategoryId: 1234);

        if(fAndBListData.data.isNotEmpty){
          concessionCategory.add(allFnb);
        }

        for (var listData in fAndBListData.data) {
          concessionCategory.add(listData);
        }

        emit(state.copyWith(
            loading: CurrentAppState.SUCCESS,
            fAndBDataList: concessionCategory,
            selectedChoiceChipData: ChoiceChipData<ConcessionCategoryModel>(1234, "All", allFnb),
            fAndBConcessionsList: concessionData));
      case Error<List<ConcessionCategoryModel>>():
        emit(state.copyWith(
            loading: CurrentAppState.ERROR,
            fAndBDataList: fAndBListData.data,
            appException: fAndBListData.exception));
    }
  }


}




// _selectedFAndBCategoryEvent(SelectedFAndBCategoryEvent event, Emitter<FAndBState> emit) {
//   if (state.selectedChoiceChipData == event.selectedCategory) {
//     List<ConcessionItemModel> data = [];
//     for (var listData in state.fAndBDataList) {
//       data.addAll(listData.concessionItems!.toList());
//     }
//     emit(state.copyWith( selectedChoiceChipData: ChoiceChipData(0, '', null), fAndBConcessionsList: data));
//   }
//   else {
//     List<ConcessionItemModel> data = [];
//     for (var listData in state.fAndBDataList) {
//       if (listData.vistaConcessionCategoryId == event.selectedCategory.Id) {
//         data.addAll(listData.concessionItems!.toList());
//       }
//     }
//     emit(state.copyWith(
//         selectedChoiceChipData: event.selectedCategory, fAndBConcessionsList: data));
//   }
//   Logger.customLogData(
//     "Selected Category",
//     state.selectedChoiceChipData.toString(),
//   );
// }