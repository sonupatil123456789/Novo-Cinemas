part of 'HomeBloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}



class ClearQuickBookEvent extends HomeEvent {
  const ClearQuickBookEvent();

  @override
  List<Object> get props => [];
}

class SelectedQuickBookMovieEvent extends HomeEvent {
  final ChoiceChipData<QuickBookMoviesModel> quickBookMovie;
  const SelectedQuickBookMovieEvent(this.quickBookMovie);

  @override
  List<Object> get props => [quickBookMovie];
}
class SelectedQuickBookCinemaEvent extends HomeEvent {
  final ChoiceChipData<QuickBookCinemaModel> quickBookCinema;
  const SelectedQuickBookCinemaEvent(this.quickBookCinema);

  @override
  List<Object> get props => [quickBookCinema];
}
class SelectedQuickBookDateEvent extends HomeEvent {
  final ChoiceChipData<MapEntry<String,List<QuickBookSessionModel>>> quickBookDate;
  const SelectedQuickBookDateEvent(this.quickBookDate);

  @override
  List<Object> get props => [quickBookDate];
}
class SelectedQuickBookTimeEvent extends HomeEvent {
  final ChoiceChipData<QuickBookSessionModel> quickBookTime;
   SelectedQuickBookTimeEvent(this.quickBookTime);

  @override
  List<Object> get props => [quickBookTime];
}
class BuildSeatLayoutOnQuickBookTimeSelectedEvent extends HomeEvent {
  final ChoiceChipData<QuickBookSessionModel> showTime;
  final Function(String ,String) callBack;
  const BuildSeatLayoutOnQuickBookTimeSelectedEvent(this.showTime, this.callBack);

  @override
  List<Object> get props => [showTime,callBack];
}

class GetQuickBookEvent extends HomeEvent {
  final Map<String,dynamic> quickBookQuery;
  const GetQuickBookEvent(this.quickBookQuery);

  @override
  List<Object> get props => [];
}
class GetAllBannersEvent extends HomeEvent {
  const GetAllBannersEvent();

  @override
  List<Object> get props => [];
}


