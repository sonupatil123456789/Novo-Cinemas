part of 'MovieDetailsBloc.dart';

sealed class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();

  @override
  List<Object> get props => [];
}


// class CreateSessionEvent extends MovieDetailsEvent {
//   final String movieId;
//   const CreateSessionEvent(this.movieId);
//
//   @override
//   List<Object> get props => [movieId];
// }

class GetMovieDetailsEvent extends MovieDetailsEvent {
  final String movieId;
  final DetailPageType pageType;


  const GetMovieDetailsEvent({
    required this.movieId,
    required this.pageType
  });

  @override
  List<Object> get props => [movieId,pageType];
}


enum DetailPageType {
  BOOKING_FLOW,
  PRIVATE_BOOKING
}

class GetMovieSessionEvent extends MovieDetailsEvent {
  final String movieId;
  final String sessionDate ;
  final DetailPageType pageType;

  const GetMovieSessionEvent({
    required this.movieId,
    required this.pageType,
    required this.sessionDate
  });

  @override
  List<Object> get props => [movieId,pageType,sessionDate];
}

class OnDateSelectedEvent extends MovieDetailsEvent {
  final String date;
  const OnDateSelectedEvent(this.date);

  @override
  List<Object> get props => [date];
}

class OnMallTimeSelectedEvent extends MovieDetailsEvent {
  final ShowTimeDetailsModel showTime;
  final String mallName ;
  final Function(ShowTimeDetailsModel) callback ;
  const OnMallTimeSelectedEvent(
      {required this.showTime,required this.mallName,required this.callback});

  @override
  List<Object> get props => [showTime,mallName,callback];
}

class BuildSeatLayoutOnTimeSelectedEvent extends MovieDetailsEvent {
  final ShowTimeDetailsModel showTime;
  final Function(String ,String) callBack;
  const BuildSeatLayoutOnTimeSelectedEvent(this.showTime, this.callBack);

  @override
  List<Object> get props => [showTime,callBack];
}

class ClearSessionStateEvent extends MovieDetailsEvent {

  const ClearSessionStateEvent();
}

class LikeDislikeEvent extends MovieDetailsEvent {
  final String url ;
  final Map<String,dynamic> data ;
  final Function(Map<String,dynamic>) onSuccess ;
  final Function(AppException) onFailure ;

  const LikeDislikeEvent({required this.data , required this.url,required this.onFailure,required this.onSuccess });

  @override
  List<Object> get props => [data,url,onSuccess, onFailure];
}

class SelectedLocationEvent extends MovieDetailsEvent {
  final ChoiceChipData selectedLocation;
  const SelectedLocationEvent(this.selectedLocation);

  @override
  List<Object> get props => [selectedLocation];
}

class SelectedExperienceEvent extends MovieDetailsEvent {
  final ChoiceChipData selectedExperience;
  const SelectedExperienceEvent(this.selectedExperience);

  @override
  List<Object> get props => [selectedExperience];
}

class SelectedTimingEvent extends MovieDetailsEvent {
  final ChoiceChipData selectedTiming;
  const SelectedTimingEvent(this.selectedTiming);

  @override
  List<Object> get props => [selectedTiming];
}

class ClearMovieFilters extends MovieDetailsEvent {
  const ClearMovieFilters();
}




