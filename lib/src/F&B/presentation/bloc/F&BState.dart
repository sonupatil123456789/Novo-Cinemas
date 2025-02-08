part of 'F&BBloc.dart';

class FAndBState extends Equatable {


  final CurrentAppState loading;
  final CurrentAppState fnbConfirmationState;
  final AppException? appException;
  ChoiceChipData<ConcessionCategoryModel>? selectedChoiceChipData ;
  final List<ConcessionCategoryModel> fAndBDataList;
  final List<ConcessionItemModel>fAndBConcessionsList ;
  final num finalPrice ;

  final num totalFinalPrice ;

   // confirming concession responce data
  final dynamic fnbConfirmationDetails ;


  // creat concession final data to send in backend server
  final List<Map<String,dynamic>> addConcessionItemList ;



   FAndBState(
      {
        this.fnbConfirmationDetails,
        // this.bookSelectedSeat = const[],
        this.fAndBDataList = const [],
        this.fAndBConcessionsList = const [],
        this.finalPrice = 0 ,
        this.addConcessionItemList = const [],
        this.selectedChoiceChipData,
        this.totalFinalPrice = 0 ,
        this.loading = CurrentAppState.INITIAL,
        this.fnbConfirmationState = CurrentAppState.INITIAL,
        this.appException});

  FAndBState copyWith(
      {dynamic fnbConfirmationDetails,
        ChoiceChipData<ConcessionCategoryModel>? selectedChoiceChipData,
        List<ConcessionCategoryModel>? fAndBDataList,
        num? finalPrice ,
        num? totalFinalPrice ,
        CurrentAppState? fnbConfirmationState,
        List<Map<String,dynamic>>? addConcessionItemList,
        List<ConcessionItemModel>? fAndBConcessionsList,
      AppException? appException,
      CurrentAppState? loading}) {
    return FAndBState(
        appException: appException ?? this.appException,
        selectedChoiceChipData : selectedChoiceChipData ??this.selectedChoiceChipData,
        fAndBDataList : fAndBDataList ?? this.fAndBDataList,
        addConcessionItemList : addConcessionItemList ?? this.addConcessionItemList ,
        fAndBConcessionsList : fAndBConcessionsList ??this.fAndBConcessionsList,
        fnbConfirmationState : fnbConfirmationState ??this.fnbConfirmationState,
        finalPrice: finalPrice ?? this.finalPrice ,
        totalFinalPrice: totalFinalPrice ?? this.totalFinalPrice,
        fnbConfirmationDetails :fnbConfirmationDetails ?? this.fnbConfirmationDetails,
        loading: loading ?? this.loading);
  }

  @override
  List<Object?> get props => [ loading,fnbConfirmationState,fnbConfirmationDetails, appException,fAndBDataList,selectedChoiceChipData,fAndBConcessionsList,finalPrice,addConcessionItemList,totalFinalPrice ];
}
