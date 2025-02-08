import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/core/resources/UseCase.dart';
import 'package:novocinema/src/ShowTime/domain/models/ShowTimeMoviesModel.dart';
import 'package:novocinema/src/ShowTime/domain/models/ShowTimeSessionModel.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/utils/Logger.dart';
import '../../../../entities/models/ShowTimeDetailsModel.dart';
import '../../domain/models/ShowTimeDataModel.dart';

import '../../domain/useCases/GetAllMoviesWithSessionUseCase.dart';


part 'ShowTimeEvent.dart';
part 'ShowTimeState.dart';

class ShowTimeBloc extends Bloc<ShowTimeEvent, ShowTimeState> {
  final GetAllMoviesWithSessionUseCase getAllMoviesWithSessionUseCase;


  ShowTimeBloc(this.getAllMoviesWithSessionUseCase)
      : super(ShowTimeState()) {


    on<GetAllMoviesWithSessionEvent>(_getAllMoviesWithSessionEvent);
    on<OnDateSelectedEvent>(_onDateSelectedEvent);
    on<OnMallTimeSelectedEvent>(_onMallTimeSelectedEvent);

    on<BuildSeatLayoutOnShowTimeSelectedEvent>(_buildSeatLayoutOnShowTimeSelectedEvent);
    on<ClearShowTimeSessionStateEvent>(_clearShowTimeSessionStateEvent);

  }

  _clearShowTimeSessionStateEvent(ClearShowTimeSessionStateEvent event, Emitter<ShowTimeState> emit)  {
    emit(ShowTimeState());
    Logger.customLogData("Selected Date", state.selectedDate.toString());
  }

  _buildSeatLayoutOnShowTimeSelectedEvent(BuildSeatLayoutOnShowTimeSelectedEvent event, Emitter<ShowTimeState> emit) async {
    emit(state.copyWith(selectedTiming: event.showTime));
    event.callBack(state.selectedTiming!.sessionId!, state.selectedTiming!.cinemaId!.toString());
  }

  _onMallTimeSelectedEvent(OnMallTimeSelectedEvent event, Emitter<ShowTimeState> emit)  {
    emit(state.copyWith(selectedTiming: event.showTime,selectedMallName: event.mallName,movieDetail: event.movieDetail));
    event.callback(state.selectedTiming!);
    Logger.customLogData("Selected Show Time at mall (${event.mallName})", '${state.selectedTiming.toString()} =====${state.movieDetail.toString()}');
  }


  _onDateSelectedEvent(OnDateSelectedEvent event, Emitter<ShowTimeState> emit)  {
    emit(state.copyWith(selectedDate: event.date));
    Logger.customLogData("Selected Date ${event}", state.selectedDate.toString());
  }



  _getAllMoviesWithSessionEvent(GetAllMoviesWithSessionEvent event, Emitter<ShowTimeState> emit) async {
    emit(state.copyWith(loading: CurrentAppState.LOADING));
    final allMoviesWithSessionData = await getAllMoviesWithSessionUseCase.call(EmptyParams());
    switch (allMoviesWithSessionData) {
      case Success<ShowTimeSessionModel>():
       final selectInitialDate = allMoviesWithSessionData.data.sessions?.showTimesData?.entries.first.key;

        emit(state.copyWith(loading: CurrentAppState.SUCCESS,showTimeData: allMoviesWithSessionData.data.sessions, selectedDate: selectInitialDate));
      case Error<ShowTimeSessionModel>():
        emit(state.copyWith(loading: CurrentAppState.ERROR,appException: allMoviesWithSessionData.exception));
    }
  }




}
