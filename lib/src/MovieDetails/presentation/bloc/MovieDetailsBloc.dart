import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novocinema/core/resources/DataResult.dart';
import 'package:novocinema/src/Movies/domain/models/MovieModel.dart';

import '../../../../components/chips/CustomChoiceChips.dart';
import '../../../../core/resources/AppException.dart';
import '../../../../core/resources/enums.dart';
import '../../../../core/utils/Logger.dart';
import '../../domain/models/GetSessionModel.dart';
import '../../domain/models/MovieFiltersDataModel.dart';
import '../../../../entities/models/ShowTimeDetailsModel.dart';
import '../../domain/models/ShowTimesDataModel.dart';
import '../../domain/useCases/CreateSessionUseCase.dart';
import '../../domain/useCases/GetAvailableDatesUseCase.dart';
import '../../domain/useCases/GetMovieDetailsUseCase.dart';
import '../../domain/useCases/LikeDislikeUseCase.dart';

part 'MovieDetailsEvent.dart';
part 'MovieDetailsState.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final CreateSessionUseCase createSessionUseCase;
  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  final LikeDislikeUseCase likeDislikeUseCase;
  final GetAvailableDatesUseCase getAvailableDatesUseCase;

  MovieDetailsBloc(this.getMovieDetailsUseCase, this.createSessionUseCase,this.likeDislikeUseCase, this.getAvailableDatesUseCase)
      : super(MovieDetailsState()) {

    on<GetMovieDetailsEvent>(_getMovieDetailsEvent);
    on<GetMovieSessionEvent>(_getMovieSessionEvent);

    on<OnDateSelectedEvent>(_onDateSelectedEvent);
    on<OnMallTimeSelectedEvent>(_onMallTimeSelectedEvent);
    on<BuildSeatLayoutOnTimeSelectedEvent>(_buildSeatLayoutOnTimeSelectedEvent);
    on<ClearSessionStateEvent>(_clearSessionStateEvent);
    on<LikeDislikeEvent>(_likeDislikeEvent);

  }



  _clearSessionStateEvent(ClearSessionStateEvent event, Emitter<MovieDetailsState> emit)  {
    emit(MovieDetailsState());
    Logger.customLogData("Selected Date", state.selectedDate.toString());
  }

  _onMallTimeSelectedEvent(OnMallTimeSelectedEvent event, Emitter<MovieDetailsState> emit)  {
    Logger.customLogData("Selected Show Time at mall (${event.mallName})", event.showTime.toString());
    emit(state.copyWith(selectedTiming: event.showTime,selectedMallName: event.mallName));
    event.callback(state.selectedTiming!);
  }

  _buildSeatLayoutOnTimeSelectedEvent(BuildSeatLayoutOnTimeSelectedEvent event, Emitter<MovieDetailsState> emit) async {
    emit(state.copyWith(selectedTiming: event.showTime));
    event.callBack(state.selectedTiming!.sessionId!, state.selectedTiming!.cinemaId!.toString());
  }

  _onDateSelectedEvent(OnDateSelectedEvent event, Emitter<MovieDetailsState> emit)  {
    Logger.customLogData("Selected Date", event.date.toString());
    emit(state.copyWith(selectedDate: event.date));
  }



  _likeDislikeEvent(LikeDislikeEvent event, Emitter<MovieDetailsState> emit) async {
    emit(state.copyWith(likeDislikeState: CurrentAppState.LOADING));
    final likeDislikeData = await likeDislikeUseCase.call(LikeDislikeParams(event.data, event.url));
    switch (likeDislikeData) {
      case Success<Map<String, dynamic>>():
        emit(state.copyWith(likeDislikeState: CurrentAppState.SUCCESS));
        event.onSuccess(likeDislikeData.data);
      case Error<Map<String, dynamic>>():
        emit(state.copyWith(likeDislikeState: CurrentAppState.ERROR));
        event.onFailure(likeDislikeData.exception);
    }
  }

  _getMovieSessionEvent(GetMovieSessionEvent event, Emitter<MovieDetailsState> emit) async {
    emit(state.copyWith(showTimeDataState: CurrentAppState.LOADING));
    final sessionParams = GetSessionParams(event.movieId,event.sessionDate ,event.pageType);

    DataResult<GetSessionModel> createSession =await  createSessionUseCase(sessionParams);
    switch (createSession) {
      case Success<GetSessionModel>():
        emit(state.copyWith(
            showTimeDataState: CurrentAppState.SUCCESS,
            showTimeData: createSession.data.sessions,
            selectedDate: event.sessionDate
        ));
      case Error<GetSessionModel>():
        emit(state.copyWith(showTimeDataState: CurrentAppState.ERROR,appException: createSession.exception));
    }
  }

  _getMovieDetailsEvent(
      GetMovieDetailsEvent event, Emitter<MovieDetailsState> emit) async {
    emit(state.copyWith(loading: CurrentAppState.LOADING));



    Future<DataResult<MovieModel>> getMovieDetailsFuture = getMovieDetailsUseCase.call(event.movieId);
    Future<DataResult<Map<String,dynamic>>> getAvailableDatesFuture = getAvailableDatesUseCase.call(event.movieId);


    // Use Future.wait on the list of Futures
    List results = await Future.wait([getMovieDetailsFuture,getAvailableDatesFuture]);

    // Process results
    DataResult<MovieModel> getMovieDetails = results[0] as DataResult<MovieModel>;
    DataResult<Map<String,dynamic>> getAvailableDates = results[1] as DataResult<Map<String,dynamic>>;


    if (getMovieDetails is Success<MovieModel> &&getAvailableDates is Success<Map<String, dynamic>> ) {
      final List<String> dateList = (getAvailableDates.data['available_dates'] as List<dynamic>).map((date)=>date.toString()).toList();
      emit(state.copyWith(
          loading: CurrentAppState.SUCCESS,
          movieDetails: getMovieDetails.data,
          showTimeDateList:dateList
      ));

      await _getMovieSessionEvent(GetMovieSessionEvent(movieId: event.movieId, sessionDate: dateList.first, pageType: event.pageType), emit);

    } else if (getMovieDetails is Error<MovieModel>) {
      emit(state.copyWith(
        loading: CurrentAppState.ERROR,
        appException: getMovieDetails.exception,
      ));
    }else if (getAvailableDates is Error<Map<String, dynamic>>) {
      emit(state.copyWith(
        loading: CurrentAppState.ERROR,
        appException: getAvailableDates.exception,
      ));
    } else {
      emit(state.copyWith(
        loading: CurrentAppState.ERROR,
        appException: AppException(message: 'Unexpected error occurred',errorCode: ErrorCode.UNKNOWN_ERROR),
      ));
    }

  }


}
