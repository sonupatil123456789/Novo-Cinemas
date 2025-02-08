part of 'ShowTimeBloc.dart';

sealed class ShowTimeEvent extends Equatable {
  const ShowTimeEvent();

  @override
  List<Object> get props => [];
}

class OnDateSelectedEvent extends ShowTimeEvent {
  final String date;
  const OnDateSelectedEvent(this.date);

  @override
  List<Object> get props => [date];
}

class OnMallTimeSelectedEvent extends ShowTimeEvent {
  final ShowTimeDetailsModel showTime;
  final String mallName ;
  final ShowTimeMovieModel movieDetail ;
  final Function(ShowTimeDetailsModel) callback ;
  const OnMallTimeSelectedEvent( {required this.showTime,
    required this.mallName,
    required this.callback,
    required this.movieDetail});

  @override
  List<Object> get props => [showTime];
}

class BuildSeatLayoutOnShowTimeSelectedEvent  extends ShowTimeEvent{
  final ShowTimeDetailsModel showTime;
  final Function(String ,String) callBack;
  const BuildSeatLayoutOnShowTimeSelectedEvent(this.showTime, this.callBack);

  @override
  List<Object> get props => [showTime,callBack];

}


class GetAllMoviesWithSessionEvent extends ShowTimeEvent {

  const GetAllMoviesWithSessionEvent();

  @override
  List<Object> get props => [];
}


class ClearShowTimeSessionStateEvent extends ShowTimeEvent {

  const ClearShowTimeSessionStateEvent();
}




