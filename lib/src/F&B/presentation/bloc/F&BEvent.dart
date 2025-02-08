part of 'F&BBloc.dart';

sealed class FAndBEvent extends Equatable {
  const FAndBEvent();

  @override
  List<Object> get props => [];
}

class CompleteFAndBEvent extends FAndBEvent {
  final Map<String,dynamic> data;
  final String postConcessionUrl ;
  final Function(dynamic) onSuccess;
  final Function(AppException) onFailure;

  const CompleteFAndBEvent(
      {required this.data,
        required  this.postConcessionUrl ,
      required this.onFailure,
      required this.onSuccess});

  @override
  List<Object> get props => [postConcessionUrl,data,onSuccess,onFailure];
}

class AddConcessionItemWithPriceEvent extends FAndBEvent {
  final Map<String, dynamic> addConcession;
  final num price;
  final Function onItemAdded;
  const AddConcessionItemWithPriceEvent(
      {required this.addConcession, required this.price, required this.onItemAdded});

  @override
  List<Object> get props => [addConcession, price,onItemAdded];
}

class RemoveConcessionItemEvent extends FAndBEvent {
  final Map<String, dynamic> concessionItem;

  const RemoveConcessionItemEvent(this.concessionItem);

  @override
  List<Object> get props => [concessionItem];
}

class IncrementDecrementConcessionItemEvent extends FAndBEvent {
  final Map<String, dynamic> concession;
  final bool isIncrement;

  const IncrementDecrementConcessionItemEvent({required this.concession, required this.isIncrement});

  @override
  List<Object> get props => [concession];
}

class SelectedFAndBCategoryEvent extends FAndBEvent {
  final ChoiceChipData<ConcessionCategoryModel> selectedCategory;

  const SelectedFAndBCategoryEvent(this.selectedCategory);

  @override
  List<Object> get props => [selectedCategory];
}

class GetAllFoodAndBevRageEvent extends FAndBEvent {
  final String cinemaId;

  const GetAllFoodAndBevRageEvent(this.cinemaId);

  @override
  List<Object> get props => [cinemaId];
}

// class OnFAndBSubItemsSelectedEvent extends FAndBEvent {
//   final Map<String,dynamic> selectedItems ;
//   final int maxTotalQuantity ;
//
//   const OnFAndBSubItemsSelectedEvent(this.selectedItems,this.maxTotalQuantity);
//
//   @override
//   List<Object> get props => [selectedItems,maxTotalQuantity];
// }

// class OnFAndBContinueEvent extends FAndBEvent {
//   const OnFAndBContinueEvent();
//
//   @override
//   List<Object> get props => [];
// }

class ClearFAndBStateEvent extends FAndBEvent {
  const ClearFAndBStateEvent();

  @override
  List<Object> get props => [];
}



